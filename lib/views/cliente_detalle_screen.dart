import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/vehiculo.dart';
import '../router/app_state.dart';
import '../utils/formato.dart';
import '../viewmodels/cliente_detalle_view_model.dart';
import '../widgets/boton_tema.dart';
import '../widgets/formularios.dart';
import '../widgets/orden_card.dart';
import '../widgets/seccion_titulo.dart';
import '../widgets/vacio_widget.dart';

class ClienteDetalleScreen extends StatefulWidget {
  const ClienteDetalleScreen({
    required this.appState,
    required this.idCliente,
    super.key,
  });

  final AppState appState;
  final String idCliente;

  @override
  State<ClienteDetalleScreen> createState() => _ClienteDetalleScreenState();
}

class _ClienteDetalleScreenState extends State<ClienteDetalleScreen> {
  late final ClienteDetalleViewModel viewModel = ClienteDetalleViewModel(
    appState: widget.appState,
    idCliente: widget.idCliente,
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

  Future<void> _editarCliente() async {
    final cliente = viewModel.cliente;
    if (cliente == null) return;
    await mostrarFormularioCliente(context, widget.appState, cliente: cliente);
  }

  Future<void> _agregarVehiculo() async {
    await mostrarFormularioVehiculo(
      context,
      widget.appState,
      idCliente: widget.idCliente,
    );
  }

  Future<void> _editarVehiculo(Vehiculo vehiculo) async {
    await mostrarFormularioVehiculo(
      context,
      widget.appState,
      idCliente: vehiculo.idCliente,
      vehiculo: vehiculo,
    );
  }

  Future<void> _eliminarVehiculo(Vehiculo vehiculo) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar vehículo'),
        content: Text(
          '¿Eliminar ${vehiculo.descripcion} (${vehiculo.matricula})?',
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
    final error = viewModel.eliminarVehiculo(vehiculo.id);
    if (error != null) _aviso(error);
  }

  Future<void> _eliminarCliente() async {
    final cliente = viewModel.cliente;
    if (cliente == null) return;
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar cliente'),
        content: Text(
          '¿Eliminar a ${cliente.nombre}? También se eliminarán sus vehículos '
          'sin órdenes asociadas.',
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
    final error = widget.appState.eliminarCliente(widget.idCliente);
    if (error != null) {
      _aviso(error);
    } else if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final cliente = viewModel.cliente;
        if (cliente == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Cliente')),
            body: const VacioWidget(
              icono: Icons.person_off_outlined,
              titulo: 'Cliente no encontrado',
              mensaje: 'Puede que haya sido eliminado.',
            ),
          );
        }

        final colores = Theme.of(context).colorScheme;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Ficha del cliente'),
            actions: [
              PopupMenuButton<String>(
                tooltip: 'Acciones',
                onSelected: (accion) {
                  if (accion == 'editar') _editarCliente();
                  if (accion == 'eliminar') _eliminarCliente();
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'editar',
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.edit_outlined),
                      title: Text('Editar datos'),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'eliminar',
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.delete_outline_rounded),
                      title: Text('Eliminar cliente'),
                    ),
                  ),
                ],
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
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: colores.primaryContainer,
                            foregroundColor: colores.onPrimaryContainer,
                            child: Text(
                              iniciales(cliente.nombre),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cliente.nombre,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                if (cliente.direccion != null)
                                  Text(
                                    cliente.direccion!,
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
                            child: _DatoContacto(
                              icono: Icons.phone_outlined,
                              etiqueta: 'Teléfono',
                              valor: cliente.telefono,
                            ),
                          ),
                          Expanded(
                            child: _DatoContacto(
                              icono: Icons.calendar_today_outlined,
                              etiqueta: 'Cliente desde',
                              valor: fechaCorta(cliente.creadoEn),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (viewModel.saldo > 0.009) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colores.errorContainer.withAlpha(100),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colores.error.withAlpha(60)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        color: colores.onErrorContainer,
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Saldo pendiente',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: colores.onErrorContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              dinero(viewModel.saldo),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: colores.onErrorContainer,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${viewModel.abiertas} abiertas',
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(color: colores.onErrorContainer),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              SeccionTitulo(
                titulo: 'Vehículos',
                subtitulo: '${viewModel.vehiculos.length} registrados',
                accion: TextButton.icon(
                  onPressed: _agregarVehiculo,
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Agregar'),
                ),
              ),
              const SizedBox(height: 9),
              if (viewModel.vehiculos.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions_car_outlined,
                          color: colores.onSurfaceVariant,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'El cliente no tiene vehículos cargados.',
                          ),
                        ),
                        OutlinedButton(
                          onPressed: _agregarVehiculo,
                          child: const Text('Agregar'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                for (final vehiculo in viewModel.vehiculos) ...[
                  _VehiculoCard(
                    vehiculo: vehiculo,
                    ordenes: widget.appState
                        .ordenesDeVehiculo(vehiculo.id)
                        .length,
                    onTap: () => context.push('/vehiculo/${vehiculo.id}'),
                    onEditar: () => _editarVehiculo(vehiculo),
                    onEliminar: () => _eliminarVehiculo(vehiculo),
                  ),
                  const SizedBox(height: 9),
                ],
              const SizedBox(height: 16),
              SeccionTitulo(
                titulo: 'Historial de órdenes',
                subtitulo: '${viewModel.ordenes.length} registradas',
              ),
              const SizedBox(height: 9),
              if (viewModel.ordenes.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      'Todavía no hay órdenes de servicio para este cliente.',
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

class _VehiculoCard extends StatelessWidget {
  const _VehiculoCard({
    required this.vehiculo,
    required this.ordenes,
    required this.onTap,
    required this.onEditar,
    required this.onEliminar,
  });

  final Vehiculo vehiculo;
  final int ordenes;
  final VoidCallback onTap;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: colores.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  Icons.directions_car_filled_outlined,
                  size: 21,
                  color: colores.primary,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehiculo.descripcion,
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${vehiculo.matricula} · ${vehiculo.anio} · '
                      '${vehiculo.kilometraje} km',
                      style: Theme.of(context).textTheme.labelSmall
                          ?.copyWith(color: colores.onSurfaceVariant),
                    ),
                    Text(
                      '$ordenes ${ordenes == 1 ? 'orden' : 'órdenes'} de servicio',
                      style: Theme.of(context).textTheme.labelSmall
                          ?.copyWith(color: colores.primary),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                tooltip: 'Opciones del vehículo',
                onSelected: (accion) {
                  if (accion == 'editar') onEditar();
                  if (accion == 'eliminar') onEliminar();
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'editar', child: Text('Editar')),
                  PopupMenuItem(value: 'eliminar', child: Text('Eliminar')),
                ],
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 19,
                color: colores.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DatoContacto extends StatelessWidget {
  const _DatoContacto({
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
        Icon(icono, size: 16, color: colores.onSurfaceVariant),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
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
        ),
      ],
    );
  }
}
