import 'package:flutter_test/flutter_test.dart';
import 'package:piston/data/repositorio_memoria.dart';
import 'package:piston/models/orden_servicio.dart';
import 'package:piston/router/app_state.dart';
import 'package:piston/viewmodels/cliente_detalle_view_model.dart';
import 'package:piston/viewmodels/clientes_view_model.dart';
import 'package:piston/viewmodels/inventario_view_model.dart';
import 'package:piston/viewmodels/orden_detalle_view_model.dart';
import 'package:piston/viewmodels/orden_form_view_model.dart';
import 'package:piston/viewmodels/ordenes_view_model.dart';
import 'package:piston/viewmodels/panel_view_model.dart';
import 'package:piston/viewmodels/reportes_view_model.dart';

Future<AppState> crearEstado() async {
  final estado = AppState(repositorio: RepositorioMemoria());
  await estado.cargar();
  return estado;
}

void main() {
  test('PanelViewModel resume la operación del taller', () async {
    final estado = await crearEstado();
    final viewModel = PanelViewModel(appState: estado);
    addTearDown(viewModel.dispose);

    expect(viewModel.abiertas, 4);
    expect(viewModel.enReparacion, 1);
    expect(viewModel.listas, 1);
    expect(viewModel.entregadas, 3);
    expect(viewModel.bajos, 3);
    expect(viewModel.saldo, closeTo(98300, 0.01));
    expect(viewModel.recientes.length, 4);
  });

  test('OrdenesViewModel busca por cliente, patente y filtra estado', () async {
    final estado = await crearEstado();
    final viewModel = OrdenesViewModel(appState: estado);
    addTearDown(viewModel.dispose);

    viewModel.buscar('AB123CD');
    expect(viewModel.ordenes.map((item) => item.id), ['o1']);

    viewModel.buscar('María Fernández');
    expect(viewModel.ordenes.map((item) => item.id), ['o4', 'o1']);

    viewModel.buscar('Lucía Romano');
    expect(viewModel.ordenes.map((item) => item.id), ['o6']);

    viewModel.buscar('');
    viewModel.filtrar(EstadoOrden.entregada);
    expect(viewModel.ordenes.length, 3);
    expect(viewModel.ordenes.every((item) => item.entregada), isTrue);

    viewModel.filtrar(EstadoOrden.cancelada);
    expect(viewModel.ordenes.map((item) => item.id), ['o7']);

    viewModel.limpiar();
    expect(viewModel.ordenes.length, 8);
    expect(viewModel.total, 8);
  });

  test('ClientesViewModel busca por nombre y patente', () async {
    final estado = await crearEstado();
    final viewModel = ClientesViewModel(appState: estado);
    addTearDown(viewModel.dispose);

    expect(viewModel.total, 6);
    expect(viewModel.conDeuda, 3);
    viewModel.buscar('Medina');
    expect(viewModel.clientes.map((item) => item.id), ['c2']);
    viewModel.buscar('AD789GH');
    expect(viewModel.clientes.map((item) => item.id), ['c2']);
    expect(viewModel.saldoDe('c2'), closeTo(42000, 0.01));
  });

  test('ReportesViewModel calcula facturación, deudas y carga', () async {
    final estado = await crearEstado();
    final viewModel = ReportesViewModel(appState: estado);
    addTearDown(viewModel.dispose);

    expect(viewModel.periodo, PeriodoReporte.ultimos60);
    expect(viewModel.facturado, closeTo(230800, 0.01));
    expect(viewModel.cobrado, closeTo(188800, 0.01));
    expect(viewModel.saldo, closeTo(98300, 0.01));
    expect(viewModel.entregadas.length, 3);
    expect(viewModel.deudas.length, 3);
    expect(viewModel.deudas.first.cliente.id, 'c2');
    expect(viewModel.deudas.first.saldo, closeTo(42000, 0.01));
    expect(viewModel.bajos.length, 3);
    expect(viewModel.abiertasPorEstado.values.fold(0, (a, b) => a + b), 4);
    expect(viewModel.mecanicos.length, 2);

    viewModel.cambiarPeriodo(PeriodoReporte.ultimos30);
    expect(viewModel.entregadas.length, 2);
    expect(viewModel.facturado, closeTo(162300, 0.01));
    expect(viewModel.cobrado, closeTo(120300, 0.01));

    final ahora = DateTime.now();
    viewModel.establecerPersonalizado(
      ahora.subtract(const Duration(days: 3)),
      ahora,
    );
    expect(viewModel.periodo, PeriodoReporte.personalizado);
    expect(viewModel.entregadas.length, 2);
  });

  test('InventarioViewModel filtra stock bajo y búsqueda', () async {
    final estado = await crearEstado();
    final viewModel = InventarioViewModel(appState: estado);
    addTearDown(viewModel.dispose);

    expect(viewModel.total, 12);
    expect(viewModel.bajos, 3);
    viewModel.cambiarSoloBajos(true);
    expect(viewModel.repuestos.length, 3);
    expect(viewModel.repuestos.every((item) => item.bajoStock), isTrue);

    viewModel.cambiarSoloBajos(false);
    viewModel.buscar('filtro');
    expect(viewModel.repuestos.length, 3);
  });

  test('OrdenDetalleViewModel opera sobre una orden', () async {
    final estado = await crearEstado();
    final viewModel = OrdenDetalleViewModel(appState: estado, idOrden: 'o3');
    addTearDown(viewModel.dispose);

    expect(viewModel.cliente?.nombre, 'Carla Suárez');
    expect(viewModel.vehiculo?.matricula, 'AE012IJ');
    expect(viewModel.mecanico?.nombre, 'Marcos Ferreyra');
    expect(viewModel.orden!.total, closeTo(38500, 0.01));

    expect(viewModel.registrarPago(12000, 'Transferencia'), isNull);
    expect(viewModel.orden!.saldo, closeTo(26500, 0.01));
    expect(viewModel.registrarPago(30000, 'Tarjeta'), isNotNull);
    expect(viewModel.agregarManoObra('Alineación', 9000), isNull);
    expect(viewModel.orden!.totalManoObra, closeTo(24000, 0.01));
  });

  test('ClienteDetalleViewModel agrupa vehículos y saldo', () async {
    final estado = await crearEstado();
    final viewModel = ClienteDetalleViewModel(
      appState: estado,
      idCliente: 'c1',
    );
    addTearDown(viewModel.dispose);

    expect(viewModel.cliente?.nombre, 'María Fernández');
    expect(viewModel.vehiculos.length, 2);
    expect(viewModel.ordenes.length, 2);
    expect(viewModel.abiertas, 1);
    expect(viewModel.saldo, closeTo(17800, 0.01));
  });

  test('OrdenFormViewModel crea una orden y valida el kilometraje', () async {
    final estado = await crearEstado();
    final viewModel = OrdenFormViewModel(appState: estado);
    addTearDown(viewModel.dispose);

    expect(viewModel.idCliente, 'c1');
    expect(viewModel.idVehiculo, 'v1');
    expect(viewModel.idMecanico, 'm1');
    expect(viewModel.proximoNumero, 9);

    viewModel.kilometrajeController.text = '1000';
    viewModel.problemaController.text = 'Revisar tren delantero';
    var resultado = viewModel.guardar();
    expect(resultado.ok, isFalse);
    expect(resultado.error, contains('menor al último'));

    viewModel.kilometrajeController.text = '90000';
    resultado = viewModel.guardar();
    expect(resultado.ok, isTrue);
    expect(estado.ordenes.length, 9);
    expect(estado.vehiculoPorId('v1')!.kilometraje, 90000);
  });
}
