import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    required this.icono,
    required this.etiqueta,
    required this.valor,
    this.detalle,
    this.color,
    this.onTap,
    super.key,
  });

  final IconData icono;
  final String etiqueta;
  final String valor;
  final String? detalle;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final tono = color ?? colores.primary;
    final contenido = Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colores.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colores.outlineVariant.withAlpha(130)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: tono.withAlpha(24),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icono, size: 18, color: tono),
          ),
          const SizedBox(height: 12),
          Text(
            valor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colores.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            etiqueta,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: colores.onSurfaceVariant),
          ),
          if (detalle != null) ...[
            const SizedBox(height: 2),
            Text(
              detalle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: tono, fontWeight: FontWeight.w600),
            ),
          ],
        ],
      ),
    );
    if (onTap == null) return contenido;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: contenido,
    );
  }
}
