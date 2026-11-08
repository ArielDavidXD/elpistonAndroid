import 'package:flutter/material.dart';

import '../models/mecanico.dart';
import '../models/vehiculo.dart';
import '../router/app_state.dart';
import '../utils/resultado.dart';

class OrdenFormViewModel extends ChangeNotifier {
  OrdenFormViewModel({required this.appState}) {
    idCliente = appState.clientes.isEmpty ? null : appState.clientes.first.id;
    idMecanico = appState.mecanicos.isEmpty
        ? null
        : appState.mecanicos.first.id;
    _actualizarVehiculos();
    if (vehiculos.isNotEmpty) idVehiculo = vehiculos.first.id;
  }

  final AppState appState;

  final problemaController = TextEditingController();
  final kilometrajeController = TextEditingController();

  String? idCliente;
  String? idVehiculo;
  String? idMecanico;
  String? _error;
  bool _guardando = false;

  String? get error => _error;
  bool get guardando => _guardando;

  List<Mecanico> get mecanicos => appState.mecanicos;
  List<Vehiculo> vehiculos = [];

  int get proximoNumero => appState.proximoNumeroOrden;

  Vehiculo? get vehiculoSeleccionado =>
      idVehiculo == null ? null : appState.vehiculoPorId(idVehiculo!);

  void _actualizarVehiculos() {
    vehiculos = idCliente == null
        ? []
        : appState.vehiculosDeCliente(idCliente!);
    if (!vehiculos.any((item) => item.id == idVehiculo)) {
      idVehiculo = vehiculos.isEmpty ? null : vehiculos.first.id;
    }
  }

  void seleccionarCliente(String? id) {
    if (idCliente == id) return;
    idCliente = id;
    _actualizarVehiculos();
    _error = null;
    notifyListeners();
  }

  void seleccionarVehiculo(String? id) {
    idVehiculo = id;
    _error = null;
    notifyListeners();
  }

  void seleccionarMecanico(String? id) {
    idMecanico = id;
    _error = null;
    notifyListeners();
  }

  void refrescarCatalogos() {
    if (idCliente == null || appState.clientePorId(idCliente!) == null) {
      idCliente = appState.clientes.isEmpty ? null : appState.clientes.first.id;
    }
    if (idMecanico == null || appState.mecanicoPorId(idMecanico!) == null) {
      idMecanico = appState.mecanicos.isEmpty
          ? null
          : appState.mecanicos.first.id;
    }
    _actualizarVehiculos();
    notifyListeners();
  }

  Resultado<String> guardar() {
    if (_guardando) {
      return const Resultado.fallo('La orden se está guardando.');
    }

    final kilometrajeTexto = kilometrajeController.text.trim();
    final kilometraje = kilometrajeTexto.isEmpty
        ? null
        : int.tryParse(kilometrajeTexto);

    if (kilometrajeTexto.isNotEmpty && kilometraje == null) {
      _error = 'El kilometraje debe ser un número entero.';
      notifyListeners();
      return Resultado.fallo(_error!);
    }

    final resultado = appState.crearOrden(
      idCliente: idCliente ?? '',
      idVehiculo: idVehiculo ?? '',
      idMecanico: idMecanico ?? '',
      problema: problemaController.text,
      kilometraje: kilometraje,
    );

    if (!resultado.ok) {
      _error = resultado.error;
      notifyListeners();
      return Resultado.fallo(resultado.error!);
    }

    _guardando = true;
    problemaController.clear();
    kilometrajeController.clear();
    notifyListeners();
    return Resultado.ok(resultado.valor!.id);
  }

  @override
  void dispose() {
    problemaController.dispose();
    kilometrajeController.dispose();
    super.dispose();
  }
}
