import 'package:flutter_test/flutter_test.dart';
import 'package:piston/data/repositorio_memoria.dart';
import 'package:piston/models/cliente.dart';
import 'package:piston/models/orden_servicio.dart';
import 'package:piston/models/repuesto.dart';
import 'package:piston/router/app_state.dart';

Future<({AppState estado, RepositorioMemoria repositorio})>
crearEstado() async {
  final repositorio = RepositorioMemoria();
  final estado = AppState(repositorio: repositorio);
  await estado.cargar();
  return (estado: estado, repositorio: repositorio);
}

void main() {
  group('Datos iniciales y reportes', () {
    test('carga los datos demo con los totales esperados', () async {
      final datos = await crearEstado();
      final estado = datos.estado;

      expect(estado.clientes.length, 6);
      expect(estado.vehiculos.length, 8);
      expect(estado.repuestos.length, 12);
      expect(estado.ordenes.length, 8);
      expect(estado.ordenesAbiertas.length, 4);
      expect(estado.ordenes.where((item) => item.entregada).length, 3);
      expect(estado.ordenes.where((item) => item.cancelada).length, 1);
      expect(estado.repuestosBajos.length, 3);
      expect(estado.saldoTotal, closeTo(98300, 0.01));

      final ahora = DateTime.now();
      final desde = DateTime(
        ahora.year,
        ahora.month,
        ahora.day,
      ).subtract(const Duration(days: 59));
      final hasta = DateTime(ahora.year, ahora.month, ahora.day + 1);

      expect(estado.facturadoEntre(desde, hasta), closeTo(230800, 0.01));
      expect(estado.cobradoEntre(desde, hasta), closeTo(188800, 0.01));
      expect(estado.saldoDeCliente('c2'), closeTo(42000, 0.01));
      expect(estado.saldoDeCliente('c6'), 0);
    });

    test('los reportes de 30 días toman solo el período', () async {
      final datos = await crearEstado();
      final estado = datos.estado;
      final ahora = DateTime.now();
      final desde = DateTime(
        ahora.year,
        ahora.month,
        ahora.day,
      ).subtract(const Duration(days: 29));
      final hasta = DateTime(ahora.year, ahora.month, ahora.day + 1);

      expect(estado.facturadoEntre(desde, hasta), closeTo(162300, 0.01));
      expect(estado.cobradoEntre(desde, hasta), closeTo(120300, 0.01));
    });
  });

  group('Órdenes', () {
    test('crea una orden y actualiza el kilometraje del vehículo', () async {
      final datos = await crearEstado();
      final estado = datos.estado;

      final resultado = estado.crearOrden(
        idCliente: 'c1',
        idVehiculo: 'v1',
        idMecanico: 'm1',
        problema: 'Revisar pérdida de aceite en el motor',
        kilometraje: 85000,
      );

      expect(resultado.ok, isTrue);
      final orden = resultado.valor!;
      expect(orden.numero, 9);
      expect(orden.estado, EstadoOrden.recibida);
      expect(orden.total, 0);
      expect(orden.abierta, isTrue);
      expect(estado.vehiculoPorId('v1')!.kilometraje, 85000);
      expect(estado.ordenesAbiertas.length, 5);
    });

    test('rechaza una orden con vehículo de otro cliente', () async {
      final datos = await crearEstado();
      final estado = datos.estado;

      final resultado = estado.crearOrden(
        idCliente: 'c2',
        idVehiculo: 'v1',
        idMecanico: 'm1',
        problema: 'Revisar frenos',
      );

      expect(resultado.ok, isFalse);
      expect(resultado.error, contains('no pertenece'));
    });

    test('agrega y quita repuestos descontando stock', () async {
      final datos = await crearEstado();
      final estado = datos.estado;
      final stockInicial = estado.repuestoPorId('r2')!.existencias;

      expect(estado.agregarRepuesto('o6', 'r2', 2), isNull);
      expect(estado.repuestoPorId('r2')!.existencias, stockInicial - 2);
      final orden = estado.ordenPorId('o6')!;
      expect(orden.totalRepuestos, closeTo(9600, 0.01));
      expect(orden.total, closeTo(9600, 0.01));

      expect(estado.eliminarRepuestoUsado('o6', 'r2'), isNull);
      expect(estado.repuestoPorId('r2')!.existencias, stockInicial);
      expect(estado.ordenPorId('o6')!.repuestos, isEmpty);
    });

    test('no permite usar más stock del disponible', () async {
      final datos = await crearEstado();
      final estado = datos.estado;

      final error = estado.agregarRepuesto('o6', 'r9', 5);
      expect(error, contains('Stock insuficiente'));
      expect(estado.repuestoPorId('r9')!.existencias, 1);
    });

    test('agrega mano de obra y valida el precio', () async {
      final datos = await crearEstado();
      final estado = datos.estado;

      expect(estado.agregarManoObra('o6', 'Cambio de batería', 12000), isNull);
      expect(estado.ordenPorId('o6')!.totalManoObra, 12000);
      expect(estado.agregarManoObra('o6', 'Prueba', 0), isNotNull);
    });

    test('registra pagos parciales y controla el saldo', () async {
      final datos = await crearEstado();
      final estado = datos.estado;
      final orden = estado.ordenPorId('o3')!;
      expect(orden.total, closeTo(38500, 0.01));
      expect(orden.saldo, closeTo(38500, 0.01));

      expect(estado.registrarPago('o3', 10000, 'Efectivo'), isNull);
      expect(estado.ordenPorId('o3')!.pagado, 10000);
      expect(estado.ordenPorId('o3')!.saldo, closeTo(28500, 0.01));

      final error = estado.registrarPago('o3', 50000, 'Transferencia');
      expect(error, contains('supera el saldo'));
    });

    test('respeta el orden de los estados y la cancelación', () async {
      final datos = await crearEstado();
      final estado = datos.estado;

      expect(
        estado.cambiarEstadoOrden('o5', EstadoOrden.lista),
        contains('Primero debe pasar'),
      );
      expect(estado.cambiarEstadoOrden('o5', EstadoOrden.reparacion), isNull);
      expect(estado.ordenPorId('o5')!.estado, EstadoOrden.reparacion);

      expect(estado.cambiarEstadoOrden('o4', EstadoOrden.cancelada), isNull);
      expect(estado.ordenPorId('o4')!.estado, EstadoOrden.cancelada);
    });

    test('al cancelar devuelve el stock de los repuestos usados', () async {
      final datos = await crearEstado();
      final estado = datos.estado;
      final stock = estado.repuestoPorId('r2')!.existencias;

      final creada = estado.crearOrden(
        idCliente: 'c1',
        idVehiculo: 'v1',
        idMecanico: 'm1',
        problema: 'Cambio de filtro de aceite',
      );
      final id = creada.valor!.id;
      expect(estado.agregarRepuesto(id, 'r2', 1), isNull);
      expect(estado.repuestoPorId('r2')!.existencias, stock - 1);

      expect(estado.cambiarEstadoOrden(id, EstadoOrden.cancelada), isNull);
      expect(estado.ordenPorId(id)!.stockDevuelto, isTrue);
      expect(estado.repuestoPorId('r2')!.existencias, stock);
    });

    test('no cancela una orden con pagos', () async {
      final datos = await crearEstado();
      final estado = datos.estado;

      final error = estado.cambiarEstadoOrden('o2', EstadoOrden.cancelada);
      expect(error, isNotNull);
      expect(estado.ordenPorId('o2')!.estado, EstadoOrden.entregada);
    });
  });

  group('Clientes, vehículos e inventario', () {
    test('valida y guarda un cliente nuevo', () async {
      final datos = await crearEstado();
      final estado = datos.estado;
      final cliente = Cliente(
        id: 'c99',
        nombre: 'Ana Pérez',
        telefono: '351 555-0101',
        direccion: '  Av. Siempre Viva 742  ',
        creadoEn: DateTime.now(),
      );

      expect(estado.guardarCliente(cliente), isNull);
      expect(estado.clientePorId('c99')!.nombre, 'Ana Pérez');
      expect(estado.clientePorId('c99')!.telefono, '3515550101');
      expect(estado.clientePorId('c99')!.direccion, 'Av. Siempre Viva 742');
      expect(estado.guardarCliente(cliente.copyWithNombre('')), isNotNull);
    });

    test('no elimina clientes con órdenes ni repuestos usados', () async {
      final datos = await crearEstado();
      final estado = datos.estado;

      expect(estado.eliminarCliente('c1'), contains('órdenes'));
      expect(estado.eliminarRepuesto('r5'), contains('órdenes'));
    });

    test('valida repuestos y detecta códigos repetidos', () async {
      final datos = await crearEstado();
      final estado = datos.estado;
      final nuevo = Repuesto(
        id: 'r99',
        codigo: 'fil-ace',
        nombre: 'Filtro repetido',
        precio: 5000,
        existencias: 3,
        stockMinimo: 1,
      );

      expect(estado.guardarRepuesto(nuevo), contains('Ya existe'));
      nuevo.codigo = 'NUE-001';
      expect(estado.guardarRepuesto(nuevo), isNull);
      expect(estado.repuestoPorId('r99')!.codigo, 'NUE-001');
    });
  });

  test('persiste y recupera los cambios desde el repositorio', () async {
    final datos = await crearEstado();
    final estado = datos.estado;

    final creada = estado.crearOrden(
      idCliente: 'c3',
      idVehiculo: 'v4',
      idMecanico: 'm2',
      problema: 'Cambio de correa de distribución',
    );
    await estado.persistir();
    expect(datos.repositorio.guardados, greaterThan(0));

    final recuperado = AppState(repositorio: datos.repositorio);
    await recuperado.cargar();
    expect(recuperado.ordenes.length, 9);
    expect(recuperado.ordenPorId(creada.valor!.id), isNotNull);
    expect(
      recuperado.ordenPorId(creada.valor!.id)!.problema,
      contains('correa'),
    );
  });
}

extension on Cliente {
  Cliente copyWithNombre(String nombre) => Cliente(
    id: id,
    nombre: nombre,
    telefono: telefono,
    direccion: direccion,
    creadoEn: creadoEn,
  );
}
