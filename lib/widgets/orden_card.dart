import 'package:flutter/material.dart';

import '../models/orden_servicio.dart';
import '../router/app_state.dart';
import '../utils/formato.dart';
import 'estado_chip.dart';

class OrdenCard extends StatelessWidget {
  const OrdenCard({
    required this.orden,
    required this.appState,
    required this.onTap,
    this.mostrarCliente = true,
    super.key,
  });

  final OrdenServicio orden;
  final AppState appState;
  final VoidCallback onTap;
  final bool mostrarCliente;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final cliente = appState.clientePorId(orden.idCliente);
    final vehiculo = appState.vehiculoPorId(orden.idVehiculo);
    final mecanico = appState.mecanicoPorId(orden.idMecanico);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colores.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      'OS ${orden.numero.toString().padLeft(4, '0')}',
                      style: tema.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: .3,
                        color: colores.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const Spacer(),
                  EstadoChip(estado: orden.estado, compacto: true),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                vehiculo == null
                    ? 'Vehículo eliminado'
                    : '${vehiculo.descripcion} · ${vehiculo.matricula}',
                style: tema.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (mostrarCliente) ...[
                const SizedBox(height: 2),
                Text(
                  cliente?.nombre ?? 'Cliente eliminado',
                  style: tema.textTheme.bodySmall?.copyWith(
                    color: colores.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.person_outline_rounded,
                    size: 14,
                    color: colores.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      mecanico?.nombre ?? 'Sin asignar',
                      style: tema.textTheme.labelSmall?.copyWith(
                        color: colores.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 13,
                    color: colores.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    fechaCorta(orden.fechaIngreso),
                    style: tema.textTheme.labelSmall?.copyWith(
                      color: colores.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 11),
              Row(
                children: [
                  Text(
                    dineroCorto(orden.total),
                    style: tema.textTheme.titleSmall?.copyWith(
                      color: colores.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (orden.saldo > 0.009 && !orden.cancelada) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colores.errorContainer.withAlpha(130),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Saldo ${dineroCorto(orden.saldo)}',
                        style: tema.textTheme.labelSmall?.copyWith(
                          color: colores.onErrorContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colores.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
