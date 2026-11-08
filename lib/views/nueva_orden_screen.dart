import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_state.dart';
import '../utils/formato.dart';
import '../viewmodels/orden_form_view_model.dart';
import '../widgets/formularios.dart';
import '../widgets/vacio_widget.dart';

class NuevaOrdenScreen extends StatefulWidget {
  const NuevaOrdenScreen({required this.appState, super.key});

  final AppState appState;

  @override
  State<NuevaOrdenScreen> createState() => _NuevaOrdenScreenState();
}

class _NuevaOrdenScreenState extends State<NuevaOrdenScreen> {
  late final OrdenFormViewModel viewModel = OrdenFormViewModel(
    appState: widget.appState,
  );

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Future<void> _agregarCliente() async {
    await mostrarFormularioCliente(context, widget.appState);
    if (!mounted) return;
    viewModel.refrescarCatalogos();
  }

  Future<void> _agregarVehiculo() async {
    final idCliente = viewModel.idCliente;
    if (idCliente == null) return;
    await mostrarFormularioVehiculo(
      context,
      widget.appState,
      idCliente: idCliente,
    );
    if (!mounted) return;
    viewModel.refrescarCatalogos();
  }

  void _guardar() {
    final resultado = viewModel.guardar();
    if (!resultado.ok) return;
    context.pushReplacement('/orden/${resultado.valor}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva orden'),
        leading: IconButton(
          tooltip: 'Cerrar',
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final colores = Theme.of(context).colorScheme;
          if (widget.appState.clientes.isEmpty) {
            return VacioWidget(
              icono: Icons.people_outline_rounded,
              titulo: 'Primero registrá un cliente',
              mensaje:
                  'Para crear una orden necesitás un cliente y al menos un '
                  'vehículo asociado.',
              accion: FilledButton.icon(
                onPressed: _agregarCliente,
                icon: const Icon(Icons.person_add_alt_rounded),
                label: const Text('Agregar cliente'),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 26),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colores.primaryContainer.withAlpha(105),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: colores.primary.withAlpha(45)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colores.surface.withAlpha(200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.assignment_add, color: colores.primary),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Orden OS ${viewModel.proximoNumero.toString().padLeft(4, '0')}',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Ingreso ${fechaCorta(DateTime.now())} · Estado inicial: Recibida',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: colores.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _Seccion(
                titulo: 'Cliente y vehículo',
                icono: Icons.directions_car_outlined,
                hijos: [
                  DropdownButtonFormField<String>(
                    key: ValueKey('cliente-${viewModel.idCliente}'),
                    initialValue: viewModel.idCliente,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Cliente *',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    items: [
                      for (final cliente in widget.appState.clientes)
                        DropdownMenuItem(
                          value: cliente.id,
                          child: Text(
                            cliente.nombre,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: viewModel.seleccionarCliente,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: _agregarCliente,
                      icon: const Icon(Icons.person_add_alt_rounded, size: 17),
                      label: const Text('Nuevo cliente'),
                    ),
                  ),
                  if (viewModel.vehiculos.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colores.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Este cliente todavía no tiene vehículos cargados.',
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: _agregarVehiculo,
                            icon: const Icon(Icons.add_rounded, size: 18),
                            label: const Text('Agregar vehículo'),
                          ),
                        ],
                      ),
                    )
                  else ...[
                    DropdownButtonFormField<String>(
                      key: ValueKey(
                        'vehiculo-${viewModel.idCliente}-${viewModel.idVehiculo}',
                      ),
                      initialValue: viewModel.idVehiculo,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Vehículo *',
                        prefixIcon: Icon(Icons.directions_car_outlined),
                      ),
                      items: [
                        for (final vehiculo in viewModel.vehiculos)
                          DropdownMenuItem(
                            value: vehiculo.id,
                            child: Text(
                              '${vehiculo.descripcion} · ${vehiculo.matricula}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: viewModel.seleccionarVehiculo,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.speed_rounded,
                          size: 14,
                          color: colores.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Último kilometraje: '
                          '${viewModel.vehiculoSeleccionado?.kilometraje ?? '-'} km',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: colores.onSurfaceVariant),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: _agregarVehiculo,
                          icon: const Icon(Icons.add_rounded, size: 16),
                          label: const Text('Vehículo'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 14),
              _Seccion(
                titulo: 'Asignación',
                icono: Icons.engineering_outlined,
                hijos: [
                  DropdownButtonFormField<String>(
                    key: ValueKey('mecanico-${viewModel.idMecanico}'),
                    initialValue: viewModel.idMecanico,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Mecánico responsable *',
                      prefixIcon: Icon(Icons.engineering_outlined),
                    ),
                    items: [
                      for (final mecanico in viewModel.mecanicos)
                        DropdownMenuItem(
                          value: mecanico.id,
                          child: Text(
                            '${mecanico.nombre} · ${mecanico.especialidad}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: viewModel.seleccionarMecanico,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _Seccion(
                titulo: 'Detalle del ingreso',
                icono: Icons.notes_rounded,
                hijos: [
                  TextField(
                    controller: viewModel.problemaController,
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Problema reportado *',
                      hintText:
                          'Ej. Ruido al frenar y vibración del tren delantero.',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: viewModel.kilometrajeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Kilometraje de ingreso (opcional)',
                      suffixText: 'km',
                      prefixIcon: Icon(Icons.speed_rounded),
                    ),
                  ),
                ],
              ),
              if (viewModel.error != null) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: colores.errorContainer.withAlpha(150),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 18,
                        color: colores.onErrorContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          viewModel.error!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colores.onErrorContainer),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) => FilledButton.icon(
            onPressed: viewModel.guardando ? null : _guardar,
            icon: const Icon(Icons.check_rounded),
            label: const Text('Crear orden de servicio'),
          ),
        ),
      ),
    );
  }
}

class _Seccion extends StatelessWidget {
  const _Seccion({
    required this.titulo,
    required this.icono,
    required this.hijos,
  });

  final String titulo;
  final IconData icono;
  final List<Widget> hijos;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icono, size: 18, color: colores.primary),
                const SizedBox(width: 8),
                Text(
                  titulo,
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...hijos,
          ],
        ),
      ),
    );
  }
}
