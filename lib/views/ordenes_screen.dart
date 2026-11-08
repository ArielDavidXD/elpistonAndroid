import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/orden_servicio.dart';
import '../router/app_state.dart';
import '../viewmodels/ordenes_view_model.dart';
import '../widgets/boton_tema.dart';
import '../widgets/buscador.dart';
import '../widgets/orden_card.dart';
import '../widgets/vacio_widget.dart';

class OrdenesScreen extends StatefulWidget {
  const OrdenesScreen({required this.appState, super.key});

  final AppState appState;

  @override
  State<OrdenesScreen> createState() => _OrdenesScreenState();
}

class _OrdenesScreenState extends State<OrdenesScreen> {
  late final OrdenesViewModel viewModel = OrdenesViewModel(
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
        title: const Text('Órdenes'),
        actions: const [BotonTema(), SizedBox(width: 6)],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab-ordenes',
        onPressed: () => context.push('/nueva-orden'),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nueva'),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final ordenes = viewModel.ordenes;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                child: Buscador(
                  hint: 'Buscar por cliente, matrícula u orden...',
                  onChanged: viewModel.buscar,
                ),
              ),
              SizedBox(
                height: 37,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _FiltroChip(
                      etiqueta: 'Todas',
                      cantidad: viewModel.total,
                      seleccionado: viewModel.filtro == null,
                      onTap: () => viewModel.filtrar(null),
                    ),
                    for (final estado in EstadoOrden.values) ...[
                      const SizedBox(width: 8),
                      _FiltroChip(
                        etiqueta: estado.etiqueta,
                        cantidad: viewModel.cantidades[estado] ?? 0,
                        seleccionado: viewModel.filtro == estado,
                        onTap: () => viewModel.filtrar(estado),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ordenes.isEmpty
                    ? VacioWidget(
                        icono: Icons.assignment_outlined,
                        titulo: 'Sin órdenes para mostrar',
                        mensaje:
                            viewModel.busqueda.isEmpty &&
                                viewModel.filtro == null
                            ? 'Crea la primera orden de servicio del taller.'
                            : 'Probá con otra búsqueda o quitá los filtros.',
                        accion: OutlinedButton(
                          onPressed: viewModel.limpiar,
                          child: const Text('Limpiar filtros'),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 2, 16, 100),
                        itemCount: ordenes.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, indice) {
                          final orden = ordenes[indice];
                          return OrdenCard(
                            orden: orden,
                            appState: widget.appState,
                            onTap: () => context.push('/orden/${orden.id}'),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FiltroChip extends StatelessWidget {
  const _FiltroChip({
    required this.etiqueta,
    required this.cantidad,
    required this.seleccionado,
    required this.onTap,
  });

  final String etiqueta;
  final int cantidad;
  final bool seleccionado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: seleccionado,
      onSelected: (_) => onTap(),
      label: Text('$etiqueta · $cantidad'),
      visualDensity: VisualDensity.compact,
      showCheckmark: false,
    );
  }
}
