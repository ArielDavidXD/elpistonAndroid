import 'package:flutter/foundation.dart';

import '../models/cliente.dart';
import '../models/mecanico.dart';
import '../models/orden_servicio.dart';
import '../models/repuesto.dart';
import '../models/vehiculo.dart';
import '../router/app_state.dart';

class OrdenDetalleViewModel extends ChangeNotifier {
  OrdenDetalleViewModel({required this.appState, required this.idOrden}) {
    appState.addListener(_alCambiar);
  }

  final AppState appState;
  final String idOrden;

  OrdenServicio? get orden => appState.ordenPorId(idOrden);
  Cliente? get cliente {
    final actual = orden;
    return actual == null ? null : appState.clientePorId(actual.idCliente);
  }

  Vehiculo? get vehiculo {
    final actual = orden;
    return actual == null ? null : appState.vehiculoPorId(actual.idVehiculo);
  }

  Mecanico? get mecanico {
    final actual = orden;
    return actual == null ? null : appState.mecanicoPorId(actual.idMecanico);
  }

  List<Repuesto> get repuestosDisponibles =>
      appState.repuestos.where((item) => item.existencias > 0).toList()
        ..sort((a, b) => a.nombre.compareTo(b.nombre));

  String? avanzar() {
    final actual = orden;
    if (actual == null || actual.estado.siguiente == null) return null;
    return appState.cambiarEstadoOrden(idOrden, actual.estado.siguiente!);
  }

  String? cancelar() =>
      appState.cambiarEstadoOrden(idOrden, EstadoOrden.cancelada);

  String? agregarManoObra(String descripcion, double precio) =>
      appState.agregarManoObra(idOrden, descripcion, precio);

  String? eliminarManoObra(String idTrabajo) =>
      appState.eliminarManoObra(idOrden, idTrabajo);

  String? agregarRepuesto(String idRepuesto, int cantidad) =>
      appState.agregarRepuesto(idOrden, idRepuesto, cantidad);

  String? eliminarRepuesto(String idRepuesto) =>
      appState.eliminarRepuestoUsado(idOrden, idRepuesto);

  String? registrarPago(double monto, String metodo) =>
      appState.registrarPago(idOrden, monto, metodo);

  String? eliminarPago(String idPago) => appState.eliminarPago(idOrden, idPago);

  void _alCambiar() => notifyListeners();

  @override
  void dispose() {
    appState.removeListener(_alCambiar);
    super.dispose();
  }
}
