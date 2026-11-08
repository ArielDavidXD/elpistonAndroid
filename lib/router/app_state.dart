import 'package:flutter/foundation.dart';

import '../data/datos_taller.dart';
import '../data/demo_data.dart';
import '../data/repositorio_taller.dart';
import '../models/cliente.dart';
import '../models/mecanico.dart';
import '../models/orden_servicio.dart';
import '../models/repuesto.dart';
import '../models/vehiculo.dart';
import '../utils/formato.dart';
import '../utils/resultado.dart';

/// Fuente de verdad de la aplicación.
///
/// Los ViewModels escuchan este ChangeNotifier. Cada mutación actualiza las
/// listas en memoria, avisa a la UI y encola una escritura atómica en Drift.
class AppState extends ChangeNotifier {
  AppState({required this.repositorio});

  final RepositorioTaller repositorio;

  List<Cliente> clientes = [];
  List<Vehiculo> vehiculos = [];
  List<Mecanico> mecanicos = [];
  List<Repuesto> repuestos = [];
  List<OrdenServicio> ordenes = [];

  bool _cargado = false;
  int _secuencia = 0;
  Future<void> _colaGuardado = Future.value();

  bool get cargado => _cargado;

  Future<void> cargar() async {
    DatosTaller? datos;
    try {
      datos = await repositorio.cargar();
    } catch (_) {
      // Si la base está dañada se vuelve a los datos de ejemplo.
    }

    if (datos != null && !datos.vacio) {
      clientes = datos.clientes;
      vehiculos = datos.vehiculos;
      mecanicos = datos.mecanicos;
      repuestos = datos.repuestos;
      ordenes = datos.ordenes;
      _cargado = true;
      notifyListeners();
      return;
    }

    final demo = crearDatosDemo();
    clientes = demo.clientes;
    vehiculos = demo.vehiculos;
    mecanicos = demo.mecanicos;
    repuestos = demo.repuestos;
    ordenes = demo.ordenes;
    _cargado = true;
    await persistir();
    notifyListeners();
  }

  Future<void> persistir() {
    final fotografia = _fotografia();
    final tarea = _colaGuardado.then((_) => _guardar(fotografia));
    _colaGuardado = tarea;
    return tarea;
  }

  Future<void> _guardar(DatosTaller datos) async {
    try {
      await repositorio.guardar(datos);
    } catch (_) {
      // La app sigue funcionando en memoria si falla una escritura.
    }
  }

  void _cambio() {
    notifyListeners();
    final fotografia = _fotografia();
    _colaGuardado = _colaGuardado.then((_) => _guardar(fotografia));
  }

  DatosTaller _fotografia() => DatosTaller(
    clientes: clientes
        .map(
          (item) => Cliente(
            id: item.id,
            nombre: item.nombre,
            telefono: item.telefono,
            direccion: item.direccion,
            creadoEn: item.creadoEn,
          ),
        )
        .toList(),
    vehiculos: vehiculos
        .map(
          (item) => Vehiculo(
            id: item.id,
            idCliente: item.idCliente,
            matricula: item.matricula,
            marca: item.marca,
            modelo: item.modelo,
            anio: item.anio,
            kilometraje: item.kilometraje,
            actualizadoEn: item.actualizadoEn,
          ),
        )
        .toList(),
    mecanicos: mecanicos
        .map(
          (item) => Mecanico(
            id: item.id,
            nombre: item.nombre,
            especialidad: item.especialidad,
          ),
        )
        .toList(),
    repuestos: repuestos
        .map(
          (item) => Repuesto(
            id: item.id,
            codigo: item.codigo,
            nombre: item.nombre,
            precio: item.precio,
            existencias: item.existencias,
            stockMinimo: item.stockMinimo,
          ),
        )
        .toList(),
    ordenes: ordenes
        .map(
          (item) => OrdenServicio(
            id: item.id,
            numero: item.numero,
            idCliente: item.idCliente,
            idVehiculo: item.idVehiculo,
            idMecanico: item.idMecanico,
            fechaIngreso: item.fechaIngreso,
            problema: item.problema,
            estado: item.estado,
            kilometrajeIngreso: item.kilometrajeIngreso,
            manoObra: List.of(item.manoObra),
            repuestos: List.of(item.repuestos),
            pagos: List.of(item.pagos),
            fechaEntrega: item.fechaEntrega,
            stockDevuelto: item.stockDevuelto,
            actualizadoEn: item.actualizadoEn,
          ),
        )
        .toList(),
  );

  // ---------------------------------------------------------------------------
  // Búsquedas
  // ---------------------------------------------------------------------------

  Cliente? clientePorId(String id) {
    for (final item in clientes) {
      if (item.id == id) return item;
    }
    return null;
  }

  Vehiculo? vehiculoPorId(String id) {
    for (final item in vehiculos) {
      if (item.id == id) return item;
    }
    return null;
  }

  Mecanico? mecanicoPorId(String id) {
    for (final item in mecanicos) {
      if (item.id == id) return item;
    }
    return null;
  }

  Repuesto? repuestoPorId(String id) {
    for (final item in repuestos) {
      if (item.id == id) return item;
    }
    return null;
  }

  OrdenServicio? ordenPorId(String id) {
    for (final item in ordenes) {
      if (item.id == id) return item;
    }
    return null;
  }

  List<Vehiculo> vehiculosDeCliente(String idCliente) {
    final lista = vehiculos
        .where((item) => item.idCliente == idCliente)
        .toList();
    lista.sort((a, b) => a.matricula.compareTo(b.matricula));
    return lista;
  }

  List<OrdenServicio> ordenesDeCliente(String idCliente) {
    final lista = ordenes.where((item) => item.idCliente == idCliente).toList();
    lista.sort((a, b) => b.fechaIngreso.compareTo(a.fechaIngreso));
    return lista;
  }

  List<OrdenServicio> ordenesDeVehiculo(String idVehiculo) {
    final lista = ordenes
        .where((item) => item.idVehiculo == idVehiculo)
        .toList();
    lista.sort((a, b) => b.fechaIngreso.compareTo(a.fechaIngreso));
    return lista;
  }

  List<OrdenServicio> get ordenesAbiertas {
    final lista = ordenes.where((item) => item.abierta).toList();
    lista.sort((a, b) => b.fechaIngreso.compareTo(a.fechaIngreso));
    return lista;
  }

  List<Repuesto> get repuestosBajos {
    final lista = repuestos.where((item) => item.bajoStock).toList();
    lista.sort((a, b) => a.existencias.compareTo(b.existencias));
    return lista;
  }

  double get valorInventario => repuestos.fold(
    0.0,
    (total, item) => total + item.precio * item.existencias,
  );

  double saldoDeCliente(String idCliente) =>
      ordenesDeCliente(idCliente)
          .where((item) => !item.cancelada)
          .fold(0.0, (total, item) => total + item.saldo);

  double get saldoTotal => ordenes
      .where((item) => !item.cancelada)
      .fold(0.0, (total, item) => total + item.saldo);

  int get totalOrdenes => ordenes.length;

  int get proximoNumeroOrden {
    var mayor = 0;
    for (final item in ordenes) {
      if (item.numero > mayor) mayor = item.numero;
    }
    return mayor + 1;
  }

  int cargaDeMecanico(String idMecanico) => ordenes
      .where((item) => item.idMecanico == idMecanico && item.abierta)
      .length;

  Map<EstadoOrden, int> get cantidadesPorEstado {
    final mapa = {for (final estado in EstadoOrden.values) estado: 0};
    for (final item in ordenes) {
      mapa[item.estado] = (mapa[item.estado] ?? 0) + 1;
    }
    return mapa;
  }

  List<OrdenServicio> ordenesAbiertasDeMecanico(String idMecanico) =>
      ordenesAbiertas.where((item) => item.idMecanico == idMecanico).toList();

  // ---------------------------------------------------------------------------
  // Reportes
  // ---------------------------------------------------------------------------

  bool _enRango(DateTime fecha, DateTime desde, DateTime hasta) =>
      !fecha.isBefore(desde) && fecha.isBefore(hasta);

  List<OrdenServicio> entregadasEntre(DateTime desde, DateTime hasta) {
    return ordenes.where((item) {
      final entrega = item.fechaEntrega;
      return item.entregada &&
          entrega != null &&
          _enRango(entrega, desde, hasta);
    }).toList();
  }

  double facturadoEntre(DateTime desde, DateTime hasta) => entregadasEntre(
    desde,
    hasta,
  ).fold(0.0, (total, item) => total + item.total);

  List<Pago> pagosEntre(DateTime desde, DateTime hasta) {
    final lista = <Pago>[];
    for (final orden in ordenes) {
      if (orden.cancelada) continue;
      for (final pago in orden.pagos) {
        if (_enRango(pago.fecha, desde, hasta)) lista.add(pago);
      }
    }
    return lista;
  }

  double cobradoEntre(DateTime desde, DateTime hasta) =>
      pagosEntre(desde, hasta).fold(0.0, (total, pago) => total + pago.monto);

  List<Cliente> get clientesConDeuda {
    final lista = clientes
        .where((cliente) => saldoDeCliente(cliente.id) > 0.009)
        .toList();
    lista.sort((a, b) => saldoDeCliente(b.id).compareTo(saldoDeCliente(a.id)));
    return lista;
  }

  // ---------------------------------------------------------------------------
  // Órdenes
  // ---------------------------------------------------------------------------

  String _nuevoId() {
    _secuencia++;
    return '${DateTime.now().microsecondsSinceEpoch}_$_secuencia';
  }

  Resultado<OrdenServicio> crearOrden({
    required String idCliente,
    required String idVehiculo,
    required String idMecanico,
    required String problema,
    int? kilometraje,
  }) {
    if (clientePorId(idCliente) == null) {
      return const Resultado.fallo('Selecciona un cliente.');
    }

    final vehiculo = vehiculoPorId(idVehiculo);
    if (vehiculo == null) {
      return const Resultado.fallo('Selecciona un vehículo.');
    }
    if (vehiculo.idCliente != idCliente) {
      return const Resultado.fallo(
        'El vehículo no pertenece al cliente seleccionado.',
      );
    }
    if (mecanicoPorId(idMecanico) == null) {
      return const Resultado.fallo('Selecciona un mecánico.');
    }

    final descripcion = problema.trim();
    if (descripcion.length < 5) {
      return const Resultado.fallo(
        'Describe el problema reportado (mínimo 5 caracteres).',
      );
    }

    if (kilometraje != null) {
      if (kilometraje < 0) {
        return const Resultado.fallo('El kilometraje no puede ser negativo.');
      }
      if (kilometraje < vehiculo.kilometraje) {
        return Resultado.fallo(
          'El kilometraje no puede ser menor al último registrado '
          '(${vehiculo.kilometraje} km).',
        );
      }
    }

    final ahora = DateTime.now();
    final orden = OrdenServicio(
      id: _nuevoId(),
      numero: proximoNumeroOrden,
      idCliente: idCliente,
      idVehiculo: idVehiculo,
      idMecanico: idMecanico,
      fechaIngreso: ahora,
      problema: descripcion,
      estado: EstadoOrden.recibida,
      kilometrajeIngreso: kilometraje,
      manoObra: [],
      repuestos: [],
      pagos: [],
      fechaEntrega: null,
      stockDevuelto: false,
      actualizadoEn: ahora,
    );

    if (kilometraje != null && kilometraje > vehiculo.kilometraje) {
      vehiculo.kilometraje = kilometraje;
      vehiculo.actualizadoEn = ahora;
    }

    ordenes.add(orden);
    _cambio();
    return Resultado.ok(orden);
  }

  String? cambiarEstadoOrden(String idOrden, EstadoOrden destino) {
    final orden = ordenPorId(idOrden);
    if (orden == null) return 'La orden ya no existe.';

    if (destino == EstadoOrden.cancelada) {
      if (!orden.abierta) {
        return 'Solo se pueden cancelar órdenes abiertas.';
      }
      if (orden.pagos.isNotEmpty) {
        return 'No se puede cancelar una orden con pagos registrados.';
      }
      if (!orden.stockDevuelto) {
        for (final usado in orden.repuestos) {
          repuestoPorId(usado.idRepuesto)?.existencias += usado.cantidad;
        }
        orden.stockDevuelto = true;
      }
      orden.estado = EstadoOrden.cancelada;
      orden.actualizadoEn = DateTime.now();
      _cambio();
      return null;
    }

    final esperado = orden.estado.siguiente;
    if (esperado == null) {
      return 'La orden ya está ${orden.estado.etiqueta.toLowerCase()}.';
    }
    if (destino != esperado) {
      return 'Primero debe pasar a ${esperado.etiqueta}.';
    }

    orden.estado = destino;
    orden.actualizadoEn = DateTime.now();
    if (destino == EstadoOrden.entregada) {
      orden.fechaEntrega = DateTime.now();
    }
    _cambio();
    return null;
  }

  String? agregarManoObra(String idOrden, String descripcion, double precio) {
    final orden = ordenPorId(idOrden);
    if (orden == null) return 'La orden ya no existe.';
    if (!orden.abierta) return 'La orden está cerrada y no admite cambios.';

    final texto = descripcion.trim();
    if (texto.length < 3) return 'Describe el trabajo realizado.';
    if (precio <= 0) return 'El precio debe ser mayor a cero.';

    orden.manoObra.add(
      TrabajoManoObra(id: _nuevoId(), descripcion: texto, precio: precio),
    );
    orden.actualizadoEn = DateTime.now();
    _cambio();
    return null;
  }

  String? eliminarManoObra(String idOrden, String idTrabajo) {
    final orden = ordenPorId(idOrden);
    if (orden == null) return 'La orden ya no existe.';
    if (!orden.abierta) return 'La orden está cerrada y no admite cambios.';
    orden.manoObra.removeWhere((item) => item.id == idTrabajo);
    orden.actualizadoEn = DateTime.now();
    _cambio();
    return null;
  }

  String? agregarRepuesto(String idOrden, String idRepuesto, int cantidad) {
    final orden = ordenPorId(idOrden);
    if (orden == null) return 'La orden ya no existe.';
    if (!orden.abierta) return 'La orden está cerrada y no admite cambios.';
    if (cantidad <= 0) return 'La cantidad debe ser mayor a cero.';

    final repuesto = repuestoPorId(idRepuesto);
    if (repuesto == null) return 'El repuesto no existe.';
    if (repuesto.existencias < cantidad) {
      return 'Stock insuficiente: quedan ${repuesto.existencias} unidades.';
    }

    final indice = orden.repuestos.indexWhere(
      (item) => item.idRepuesto == idRepuesto,
    );
    if (indice >= 0) {
      final actual = orden.repuestos[indice];
      orden.repuestos[indice] = RepuestoUsado(
        idRepuesto: actual.idRepuesto,
        codigo: actual.codigo,
        nombre: actual.nombre,
        cantidad: actual.cantidad + cantidad,
        precioUnitario: actual.precioUnitario,
      );
    } else {
      orden.repuestos.add(
        RepuestoUsado(
          idRepuesto: repuesto.id,
          codigo: repuesto.codigo,
          nombre: repuesto.nombre,
          cantidad: cantidad,
          precioUnitario: repuesto.precio,
        ),
      );
    }

    repuesto.existencias -= cantidad;
    orden.actualizadoEn = DateTime.now();
    _cambio();
    return null;
  }

  String? eliminarRepuestoUsado(String idOrden, String idRepuesto) {
    final orden = ordenPorId(idOrden);
    if (orden == null) return 'La orden ya no existe.';
    if (!orden.abierta) return 'La orden está cerrada y no admite cambios.';

    final indice = orden.repuestos.indexWhere(
      (item) => item.idRepuesto == idRepuesto,
    );
    if (indice == -1) return 'El repuesto ya no está en la orden.';

    final usado = orden.repuestos.removeAt(indice);
    if (!orden.stockDevuelto) {
      repuestoPorId(usado.idRepuesto)?.existencias += usado.cantidad;
    }
    orden.actualizadoEn = DateTime.now();
    _cambio();
    return null;
  }

  String? registrarPago(String idOrden, double monto, String metodo) {
    final orden = ordenPorId(idOrden);
    if (orden == null) return 'La orden ya no existe.';
    if (orden.cancelada) return 'La orden está cancelada.';
    if (monto <= 0) return 'El monto debe ser mayor a cero.';
    if (monto > orden.saldo + 0.009) {
      return 'El monto supera el saldo pendiente (${dinero(orden.saldo)}).';
    }
    if (metodo.trim().isEmpty) return 'Selecciona un medio de pago.';

    orden.pagos.add(
      Pago(
        id: _nuevoId(),
        monto: monto,
        fecha: DateTime.now(),
        metodo: metodo.trim(),
      ),
    );
    orden.actualizadoEn = DateTime.now();
    _cambio();
    return null;
  }

  String? eliminarPago(String idOrden, String idPago) {
    final orden = ordenPorId(idOrden);
    if (orden == null) return 'La orden ya no existe.';
    if (orden.cancelada) return 'La orden está cancelada.';
    orden.pagos.removeWhere((item) => item.id == idPago);
    orden.actualizadoEn = DateTime.now();
    _cambio();
    return null;
  }

  // ---------------------------------------------------------------------------
  // Clientes
  // ---------------------------------------------------------------------------

  String? guardarCliente(Cliente cliente) {
    final nombre = cliente.nombre.trim();
    final telefono = soloDigitos(cliente.telefono);

    if (nombre.length < 3 || nombre.length > 60) {
      return 'El nombre debe tener entre 3 y 60 caracteres.';
    }
    if (telefono.length < 8 || telefono.length > 15) {
      return 'El teléfono debe tener entre 8 y 15 dígitos.';
    }

    cliente.nombre = nombre;
    cliente.telefono = telefono;
    cliente.direccion = cliente.direccion?.trim().isEmpty == true
        ? null
        : cliente.direccion?.trim();

    final indice = clientes.indexWhere((item) => item.id == cliente.id);
    if (indice == -1) {
      clientes.add(cliente);
    } else {
      clientes[indice] = cliente;
    }
    _cambio();
    return null;
  }

  String? eliminarCliente(String idCliente) {
    if (ordenes.any((item) => item.idCliente == idCliente)) {
      return 'No se puede eliminar: el cliente tiene órdenes registradas.';
    }
    vehiculos.removeWhere((item) => item.idCliente == idCliente);
    clientes.removeWhere((item) => item.id == idCliente);
    _cambio();
    return null;
  }

  // ---------------------------------------------------------------------------
  // Vehículos
  // ---------------------------------------------------------------------------

  String? guardarVehiculo(Vehiculo vehiculo) {
    if (clientePorId(vehiculo.idCliente) == null) {
      return 'Selecciona un cliente válido.';
    }

    final matricula = normalizarMatricula(vehiculo.matricula);
    if (matricula.length < 5 || matricula.length > 8) {
      return 'La matrícula debe tener entre 5 y 8 letras o números.';
    }
    if (vehiculo.marca.trim().length < 2) return 'Escribe la marca.';
    if (vehiculo.modelo.trim().isEmpty) return 'Escribe el modelo.';

    final anioMaximo = DateTime.now().year + 1;
    if (vehiculo.anio < 1950 || vehiculo.anio > anioMaximo) {
      return 'El año debe estar entre 1950 y $anioMaximo.';
    }
    if (vehiculo.kilometraje < 0) {
      return 'El kilometraje no puede ser negativo.';
    }

    final repetida = vehiculos.any(
      (item) =>
          item.id != vehiculo.id &&
          normalizarMatricula(item.matricula) == matricula,
    );
    if (repetida) return 'Ya existe un vehículo con esa matrícula.';

    final indice = vehiculos.indexWhere((item) => item.id == vehiculo.id);
    if (indice >= 0) {
      final anterior = vehiculos[indice];
      if (vehiculo.kilometraje < anterior.kilometraje) {
        return 'El kilometraje no puede ser menor al último registrado '
            '(${anterior.kilometraje} km).';
      }
    }

    vehiculo.matricula = matricula;
    vehiculo.marca = vehiculo.marca.trim();
    vehiculo.modelo = vehiculo.modelo.trim();
    vehiculo.actualizadoEn = DateTime.now();

    if (indice == -1) {
      vehiculos.add(vehiculo);
    } else {
      vehiculos[indice] = vehiculo;
    }
    _cambio();
    return null;
  }

  String? eliminarVehiculo(String idVehiculo) {
    if (ordenes.any((item) => item.idVehiculo == idVehiculo)) {
      return 'No se puede eliminar: el vehículo tiene órdenes registradas.';
    }
    vehiculos.removeWhere((item) => item.id == idVehiculo);
    _cambio();
    return null;
  }

  // ---------------------------------------------------------------------------
  // Repuestos
  // ---------------------------------------------------------------------------

  String? guardarRepuesto(Repuesto repuesto) {
    final codigo = normalizarCodigo(repuesto.codigo);
    final nombre = repuesto.nombre.trim();

    if (codigo.length < 3) return 'El código debe tener al menos 3 caracteres.';
    if (nombre.length < 3) return 'El nombre debe tener al menos 3 caracteres.';
    if (repuesto.precio <= 0) return 'El precio debe ser mayor a cero.';
    if (repuesto.existencias < 0) {
      return 'Las existencias no pueden ser negativas.';
    }
    if (repuesto.stockMinimo < 0) {
      return 'El stock mínimo no puede ser negativo.';
    }

    final repetido = repuestos.any(
      (item) =>
          item.id != repuesto.id && normalizarCodigo(item.codigo) == codigo,
    );
    if (repetido) return 'Ya existe un repuesto con ese código.';

    repuesto.codigo = codigo;
    repuesto.nombre = nombre;

    final indice = repuestos.indexWhere((item) => item.id == repuesto.id);
    if (indice == -1) {
      repuestos.add(repuesto);
    } else {
      repuestos[indice] = repuesto;
    }
    _cambio();
    return null;
  }

  String? eliminarRepuesto(String idRepuesto) {
    final usado = ordenes.any(
      (orden) => orden.repuestos.any((item) => item.idRepuesto == idRepuesto),
    );
    if (usado) {
      return 'No se puede eliminar: el repuesto figura en órdenes.';
    }
    repuestos.removeWhere((item) => item.id == idRepuesto);
    _cambio();
    return null;
  }
}
