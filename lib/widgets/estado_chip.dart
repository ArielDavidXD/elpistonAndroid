import 'package:flutter/material.dart';

import '../models/orden_servicio.dart';

class EstadoChip extends StatelessWidget {
  const EstadoChip({required this.estado, this.compacto = false, super.key});

  final EstadoOrden estado;
  final bool compacto;

  static Color colorDe(EstadoOrden estado, ColorScheme colores) {
    switch (estado) {
      case EstadoOrden.recibida:
        return const Color(0xFF3E6A9E);
      case EstadoOrden.diagnostico:
        return const Color(0xFF6A4C93);
      case EstadoOrden.reparacion:
        return const Color(0xFF9A5B00);
      case EstadoOrden.lista:
        return const Color(0xFF1E7A4C);
      case EstadoOrden.entregada:
        return colores.primary;
      case EstadoOrden.cancelada:
        return colores.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final color = colorDe(estado, colores);
    final brilloOscuro = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compacto ? 8 : 10,
        vertical: compacto ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(brilloOscuro ? 52 : 22),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(brilloOscuro ? 120 : 65)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            estado.etiqueta,
            style: TextStyle(
              color: brilloOscuro ? color.withAlpha(255) : color,
              fontSize: compacto ? 10 : 11,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
