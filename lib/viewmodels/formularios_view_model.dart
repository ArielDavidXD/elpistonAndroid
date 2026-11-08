import 'package:flutter/material.dart';

import '../models/cliente.dart';
import '../models/repuesto.dart';
import '../models/vehiculo.dart';
import '../router/app_state.dart';

String _idNuevo() => DateTime.now().microsecondsSinceEpoch.toString();

double? numero(String texto) {
  var limpio = texto.trim().replaceAll(' ', '');
  if (limpio.isEmpty) return null;
  if (limpio.contains(',')) {
    limpio = limpio.replaceAll('.', '').replaceAll(',', '.');
  }
  return double.tryParse(limpio);
}

class ClienteFormViewModel extends ChangeNotifier {
  ClienteFormViewModel({required this.appState, this.cliente}) {
    nombre.text = cliente?.nombre ?? '';
    telefono.text = cliente?.telefono ?? '';
    direccion.text = cliente?.direccion ?? '';
  }

  final AppState appState;
  final Cliente? cliente;

  final nombre = TextEditingController();
  final telefono = TextEditingController();
  final direccion = TextEditingController();

  String? _error;
  String? get error => _error;
  bool get editando => cliente != null;

  String? guardar() {
    final datos = Cliente(
      id: cliente?.id ?? _idNuevo(),
      nombre: nombre.text,
      telefono: telefono.text,
      direccion: direccion.text,
      creadoEn: cliente?.creadoEn ?? DateTime.now(),
    );
    final error = appState.guardarCliente(datos);
    _error = error;
    if (error == null) notifyListeners();
    return error;
  }

  @override
  void dispose() {
    nombre.dispose();
    telefono.dispose();
    direccion.dispose();
    super.dispose();
  }
}

class VehiculoFormViewModel extends ChangeNotifier {
  VehiculoFormViewModel({
    required this.appState,
    required this.idCliente,
    this.vehiculo,
  }) {
    matricula.text = vehiculo?.matricula ?? '';
    marca.text = vehiculo?.marca ?? '';
    modelo.text = vehiculo?.modelo ?? '';
    anio.text = vehiculo?.anio.toString() ?? '';
    kilometraje.text = vehiculo?.kilometraje.toString() ?? '';
  }

  final AppState appState;
  String idCliente;
  final Vehiculo? vehiculo;

  final matricula = TextEditingController();
  final marca = TextEditingController();
  final modelo = TextEditingController();
  final anio = TextEditingController();
  final kilometraje = TextEditingController();

  String? _error;
  String? get error => _error;
  bool get editando => vehiculo != null;

  void seleccionarCliente(String? id) {
    if (id == null) return;
    idCliente = id;
    notifyListeners();
  }

  String? guardar() {
    final anioNumero = int.tryParse(anio.text.trim());
    final kmNumero = int.tryParse(kilometraje.text.trim());
    if (anioNumero == null) {
      _error = 'El año debe ser un número.';
      notifyListeners();
      return _error;
    }
    if (kmNumero == null) {
      _error = 'El kilometraje debe ser un número entero.';
      notifyListeners();
      return _error;
    }

    final datos = Vehiculo(
      id: vehiculo?.id ?? _idNuevo(),
      idCliente: idCliente,
      matricula: matricula.text,
      marca: marca.text,
      modelo: modelo.text,
      anio: anioNumero,
      kilometraje: kmNumero,
      actualizadoEn: vehiculo?.actualizadoEn ?? DateTime.now(),
    );
    final error = appState.guardarVehiculo(datos);
    _error = error;
    if (error == null) notifyListeners();
    return error;
  }

  @override
  void dispose() {
    matricula.dispose();
    marca.dispose();
    modelo.dispose();
    anio.dispose();
    kilometraje.dispose();
    super.dispose();
  }
}

class RepuestoFormViewModel extends ChangeNotifier {
  RepuestoFormViewModel({required this.appState, this.repuesto}) {
    codigo.text = repuesto?.codigo ?? '';
    nombre.text = repuesto?.nombre ?? '';
    precio.text = repuesto == null ? '' : repuesto!.precio.toStringAsFixed(0);
    existencias.text = repuesto?.existencias.toString() ?? '';
    stockMinimo.text = repuesto?.stockMinimo.toString() ?? '';
  }

  final AppState appState;
  final Repuesto? repuesto;

  final codigo = TextEditingController();
  final nombre = TextEditingController();
  final precio = TextEditingController();
  final existencias = TextEditingController();
  final stockMinimo = TextEditingController();

  String? _error;
  String? get error => _error;
  bool get editando => repuesto != null;

  String? guardar() {
    final precioNumero = numero(precio.text);
    final existenciasNumero = int.tryParse(existencias.text.trim());
    final minimoNumero = int.tryParse(stockMinimo.text.trim());

    if (precioNumero == null) {
      _error = 'El precio debe ser un número.';
      notifyListeners();
      return _error;
    }
    if (existenciasNumero == null) {
      _error = 'Las existencias deben ser un número entero.';
      notifyListeners();
      return _error;
    }
    if (minimoNumero == null) {
      _error = 'El stock mínimo debe ser un número entero.';
      notifyListeners();
      return _error;
    }

    final datos = Repuesto(
      id: repuesto?.id ?? _idNuevo(),
      codigo: codigo.text,
      nombre: nombre.text,
      precio: precioNumero,
      existencias: existenciasNumero,
      stockMinimo: minimoNumero,
    );
    final error = appState.guardarRepuesto(datos);
    _error = error;
    if (error == null) notifyListeners();
    return error;
  }

  @override
  void dispose() {
    codigo.dispose();
    nombre.dispose();
    precio.dispose();
    existencias.dispose();
    stockMinimo.dispose();
    super.dispose();
  }
}
