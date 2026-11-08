import 'package:flutter/material.dart';

class VacioWidget extends StatelessWidget {
  const VacioWidget({
    required this.icono,
    required this.titulo,
    required this.mensaje,
    this.accion,
    super.key,
  });

  final IconData icono;
  final String titulo;
  final String mensaje;
  final Widget? accion;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colores.primaryContainer.withAlpha(120),
                shape: BoxShape.circle,
              ),
              child: Icon(icono, size: 34, color: colores.primary),
            ),
            const SizedBox(height: 16),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              mensaje,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colores.onSurfaceVariant, height: 1.5),
            ),
            if (accion != null) ...[const SizedBox(height: 18), accion!],
          ],
        ),
      ),
    );
  }
}
