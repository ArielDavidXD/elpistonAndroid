class Vehiculo {
  Vehiculo({
    required this.id,
    required this.idCliente,
    required this.matricula,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.kilometraje,
    required this.actualizadoEn,
  });

  final String id;
  final String idCliente;
  String matricula;
  String marca;
  String modelo;
  int anio;
  int kilometraje;
  DateTime actualizadoEn;

  String get descripcion => '$marca $modelo';
}
