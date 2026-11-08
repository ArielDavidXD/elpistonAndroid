import 'package:flutter/foundation.dart';

import '../models/orden_servicio.dart';
import '../router/app_state.dart';

class OrdenesViewModel extends ChangeNotifier {
  OrdenesViewModel({required this.appState}) {
    appState.addListener(_alCambiar);
  }

  final AppState appState;

  EstadoOrden? _filtro;
  String _busqueda = '';

  EstadoOrden? get filtro => _filtro;
  String get busqueda => _busqueda;

  List<OrdenServicio> get ordenes {
    final texto = _busqueda.trim().toLowerCase();
    return appState.ordenes.where((orden) {
      if (_filtro != null && orden.estado != _filtro) return false;
      if (texto.isEmpty) return true;

      final cliente = appState.clientePorId(orden.idCliente);
      final vehiculo = appState.vehiculoPorId(orden.idVehiculo);
      final mecanico = appState.mecanicoPorId(orden.idMecanico);
      final contenido = [
        orden.numero.toString(),
        cliente?.nombre ?? '',
        cliente?.telefono ?? '',
        vehiculo?.matricula ?? '',
        vehiculo?.descripcion ?? '',
        mecanico?.nombre ?? '',
        orden.problema,
      ].join(' ').toLowerCase();
      return contenido.contains(texto);
    }).toList()..sort((a, b) => b.fechaIngreso.compareTo(a.fechaIngreso));
  }

  Map<EstadoOrden, int> get cantidades {
    final mapa = {for (final estado in EstadoOrden.values) estado: 0};
    for (final orden in appState.ordenes) {
      mapa[orden.estado] = (mapa[orden.estado] ?? 0) + 1;
    }
    return mapa;
  }

  int get total => appState.ordenes.length;

  void buscar(String texto) {
    if (_busqueda == texto) return;
    _busqueda = texto;
    notifyListeners();
  }

  void filtrar(EstadoOrden? estado) {
    if (_filtro == estado) return;
    _filtro = estado;
    notifyListeners();
  }

  void limpiar() {
    _busqueda = '';
    _filtro = null;
    notifyListeners();
  }

  void _alCambiar() => notifyListeners();

  @override
  void dispose() {
    appState.removeListener(_alCambiar);
    super.dispose();
  }
}
