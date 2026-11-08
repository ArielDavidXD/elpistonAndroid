import 'package:flutter/foundation.dart';

import '../models/cliente.dart';
import '../models/orden_servicio.dart';
import '../models/vehiculo.dart';
import '../router/app_state.dart';

class ClienteDetalleViewModel extends ChangeNotifier {
  ClienteDetalleViewModel({required this.appState, required this.idCliente}) {
    appState.addListener(_alCambiar);
  }

  final AppState appState;
  final String idCliente;

  Cliente? get cliente => appState.clientePorId(idCliente);
  List<Vehiculo> get vehiculos => appState.vehiculosDeCliente(idCliente);
  List<OrdenServicio> get ordenes => appState.ordenesDeCliente(idCliente);
  double get saldo => appState.saldoDeCliente(idCliente);
  int get abiertas => ordenes.where((item) => item.abierta).length;

  String? eliminarVehiculo(String idVehiculo) =>
      appState.eliminarVehiculo(idVehiculo);

  void _alCambiar() => notifyListeners();

  @override
  void dispose() {
    appState.removeListener(_alCambiar);
    super.dispose();
  }
}
