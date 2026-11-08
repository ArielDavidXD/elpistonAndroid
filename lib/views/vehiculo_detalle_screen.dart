import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_state.dart';
import '../utils/formato.dart';
import '../viewmodels/vehiculo_detalle_view_model.dart';
import '../widgets/boton_tema.dart';
import '../widgets/formularios.dart';
import '../widgets/orden_card.dart';
import '../widgets/seccion_titulo.dart';
import '../widgets/stat_card.dart';
import '../widgets/vacio_widget.dart';

class VehiculoDetalleScreen extends StatefulWidget {
  const VehiculoDetalleScreen({
    required this.appState,
    required this.idVehiculo,
    super.key,
  });

  final AppState appState;
  final String idVehiculo;

  @override
  State<VehiculoDetalleScreen> createState() => _VehiculoDetalleScreenState();
}

class _VehiculoDetalleScreenState extends State<VehiculoDetalleScreen> {
  late final VehiculoDetalleViewModel viewModel = VehiculoDetalleViewModel(
    appState: widget.appState,
    idVehiculo: widget.idVehiculo,
  );

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Future<void> _editar() async {
    final vehiculo = viewModel.vehiculo;
    if (vehiculo == null) return;
    await mostrarFormularioVehiculo(
      context,
      widget.appState,
      idCliente: vehiculo.idCliente,
      vehiculo: vehiculo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final vehiculo = viewModel.vehiculo;
        if (vehiculo == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Vehículo')),
            body: const VacioWidget(
              icono: Icons.directions_car_outlined,
              titulo: 'Vehículo no encontrado',
              mensaje: 'Puede que haya sido eliminado.',
            ),
          );
        }

        final colores = Theme.of(context).colorScheme;
        final abiertas = viewModel.ordenes.where((item) => item.abierta).length;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Historial del vehículo'),
            actions: [
              IconButton(
                tooltip: 'Editar vehículo',
                onPressed: _editar,
                icon: const Icon(Icons.edit_outlined),
              ),
              const BotonTema(),
              const SizedBox(width: 4),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: colores.primaryContainer.withAlpha(150),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.directions_car_filled_rounded,
                              color: colores.onPrimaryContainer,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vehiculo.descripcion,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${vehiculo.matricula} · ${vehiculo.anio}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: colores.onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: _Dato(
                              icono: Icons.speed_rounded,
                              etiqueta: 'Kilometraje',
                              valor: '${vehiculo.kilometraje} km',
                            ),
                          ),
                          Expanded(
                            child: _Dato(
                              icono: Icons.update_rounded,
                              etiqueta: 'Actualizado',
                              valor: fechaCorta(vehiculo.actualizadoEn),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: viewModel.cliente == null
                              ? null
                              : () => context.push(
                                  '/cliente/${vehiculo.idCliente}',
                                ),
                          icon: const Icon(
                            Icons.person_outline_rounded,
                            size: 18,
                          ),
                          label: Text(
                            'Propietario: '
                            '${viewModel.cliente?.nombre ?? 'No disponible'}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      icono: Icons.assignment_outlined,
                      etiqueta: 'Órdenes',
                      valor: '${viewModel.ordenes.length}',
                      detalle: '$abiertas abiertas',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatCard(
                      icono: Icons.payments_outlined,
                      etiqueta: 'Facturado',
                      valor: dineroCorto(viewModel.totalFacturado),
                      detalle: 'Órdenes entregadas',
                      color: colores.tertiary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SeccionTitulo(
                titulo: 'Órdenes del vehículo',
                subtitulo:
                    '${viewModel.ordenes.length} registros en el historial',
              ),
              const SizedBox(height: 9),
              if (viewModel.ordenes.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      'Este vehículo todavía no tiene órdenes de servicio.',
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: colores.onSurfaceVariant),
                    ),
                  ),
                )
              else
                for (final orden in viewModel.ordenes) ...[
                  OrdenCard(
                    orden: orden,
                    appState: widget.appState,
                    mostrarCliente: false,
                    onTap: () => context.push('/orden/${orden.id}'),
                  ),
                  const SizedBox(height: 9),
                ],
            ],
          ),
        );
      },
    );
  }
}

class _Dato extends StatelessWidget {
  const _Dato({
    required this.icono,
    required this.etiqueta,
    required this.valor,
  });

  final IconData icono;
  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icono, size: 17, color: colores.onSurfaceVariant),
        const SizedBox(width: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              etiqueta,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: colores.onSurfaceVariant, fontSize: 10),
            ),
            Text(
              valor,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
