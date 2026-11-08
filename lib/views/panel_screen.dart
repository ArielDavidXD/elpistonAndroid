import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_state.dart';
import '../utils/formato.dart';
import '../viewmodels/panel_view_model.dart';
import '../widgets/boton_tema.dart';
import '../widgets/orden_card.dart';
import '../widgets/seccion_titulo.dart';
import '../widgets/stat_card.dart';

class PanelScreen extends StatefulWidget {
  const PanelScreen({required this.appState, super.key});

  final AppState appState;

  @override
  State<PanelScreen> createState() => _PanelScreenState();
}

class _PanelScreenState extends State<PanelScreen> {
  late final PanelViewModel viewModel = PanelViewModel(
    appState: widget.appState,
  );

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.settings_suggest_rounded,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('El Pistón'),
                Text(
                  'Taller automotriz',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .2,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: const [BotonTema(), SizedBox(width: 6)],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab-panel',
        onPressed: () => context.push('/nueva-orden'),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nueva orden'),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final tema = Theme.of(context);
          final colores = tema.colorScheme;
          final ahora = DateTime.now();
          final saludo = ahora.hour < 12
              ? 'Buen día'
              : ahora.hour < 20
              ? 'Buenas tardes'
              : 'Buenas noches';

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            children: [
              Text(
                '$saludo, equipo',
                style: tema.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                fechaLarga(ahora),
                style: tema.textTheme.bodySmall?.copyWith(
                  color: colores.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, constraints) {
                  final ancho = (constraints.maxWidth - 12) / 2;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: ancho,
                        child: StatCard(
                          icono: Icons.assignment_outlined,
                          etiqueta: 'Órdenes abiertas',
                          valor: '${viewModel.abiertas}',
                          detalle: '${viewModel.listas} listas',
                          onTap: () => context.go('/ordenes'),
                        ),
                      ),
                      SizedBox(
                        width: ancho,
                        child: StatCard(
                          icono: Icons.build_circle_outlined,
                          etiqueta: 'En reparación',
                          valor: '${viewModel.enReparacion}',
                          detalle: '${viewModel.entregadas} entregadas',
                          color: const Color(0xFF9A5B00),
                          onTap: () => context.go('/ordenes'),
                        ),
                      ),
                      SizedBox(
                        width: ancho,
                        child: StatCard(
                          icono: Icons.account_balance_wallet_outlined,
                          etiqueta: 'Saldo pendiente',
                          valor: dineroCorto(viewModel.saldo),
                          detalle: 'Por cobrar',
                          color: colores.tertiary,
                          onTap: () => context.go('/reportes'),
                        ),
                      ),
                      SizedBox(
                        width: ancho,
                        child: StatCard(
                          icono: Icons.inventory_2_outlined,
                          etiqueta: 'Stock bajo',
                          valor: '${viewModel.bajos}',
                          detalle: 'Repuestos',
                          color: viewModel.bajos > 0
                              ? colores.error
                              : colores.primary,
                          onTap: () => context.go('/inventario'),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              SeccionTitulo(
                titulo: 'Órdenes en curso',
                subtitulo: '${viewModel.abiertas} órdenes requieren atención',
                accion: TextButton(
                  onPressed: () => context.go('/ordenes'),
                  child: const Text('Ver todas'),
                ),
              ),
              const SizedBox(height: 10),
              if (viewModel.recientes.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          color: colores.primary,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text('No hay órdenes abiertas por ahora.'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                for (final orden in viewModel.recientes) ...[
                  OrdenCard(
                    orden: orden,
                    appState: widget.appState,
                    onTap: () => context.push('/orden/${orden.id}'),
                  ),
                  const SizedBox(height: 10),
                ],
            ],
          );
        },
      ),
    );
  }
}
