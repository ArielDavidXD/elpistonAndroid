import 'package:flutter/foundation.dart';

import '../models/orden_servicio.dart';
import '../router/app_state.dart';

class PanelViewModel extends ChangeNotifier {
  PanelViewModel({required this.appState}) {
    appState.addListener(_alCambiar);
  }

  final AppState appState;

  int get abiertas => appState.ordenesAbiertas.length;
  int get entregadas => appState.ordenes
      .where((orden) => orden.estado == EstadoOrden.entregada)
      .length;
  int get enReparacion => appState.ordenes
      .where((orden) => orden.estado == EstadoOrden.reparacion)
      .length;
  int get listas => appState.ordenes
      .where((orden) => orden.estado == EstadoOrden.lista)
      .length;
  double get saldo => appState.saldoTotal;
  int get bajos => appState.repuestosBajos.length;
  List<OrdenServicio> get recientes =>
      appState.ordenesAbiertas.take(4).toList();

  void _alCambiar() => notifyListeners();

  @override
  void dispose() {
    appState.removeListener(_alCambiar);
    super.dispose();
  }
}
