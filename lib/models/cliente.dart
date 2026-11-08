class Cliente {
  Cliente({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.direccion,
    required this.creadoEn,
  });

  final String id;
  String nombre;
  String telefono;
  String? direccion;
  final DateTime creadoEn;
}
