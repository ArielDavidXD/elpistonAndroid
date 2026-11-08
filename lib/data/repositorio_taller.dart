import '../data/datos_taller.dart';

abstract class RepositorioTaller {
  Future<DatosTaller?> cargar();
  Future<void> guardar(DatosTaller datos);
  Future<void> cerrar();
}
