import 'package:flutter/material.dart';

import '../models/cliente.dart';
import '../models/repuesto.dart';
import '../models/vehiculo.dart';
import '../router/app_state.dart';
import '../viewmodels/formularios_view_model.dart';

Future<void> mostrarFormularioCliente(
  BuildContext context,
  AppState appState, {
  Cliente? cliente,
}) async {
  final guardado = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _FormularioCliente(appState: appState, cliente: cliente),
  );
  if (guardado == true && context.mounted) {
    _aviso(
      context,
      cliente == null ? 'Cliente creado.' : 'Cliente actualizado.',
    );
  }
}

Future<void> mostrarFormularioVehiculo(
  BuildContext context,
  AppState appState, {
  required String idCliente,
  Vehiculo? vehiculo,
}) async {
  final guardado = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _FormularioVehiculo(
      appState: appState,
      idCliente: idCliente,
      vehiculo: vehiculo,
    ),
  );
  if (guardado == true && context.mounted) {
    _aviso(
      context,
      vehiculo == null ? 'Vehículo agregado.' : 'Vehículo actualizado.',
    );
  }
}

Future<void> mostrarFormularioRepuesto(
  BuildContext context,
  AppState appState, {
  Repuesto? repuesto,
}) async {
  final guardado = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _FormularioRepuesto(appState: appState, repuesto: repuesto),
  );
  if (guardado == true && context.mounted) {
    _aviso(
      context,
      repuesto == null ? 'Repuesto agregado.' : 'Repuesto actualizado.',
    );
  }
}

void _aviso(BuildContext context, String texto) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(texto)));
}

class _FormularioCliente extends StatefulWidget {
  const _FormularioCliente({required this.appState, this.cliente});

  final AppState appState;
  final Cliente? cliente;

  @override
  State<_FormularioCliente> createState() => _FormularioClienteState();
}

class _FormularioClienteState extends State<_FormularioCliente> {
  late final ClienteFormViewModel viewModel = ClienteFormViewModel(
    appState: widget.appState,
    cliente: widget.cliente,
  );

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void _guardar() {
    if (viewModel.guardar() == null) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => _ContenedorFormulario(
        titulo: viewModel.editando ? 'Editar cliente' : 'Nuevo cliente',
        subtitulo: 'Datos de contacto del propietario.',
        error: viewModel.error,
        onGuardar: _guardar,
        hijos: [
          TextField(
            controller: viewModel.nombre,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nombre y apellido *',
              hintText: 'Ej. María Fernández',
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: viewModel.telefono,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Teléfono *',
              hintText: 'Ej. 35123456',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: viewModel.direccion,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Dirección (opcional)',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormularioVehiculo extends StatefulWidget {
  const _FormularioVehiculo({
    required this.appState,
    required this.idCliente,
    this.vehiculo,
  });

  final AppState appState;
  final String idCliente;
  final Vehiculo? vehiculo;

  @override
  State<_FormularioVehiculo> createState() => _FormularioVehiculoState();
}

class _FormularioVehiculoState extends State<_FormularioVehiculo> {
  late final VehiculoFormViewModel viewModel = VehiculoFormViewModel(
    appState: widget.appState,
    idCliente: widget.idCliente,
    vehiculo: widget.vehiculo,
  );

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void _guardar() {
    if (viewModel.guardar() == null) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => _ContenedorFormulario(
        titulo: viewModel.editando ? 'Editar vehículo' : 'Nuevo vehículo',
        subtitulo: 'La matrícula debe ser única.',
        error: viewModel.error,
        onGuardar: _guardar,
        hijos: [
          if (!viewModel.editando) ...[
            DropdownButtonFormField<String>(
              initialValue: viewModel.idCliente,
              decoration: const InputDecoration(
                labelText: 'Cliente *',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              items: [
                for (final cliente in widget.appState.clientes)
                  DropdownMenuItem(
                    value: cliente.id,
                    child: Text(cliente.nombre),
                  ),
              ],
              onChanged: viewModel.seleccionarCliente,
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: viewModel.matricula,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: 'Matrícula *',
                    hintText: 'AB123CD',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: viewModel.anio,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Año *'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: viewModel.marca,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Marca *'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: viewModel.modelo,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Modelo *'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: viewModel.kilometraje,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Kilometraje *',
              suffixText: 'km',
              prefixIcon: Icon(Icons.speed_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormularioRepuesto extends StatefulWidget {
  const _FormularioRepuesto({required this.appState, this.repuesto});

  final AppState appState;
  final Repuesto? repuesto;

  @override
  State<_FormularioRepuesto> createState() => _FormularioRepuestoState();
}

class _FormularioRepuestoState extends State<_FormularioRepuesto> {
  late final RepuestoFormViewModel viewModel = RepuestoFormViewModel(
    appState: widget.appState,
    repuesto: widget.repuesto,
  );

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void _guardar() {
    if (viewModel.guardar() == null) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => _ContenedorFormulario(
        titulo: viewModel.editando ? 'Editar repuesto' : 'Nuevo repuesto',
        subtitulo: 'El stock se descuenta al usarlo en una orden.',
        error: viewModel.error,
        onGuardar: _guardar,
        hijos: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: viewModel.codigo,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: 'Código *',
                    hintText: 'FIL-ACE',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: viewModel.nombre,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(labelText: 'Nombre *'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: viewModel.precio,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Precio de venta *',
              prefixText: '\$ ',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: viewModel.existencias,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Existencias *'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: viewModel.stockMinimo,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Stock mínimo *',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContenedorFormulario extends StatelessWidget {
  const _ContenedorFormulario({
    required this.titulo,
    required this.subtitulo,
    required this.hijos,
    required this.onGuardar,
    this.error,
  });

  final String titulo;
  final String subtitulo;
  final List<Widget> hijos;
  final VoidCallback onGuardar;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              titulo,
              style: tema.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitulo,
              style: tema.textTheme.bodySmall?.copyWith(
                color: tema.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            ...hijos,
            if (error != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tema.colorScheme.errorContainer.withAlpha(150),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 18,
                      color: tema.colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        error!,
                        style: tema.textTheme.bodySmall?.copyWith(
                          color: tema.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: FilledButton.icon(
                    onPressed: onGuardar,
                    icon: const Icon(Icons.check_rounded, size: 19),
                    label: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
