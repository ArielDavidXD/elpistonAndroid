import 'package:flutter/foundation.dart';

import '../models/repuesto.dart';
import '../router/app_state.dart';

class InventarioViewModel extends ChangeNotifier {
  InventarioViewModel({required this.appState}) {
    appState.addListener(_alCambiar);
  }

  final AppState appState;

  String _busqueda = '';
  bool _soloBajos = false;

  String get busqueda => _busqueda;
  bool get soloBajos => _soloBajos;

  List<Repuesto> get repuestos {
    final texto = _busqueda.trim().toLowerCase();
    final lista = appState.repuestos.where((repuesto) {
      if (_soloBajos && !repuesto.bajoStock) return false;
      if (texto.isEmpty) return true;
      return '${repuesto.codigo} ${repuesto.nombre}'.toLowerCase().contains(
        texto,
      );
    }).toList();
    lista.sort((a, b) => a.nombre.compareTo(b.nombre));
    return lista;
  }

  int get total => appState.repuestos.length;
  int get bajos => appState.repuestosBajos.length;
  double get valor => appState.valorInventario;
  int get unidades =>
      appState.repuestos.fold(0, (total, item) => total + item.existencias);

  void buscar(String texto) {
    if (_busqueda == texto) return;
    _busqueda = texto;
    notifyListeners();
  }

  void cambiarSoloBajos(bool valor) {
    if (_soloBajos == valor) return;
    _soloBajos = valor;
    notifyListeners();
  }

  String? eliminar(String idRepuesto) => appState.eliminarRepuesto(idRepuesto);

  void _alCambiar() => notifyListeners();

  @override
  void dispose() {
    appState.removeListener(_alCambiar);
    super.dispose();
  }
}
