import 'package:flutter/material.dart';

import '../models/repuesto.dart';
import '../router/app_state.dart';
import '../utils/formato.dart';
import '../viewmodels/inventario_view_model.dart';
import '../widgets/boton_tema.dart';
import '../widgets/buscador.dart';
import '../widgets/formularios.dart';
import '../widgets/vacio_widget.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({required this.appState, super.key});

  final AppState appState;

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  late final InventarioViewModel viewModel = InventarioViewModel(
    appState: widget.appState,
  );

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void _aviso(String texto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  Future<void> _editar(Repuesto repuesto) =>
      mostrarFormularioRepuesto(context, widget.appState, repuesto: repuesto);

  Future<void> _eliminar(Repuesto repuesto) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar repuesto'),
        content: Text(
          '¿Eliminar "${repuesto.nombre}" del inventario? '
          'Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Volver'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmar != true || !mounted) return;
    final error = viewModel.eliminar(repuesto.id);
    if (error != null) _aviso(error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        actions: const [BotonTema(), SizedBox(width: 6)],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab-inventario',
        onPressed: () => mostrarFormularioRepuesto(context, widget.appState),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Repuesto'),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final repuestos = viewModel.repuestos;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                child: Buscador(
                  hint: 'Buscar repuesto por nombre o código...',
                  onChanged: viewModel.buscar,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _Resumen(
                        icono: Icons.category_outlined,
                        valor: '${viewModel.total}',
                        etiqueta: 'Repuestos',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _Resumen(
                        icono: Icons.inventory_outlined,
                        valor: '${viewModel.unidades}',
                        etiqueta: 'Unidades',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _Resumen(
                        icono: Icons.payments_outlined,
                        valor: dineroCorto(viewModel.valor),
                        etiqueta: 'Valor stock',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    FilterChip(
                      selected: viewModel.soloBajos,
                      onSelected: viewModel.cambiarSoloBajos,
                      showCheckmark: false,
                      avatar: Icon(
                        Icons.warning_amber_rounded,
                        size: 17,
                        color: viewModel.bajos > 0
                            ? Theme.of(context).colorScheme.error
                            : null,
                      ),
                      label: Text('Stock bajo · ${viewModel.bajos}'),
                    ),
                    const Spacer(),
                    Text(
                      '${repuestos.length} resultados',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: repuestos.isEmpty
                    ? VacioWidget(
                        icono: Icons.inventory_2_outlined,
                        titulo: viewModel.soloBajos
                            ? 'Sin repuestos en alerta'
                            : 'Sin repuestos',
                        mensaje: viewModel.soloBajos
                            ? 'Todo el inventario está por encima del stock mínimo.'
                            : 'Agregá los repuestos que usás en el taller.',
                        accion: viewModel.soloBajos
                            ? OutlinedButton(
                                onPressed: () =>
                                    viewModel.cambiarSoloBajos(false),
                                child: const Text('Ver todo el inventario'),
                              )
                            : FilledButton.icon(
                                onPressed: () => mostrarFormularioRepuesto(
                                  context,
                                  widget.appState,
                                ),
                                icon: const Icon(Icons.add_rounded),
                                label: const Text('Agregar repuesto'),
                              ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                        itemCount: repuestos.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 9),
                        itemBuilder: (context, indice) => _RepuestoCard(
                          repuesto: repuestos[indice],
                          onTap: () => _editar(repuestos[indice]),
                          onEditar: () => _editar(repuestos[indice]),
                          onEliminar: () => _eliminar(repuestos[indice]),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RepuestoCard extends StatelessWidget {
  const _RepuestoCard({
    required this.repuesto,
    required this.onTap,
    required this.onEditar,
    required this.onEliminar,
  });

  final Repuesto repuesto;
  final VoidCallback onTap;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final bajo = repuesto.bajoStock;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 4, 12),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bajo
                      ? colores.errorContainer.withAlpha(120)
                      : colores.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  bajo ? Icons.warning_amber_rounded : Icons.settings_outlined,
                  size: 21,
                  color: bajo ? colores.error : colores.primary,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repuesto.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: colores.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            repuesto.codigo,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  fontSize: 9,
                                  color: colores.onSurfaceVariant,
                                ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          dinero(repuesto.precio),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: colores.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${repuesto.existencias}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: bajo ? colores.error : colores.onSurface,
                    ),
                  ),
                  Text(
                    'mín. ${repuesto.stockMinimo}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 9,
                      color: bajo ? colores.error : colores.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              PopupMenuButton<String>(
                tooltip: 'Opciones',
                onSelected: (accion) {
                  if (accion == 'editar') onEditar();
                  if (accion == 'eliminar') onEliminar();
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'editar', child: Text('Editar')),
                  PopupMenuItem(value: 'eliminar', child: Text('Eliminar')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Resumen extends StatelessWidget {
  const _Resumen({
    required this.icono,
    required this.valor,
    required this.etiqueta,
  });

  final IconData icono;
  final String valor;
  final String etiqueta;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: colores.surfaceContainerLow,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: colores.outlineVariant.withAlpha(120)),
      ),
      child: Row(
        children: [
          Icon(icono, size: 17, color: colores.primary),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  etiqueta,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(fontSize: 9, color: colores.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
