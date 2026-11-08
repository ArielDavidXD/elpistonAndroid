import 'package:flutter/foundation.dart';

import '../models/cliente.dart';
import '../models/orden_servicio.dart';
import '../models/vehiculo.dart';
import '../router/app_state.dart';

class VehiculoDetalleViewModel extends ChangeNotifier {
  VehiculoDetalleViewModel({required this.appState, required this.idVehiculo}) {
    appState.addListener(_alCambiar);
  }

  final AppState appState;
  final String idVehiculo;

  Vehiculo? get vehiculo => appState.vehiculoPorId(idVehiculo);
  Cliente? get cliente {
    final actual = vehiculo;
    return actual == null ? null : appState.clientePorId(actual.idCliente);
  }

  List<OrdenServicio> get ordenes => appState.ordenesDeVehiculo(idVehiculo);
  double get totalFacturado => ordenes
      .where((item) => item.entregada)
      .fold(0.0, (total, item) => total + item.total);

  void _alCambiar() => notifyListeners();

  @override
  void dispose() {
    appState.removeListener(_alCambiar);
    super.dispose();
  }
}
