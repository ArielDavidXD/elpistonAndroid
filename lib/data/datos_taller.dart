import '../models/cliente.dart';
import '../models/mecanico.dart';
import '../models/orden_servicio.dart';
import '../models/repuesto.dart';
import '../models/vehiculo.dart';

/// Fotografía completa del taller usada por AppState y el repositorio.
class DatosTaller {
  const DatosTaller({
    required this.clientes,
    required this.vehiculos,
    required this.mecanicos,
    required this.repuestos,
    required this.ordenes,
  });

  final List<Cliente> clientes;
  final List<Vehiculo> vehiculos;
  final List<Mecanico> mecanicos;
  final List<Repuesto> repuestos;
  final List<OrdenServicio> ordenes;

  bool get vacio =>
      clientes.isEmpty &&
      vehiculos.isEmpty &&
      mecanicos.isEmpty &&
      repuestos.isEmpty &&
      ordenes.isEmpty;
}
