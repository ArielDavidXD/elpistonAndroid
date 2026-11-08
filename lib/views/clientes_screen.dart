import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/cliente.dart';
import '../router/app_state.dart';
import '../utils/formato.dart';
import '../viewmodels/clientes_view_model.dart';
import '../widgets/boton_tema.dart';
import '../widgets/buscador.dart';
import '../widgets/formularios.dart';
import '../widgets/vacio_widget.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({required this.appState, super.key});

  final AppState appState;

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  late final ClientesViewModel viewModel = ClientesViewModel(
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
        title: const Text('Clientes'),
        actions: const [BotonTema(), SizedBox(width: 6)],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab-clientes',
        onPressed: () => mostrarFormularioCliente(context, widget.appState),
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('Cliente'),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final clientes = viewModel.clientes;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: Buscador(
                  hint: 'Buscar por nombre, teléfono o patente...',
                  onChanged: viewModel.buscar,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Row(
                  children: [
                    _DatoResumen(
                      icono: Icons.people_alt_outlined,
                      texto: '${viewModel.total} clientes',
                    ),
                    const SizedBox(width: 8),
                    _DatoResumen(
                      icono: Icons.account_balance_wallet_outlined,
                      texto: '${viewModel.conDeuda} con deuda',
                      color: viewModel.conDeuda > 0
                          ? Theme.of(context).colorScheme.error
                          : null,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: clientes.isEmpty
                    ? VacioWidget(
                        icono: Icons.people_outline_rounded,
                        titulo: 'Sin clientes',
                        mensaje: 'Agregá el primer cliente del taller.',
                        accion: FilledButton.icon(
                          onPressed: () => mostrarFormularioCliente(
                            context,
                            widget.appState,
                          ),
                          icon: const Icon(Icons.person_add_alt_1_rounded),
                          label: const Text('Agregar cliente'),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 2, 16, 100),
                        itemCount: clientes.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, indice) => _ClienteCard(
                          cliente: clientes[indice],
                          appState: widget.appState,
                          saldo: viewModel.saldoDe(clientes[indice].id),
                          onTap: () =>
                              context.push('/cliente/${clientes[indice].id}'),
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

class _ClienteCard extends StatelessWidget {
  const _ClienteCard({
    required this.cliente,
    required this.appState,
    required this.saldo,
    required this.onTap,
  });

  final Cliente cliente;
  final AppState appState;
  final double saldo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final vehiculos = appState.vehiculosDeCliente(cliente.id);
    final ordenes = appState.ordenesDeCliente(cliente.id);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: colores.secondaryContainer,
                    foregroundColor: colores.onSecondaryContainer,
                    child: Text(
                      iniciales(cliente.nombre),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cliente.nombre,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 13,
                              color: colores.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              cliente.telefono,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(color: colores.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (saldo > 0.009)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colores.errorContainer.withAlpha(135),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Debe ${dineroCorto(saldo)}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colores.onErrorContainer,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colores.onSurfaceVariant,
                  ),
                ],
              ),
              const Divider(height: 22),
              Row(
                children: [
                  Icon(
                    Icons.directions_car_outlined,
                    size: 14,
                    color: colores.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${vehiculos.length} ${vehiculos.length == 1 ? 'vehículo' : 'vehículos'}',
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: colores.onSurfaceVariant),
                  ),
                  const SizedBox(width: 14),
                  Icon(
                    Icons.assignment_outlined,
                    size: 14,
                    color: colores.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${ordenes.length} ${ordenes.length == 1 ? 'orden' : 'órdenes'}',
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: colores.onSurfaceVariant),
                  ),
                  const Spacer(),
                  if (cliente.direccion != null)
                    Flexible(
                      child: Text(
                        cliente.direccion!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(color: colores.onSurfaceVariant),
                      ),
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

class _DatoResumen extends StatelessWidget {
  const _DatoResumen({required this.icono, required this.texto, this.color});

  final IconData icono;
  final String texto;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tono = color ?? Theme.of(context).colorScheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: tono.withAlpha(18),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icono, size: 14, color: tono),
          const SizedBox(width: 5),
          Text(
            texto,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: tono, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
