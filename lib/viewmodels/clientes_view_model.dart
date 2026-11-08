import 'package:flutter/foundation.dart';

import '../models/cliente.dart';
import '../models/vehiculo.dart';
import '../router/app_state.dart';

class ClientesViewModel extends ChangeNotifier {
  ClientesViewModel({required this.appState}) {
    appState.addListener(_alCambiar);
  }

  final AppState appState;
  String _busqueda = '';

  String get busqueda => _busqueda;

  List<Cliente> get clientes {
    final texto = _busqueda.trim().toLowerCase();
    final lista = appState.clientes.where((cliente) {
      if (texto.isEmpty) return true;
      final vehiculos = appState
          .vehiculosDeCliente(cliente.id)
          .map((item) => '${item.matricula} ${item.descripcion}')
          .join(' ');
      return '${cliente.nombre} ${cliente.telefono} '
              '${cliente.direccion ?? ''} $vehiculos'
          .toLowerCase()
          .contains(texto);
    }).toList();
    lista.sort((a, b) => a.nombre.compareTo(b.nombre));
    return lista;
  }

  int get total => appState.clientes.length;
  int get conDeuda => appState.clientesConDeuda.length;

  double saldoDe(String idCliente) => appState.saldoDeCliente(idCliente);

  List<Vehiculo> vehiculosDe(String idCliente) =>
      appState.vehiculosDeCliente(idCliente);

  void buscar(String texto) {
    if (_busqueda == texto) return;
    _busqueda = texto;
    notifyListeners();
  }

  String? eliminar(String idCliente) => appState.eliminarCliente(idCliente);

  void _alCambiar() => notifyListeners();

  @override
  void dispose() {
    appState.removeListener(_alCambiar);
    super.dispose();
  }
}
