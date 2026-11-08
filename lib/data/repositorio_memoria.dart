import 'datos_taller.dart';
import 'repositorio_taller.dart';

class RepositorioMemoria implements RepositorioTaller {
  // ignore: prefer_initializing_formals
  RepositorioMemoria({DatosTaller? datos}) : _datos = datos;

  DatosTaller? _datos;
  int guardados = 0;

  DatosTaller? get datos => _datos;

  @override
  Future<DatosTaller?> cargar() async => _datos;

  @override
  Future<void> guardar(DatosTaller datos) async {
    _datos = datos;
    guardados++;
  }

  @override
  Future<void> cerrar() async {}
}
