class Repuesto {
  Repuesto({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.precio,
    required this.existencias,
    required this.stockMinimo,
  });

  final String id;
  String codigo;
  String nombre;
  double precio;
  int existencias;
  int stockMinimo;

  bool get bajoStock => existencias <= stockMinimo;
}
