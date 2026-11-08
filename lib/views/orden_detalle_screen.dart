import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/orden_servicio.dart';
import '../models/repuesto.dart';
import '../router/app_state.dart';
import '../utils/formato.dart';
import '../viewmodels/formularios_view_model.dart' show numero;
import '../viewmodels/orden_detalle_view_model.dart';
import '../widgets/boton_tema.dart';
import '../widgets/estado_chip.dart';
import '../widgets/vacio_widget.dart';

class OrdenDetalleScreen extends StatefulWidget {
  const OrdenDetalleScreen({
    required this.appState,
    required this.idOrden,
    super.key,
  });

  final AppState appState;
  final String idOrden;

  @override
  State<OrdenDetalleScreen> createState() => _OrdenDetalleScreenState();
}

class _OrdenDetalleScreenState extends State<OrdenDetalleScreen> {
  late final OrdenDetalleViewModel viewModel = OrdenDetalleViewModel(
    appState: widget.appState,
    idOrden: widget.idOrden,
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

  Future<void> _agregarManoObra() async {
    final datos = await showDialog<({String descripcion, double precio})>(
      context: context,
      builder: (_) => const _DialogoManoObra(),
    );
    if (datos == null || !mounted) return;
    final error = viewModel.agregarManoObra(datos.descripcion, datos.precio);
    if (error != null) {
      _aviso(error);
    } else {
      _aviso('Mano de obra agregada.');
    }
  }

  Future<void> _agregarRepuesto() async {
    final datos = await showDialog<({String idRepuesto, int cantidad})>(
      context: context,
      builder: (_) =>
          _DialogoRepuesto(repuestos: viewModel.repuestosDisponibles),
    );
    if (datos == null || !mounted) return;
    final error = viewModel.agregarRepuesto(datos.idRepuesto, datos.cantidad);
    if (error != null) {
      _aviso(error);
    } else {
      _aviso('Repuesto descontado del stock y agregado a la orden.');
    }
  }

  Future<void> _registrarPago() async {
    final orden = viewModel.orden;
    if (orden == null) return;
    final datos = await showDialog<({double monto, String metodo})>(
      context: context,
      builder: (_) => _DialogoPago(saldo: orden.saldo),
    );
    if (datos == null || !mounted) return;
    final error = viewModel.registrarPago(datos.monto, datos.metodo);
    if (error != null) {
      _aviso(error);
    } else {
      _aviso('Pago registrado.');
    }
  }

  Future<void> _avanzar() async {
    final orden = viewModel.orden;
    if (orden == null || orden.estado.siguiente == null) return;
    final siguiente = orden.estado.siguiente!;

    if (siguiente == EstadoOrden.entregada && orden.saldo > 0.009) {
      final confirmar = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Entregar con saldo pendiente'),
          content: Text(
            'La orden tiene un saldo de ${dinero(orden.saldo)}. '
            'Podés entregarla igual y el saldo quedará registrado como deuda '
            'del cliente.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Volver'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Entregar igual'),
            ),
          ],
        ),
      );
      if (confirmar != true || !mounted) return;
    }

    final error = viewModel.avanzar();
    if (error != null) {
      _aviso(error);
    } else {
      _aviso('La orden pasó a ${siguiente.etiqueta.toLowerCase()}.');
    }
  }

  Future<void> _cancelar() async {
    final orden = viewModel.orden;
    if (orden == null) return;
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar orden'),
        content: const Text(
          'La orden quedará cancelada y se devolverán al inventario los '
          'repuestos utilizados. Esta acción no se puede deshacer.',
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
            child: const Text('Cancelar orden'),
          ),
        ],
      ),
    );
    if (confirmar != true || !mounted) return;

    final error = viewModel.cancelar();
    if (error != null) {
      _aviso(error);
    } else {
      _aviso('Orden cancelada y stock restituido.');
    }
  }

  Future<void> _confirmarEliminar(
    String titulo,
    String mensaje,
    String? Function() accion,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
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
    final error = accion();
    if (error != null) _aviso(error);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final orden = viewModel.orden;
        if (orden == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Orden')),
            body: const VacioWidget(
              icono: Icons.search_off_rounded,
              titulo: 'Orden no encontrada',
              mensaje:
                  'Puede que haya sido eliminada o el enlace no sea válido.',
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('OS ${orden.numero.toString().padLeft(4, '0')}'),
            actions: [
              if (orden.abierta)
                PopupMenuButton<String>(
                  tooltip: 'Más acciones',
                  onSelected: (accion) {
                    if (accion == 'cancelar') _cancelar();
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'cancelar',
                      child: Row(
                        children: [
                          Icon(
                            Icons.cancel_outlined,
                            size: 20,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(width: 10),
                          const Text('Cancelar orden'),
                        ],
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
              _CabeceraOrden(
                orden: orden,
                appState: widget.appState,
                onCliente: () => context.push('/cliente/${orden.idCliente}'),
                onVehiculo: () => context.push('/vehiculo/${orden.idVehiculo}'),
              ),
              const SizedBox(height: 14),
              if (orden.cancelada)
                _AvisoEstado(
                  color: Theme.of(context).colorScheme.error,
                  icono: Icons.cancel_outlined,
                  titulo: 'Orden cancelada',
                  mensaje:
                      'No admite nuevas modificaciones. Los repuestos fueron '
                      'devueltos al inventario.',
                )
              else ...[
                _Tarjeta(
                  titulo: 'Estado del servicio',
                  icono: Icons.route_outlined,
                  hijos: [
                    _LineaEstados(actual: orden.estado),
                    const SizedBox(height: 16),
                    if (orden.estado.siguiente != null)
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _avanzar,
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: Text(
                            orden.estado.siguiente == EstadoOrden.entregada
                                ? 'Marcar como entregada'
                                : 'Pasar a ${orden.estado.siguiente!.etiqueta}',
                          ),
                        ),
                      ),
                    if (orden.estado == EstadoOrden.lista &&
                        orden.saldo > 0.009) ...[
                      const SizedBox(height: 8),
                      _AvisoEstado(
                        color: Theme.of(context).colorScheme.tertiary,
                        icono: Icons.info_outline_rounded,
                        titulo: 'Saldo pendiente',
                        mensaje:
                            'Antes de entregar quedan ${dinero(orden.saldo)} '
                            'por cobrar. Podés registrar un pago parcial.',
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 14),
                _Tarjeta(
                  titulo: 'Mano de obra',
                  icono: Icons.handyman_outlined,
                  accion: TextButton.icon(
                    onPressed: _agregarManoObra,
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Agregar'),
                  ),
                  hijos: [
                    if (orden.manoObra.isEmpty)
                      const _TextoVacio('Todavía no se cargó mano de obra.')
                    else
                      for (final trabajo in orden.manoObra)
                        _FilaEditable(
                          titulo: trabajo.descripcion,
                          subtitulo: 'Mano de obra',
                          valor: dineroCorto(trabajo.precio),
                          onEliminar: () => _confirmarEliminar(
                            'Eliminar mano de obra',
                            '¿Quitar "${trabajo.descripcion}" de la orden?',
                            () => viewModel.eliminarManoObra(trabajo.id),
                          ),
                        ),
                    const Divider(height: 22),
                    _TotalFila(
                      etiqueta: 'Subtotal mano de obra',
                      valor: dinero(orden.totalManoObra),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _Tarjeta(
                  titulo: 'Repuestos utilizados',
                  icono: Icons.inventory_2_outlined,
                  accion: TextButton.icon(
                    onPressed: _agregarRepuesto,
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Agregar'),
                  ),
                  hijos: [
                    if (orden.repuestos.isEmpty)
                      const _TextoVacio(
                        'No se descontaron repuestos del inventario.',
                      )
                    else
                      for (final usado in orden.repuestos)
                        _FilaEditable(
                          titulo: usado.nombre,
                          subtitulo:
                              '${usado.codigo} · ${usado.cantidad} × ${dineroCorto(usado.precioUnitario)}',
                          valor: dineroCorto(usado.subtotal),
                          onEliminar: () => _confirmarEliminar(
                            'Quitar repuesto',
                            'Se devolverán ${usado.cantidad} unidades de '
                                '"${usado.nombre}" al inventario.',
                            () => viewModel.eliminarRepuesto(usado.idRepuesto),
                          ),
                        ),
                    const Divider(height: 22),
                    _TotalFila(
                      etiqueta: 'Subtotal repuestos',
                      valor: dinero(orden.totalRepuestos),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _Tarjeta(
                  titulo: 'Pagos y saldo',
                  icono: Icons.payments_outlined,
                  accion: orden.saldo > 0.009
                      ? TextButton.icon(
                          onPressed: _registrarPago,
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: const Text('Pago'),
                        )
                      : null,
                  hijos: [
                    if (orden.pagos.isEmpty)
                      const _TextoVacio('Sin pagos registrados.')
                    else
                      for (final pago in orden.pagos)
                        _FilaEditable(
                          titulo: pago.metodo,
                          subtitulo: fechaHora(pago.fecha),
                          valor: dineroCorto(pago.monto),
                          onEliminar: () => _confirmarEliminar(
                            'Eliminar pago',
                            '¿Quitar el pago de ${dinero(pago.monto)}?',
                            () => viewModel.eliminarPago(pago.id),
                          ),
                        ),
                    const Divider(height: 22),
                    _TotalFila(
                      etiqueta: 'Total de la orden',
                      valor: dinero(orden.total),
                      destacado: true,
                    ),
                    const SizedBox(height: 7),
                    _TotalFila(
                      etiqueta: 'Pagado',
                      valor: dinero(orden.pagado),
                      color: const Color(0xFF1E7A4C),
                    ),
                    const SizedBox(height: 7),
                    _TotalFila(
                      etiqueta: 'Saldo pendiente',
                      valor: dinero(orden.saldo),
                      color: orden.saldo > 0.009
                          ? Theme.of(context).colorScheme.error
                          : const Color(0xFF1E7A4C),
                      destacado: true,
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _CabeceraOrden extends StatelessWidget {
  const _CabeceraOrden({
    required this.orden,
    required this.appState,
    required this.onCliente,
    required this.onVehiculo,
  });

  final OrdenServicio orden;
  final AppState appState;
  final VoidCallback onCliente;
  final VoidCallback onVehiculo;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final cliente = appState.clientePorId(orden.idCliente);
    final vehiculo = appState.vehiculoPorId(orden.idVehiculo);
    final mecanico = appState.mecanicoPorId(orden.idMecanico);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colores.primaryContainer.withAlpha(150),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.directions_car_filled_rounded,
                    color: colores.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehiculo?.descripcion ?? 'Vehículo',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        vehiculo?.matricula ?? '-',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: colores.onSurfaceVariant,
                              letterSpacing: .5,
                            ),
                      ),
                    ],
                  ),
                ),
                EstadoChip(estado: orden.estado),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onCliente,
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  side: BorderSide(color: colores.outlineVariant),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 18,
                      color: colores.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        cliente?.nombre ?? 'Cliente',
                        style: TextStyle(
                          color: colores.onSurface,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
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
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onVehiculo,
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  side: BorderSide(color: colores.outlineVariant),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      size: 18,
                      color: colores.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Ver historial del vehículo',
                      style: TextStyle(
                        color: colores.onSurface,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 19,
                      color: colores.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 24),
            _Dato(
              icono: Icons.engineering_outlined,
              etiqueta: 'Mecánico',
              valor: mecanico?.nombre ?? 'Sin asignar',
            ),
            const SizedBox(height: 7),
            _Dato(
              icono: Icons.calendar_today_outlined,
              etiqueta: 'Ingreso',
              valor: fechaHora(orden.fechaIngreso),
            ),
            if (orden.kilometrajeIngreso != null) ...[
              const SizedBox(height: 7),
              _Dato(
                icono: Icons.speed_rounded,
                etiqueta: 'Kilometraje',
                valor: '${orden.kilometrajeIngreso} km',
              ),
            ],
            if (orden.fechaEntrega != null) ...[
              const SizedBox(height: 7),
              _Dato(
                icono: Icons.task_alt_rounded,
                etiqueta: 'Entrega',
                valor: fechaHora(orden.fechaEntrega!),
              ),
            ],
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colores.surfaceContainerHighest.withAlpha(150),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Problema reportado',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colores.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    orden.problema,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LineaEstados extends StatelessWidget {
  const _LineaEstados({required this.actual});

  final EstadoOrden actual;

  @override
  Widget build(BuildContext context) {
    const pasos = [
      EstadoOrden.recibida,
      EstadoOrden.diagnostico,
      EstadoOrden.reparacion,
      EstadoOrden.lista,
      EstadoOrden.entregada,
    ];
    final colores = Theme.of(context).colorScheme;
    final actualIndice = pasos.indexOf(actual);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < pasos.length; i++)
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    if (i > 0)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: i <= actualIndice
                              ? colores.primary
                              : colores.outlineVariant,
                        ),
                      ),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i <= actualIndice
                            ? colores.primary
                            : colores.surfaceContainerHighest,
                        border: Border.all(
                          color: i <= actualIndice
                              ? colores.primary
                              : colores.outlineVariant,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        i < actualIndice ? Icons.check_rounded : Icons.circle,
                        size: i < actualIndice ? 14 : 6,
                        color: i <= actualIndice
                            ? colores.onPrimary
                            : colores.outline,
                      ),
                    ),
                    if (i < pasos.length - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: i < actualIndice
                              ? colores.primary
                              : colores.outlineVariant,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    pasos[i].etiqueta,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 9,
                      height: 1.25,
                      fontWeight: i == actualIndice
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: i <= actualIndice
                          ? colores.primary
                          : colores.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Tarjeta extends StatelessWidget {
  const _Tarjeta({
    required this.titulo,
    required this.icono,
    required this.hijos,
    this.accion,
  });

  final String titulo;
  final IconData icono;
  final List<Widget> hijos;
  final Widget? accion;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icono, size: 18, color: colores.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                ?accion,
              ],
            ),
            const SizedBox(height: 4),
            ...hijos,
          ],
        ),
      ),
    );
  }
}

class _FilaEditable extends StatelessWidget {
  const _FilaEditable({
    required this.titulo,
    required this.subtitulo,
    required this.valor,
    required this.onEliminar,
  });

  final String titulo;
  final String subtitulo;
  final String valor;
  final VoidCallback onEliminar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  subtitulo,
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: colores.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            valor,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
              tooltip: 'Eliminar',
              padding: EdgeInsets.zero,
              onPressed: onEliminar,
              icon: Icon(
                Icons.close_rounded,
                size: 17,
                color: colores.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalFila extends StatelessWidget {
  const _TotalFila({
    required this.etiqueta,
    required this.valor,
    this.color,
    this.destacado = false,
  });

  final String etiqueta;
  final String valor;
  final Color? color;
  final bool destacado;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          etiqueta,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: destacado ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        const Spacer(),
        Text(
          valor,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w700, color: color),
        ),
      ],
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
        Icon(icono, size: 16, color: colores.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(
          '$etiqueta: ',
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colores.onSurfaceVariant),
        ),
        Expanded(
          child: Text(
            valor,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _TextoVacio extends StatelessWidget {
  const _TextoVacio(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        texto,
        style: Theme.of(context).textTheme.bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }
}

class _AvisoEstado extends StatelessWidget {
  const _AvisoEstado({
    required this.color,
    required this.icono,
    required this.titulo,
    required this.mensaje,
  });

  final Color color;
  final IconData icono;
  final String titulo;
  final String mensaje;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: color.withAlpha(65)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600, color: color),
                ),
                const SizedBox(height: 2),
                Text(
                  mensaje,
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogoManoObra extends StatefulWidget {
  const _DialogoManoObra();

  @override
  State<_DialogoManoObra> createState() => _DialogoManoObraState();
}

class _DialogoManoObraState extends State<_DialogoManoObra> {
  final descripcion = TextEditingController();
  final precio = TextEditingController();
  String? error;

  @override
  void dispose() {
    descripcion.dispose();
    precio.dispose();
    super.dispose();
  }

  void _agregar() {
    final monto = numero(precio.text);
    if (descripcion.text.trim().length < 3) {
      setState(() => error = 'Describe el trabajo realizado.');
      return;
    }
    if (monto == null || monto <= 0) {
      setState(() => error = 'Ingresá un precio mayor a cero.');
      return;
    }
    Navigator.pop(context, (
      descripcion: descripcion.text.trim(),
      precio: monto,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar mano de obra'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: descripcion,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Descripción *',
                hintText: 'Ej. Cambio de pastillas de freno',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: precio,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Precio *',
                prefixText: '\$ ',
              ),
            ),
            if (error != null) ...[
              const SizedBox(height: 10),
              Text(
                error!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _agregar, child: const Text('Agregar')),
      ],
    );
  }
}

class _DialogoRepuesto extends StatefulWidget {
  const _DialogoRepuesto({required this.repuestos});

  final List<Repuesto> repuestos;

  @override
  State<_DialogoRepuesto> createState() => _DialogoRepuestoState();
}

class _DialogoRepuestoState extends State<_DialogoRepuesto> {
  String? idRepuesto;
  final cantidad = TextEditingController(text: '1');
  String? error;

  @override
  void initState() {
    super.initState();
    if (widget.repuestos.isNotEmpty) idRepuesto = widget.repuestos.first.id;
  }

  @override
  void dispose() {
    cantidad.dispose();
    super.dispose();
  }

  Repuesto? get seleccionado =>
      widget.repuestos.where((item) => item.id == idRepuesto).firstOrNull;

  void _agregar() {
    final cantidadNumero = int.tryParse(cantidad.text.trim());
    final repuesto = seleccionado;
    if (repuesto == null) {
      setState(() => error = 'Seleccioná un repuesto.');
      return;
    }
    if (cantidadNumero == null || cantidadNumero <= 0) {
      setState(() => error = 'La cantidad debe ser mayor a cero.');
      return;
    }
    if (cantidadNumero > repuesto.existencias) {
      setState(() {
        error = 'Solo hay ${repuesto.existencias} unidades disponibles.';
      });
      return;
    }
    Navigator.pop(context, (idRepuesto: repuesto.id, cantidad: cantidadNumero));
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return AlertDialog(
      title: const Text('Agregar repuesto'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.repuestos.isEmpty)
              const Text(
                'No hay repuestos con stock disponible. Cargá stock desde '
                'Inventario para poder usarlos.',
              )
            else ...[
              DropdownButtonFormField<String>(
                key: ValueKey(idRepuesto),
                initialValue: idRepuesto,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Repuesto'),
                items: [
                  for (final repuesto in widget.repuestos)
                    DropdownMenuItem(
                      value: repuesto.id,
                      child: Text(
                        '${repuesto.nombre} · ${repuesto.existencias} u.',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: (valor) => setState(() {
                  idRepuesto = valor;
                  error = null;
                }),
              ),
              const SizedBox(height: 10),
              if (seleccionado != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colores.surfaceContainerHighest.withAlpha(150),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${seleccionado!.codigo} · ${dinero(seleccionado!.precio)} '
                    'c/u · Stock: ${seleccionado!.existencias}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              const SizedBox(height: 12),
              TextField(
                controller: cantidad,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad',
                  suffixText: 'unidades',
                ),
              ),
              if (error != null) ...[
                const SizedBox(height: 10),
                Text(
                  error!,
                  style: TextStyle(color: colores.error, fontSize: 12),
                ),
              ],
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: widget.repuestos.isEmpty ? null : _agregar,
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}

class _DialogoPago extends StatefulWidget {
  const _DialogoPago({required this.saldo});

  final double saldo;

  @override
  State<_DialogoPago> createState() => _DialogoPagoState();
}

class _DialogoPagoState extends State<_DialogoPago> {
  late final monto = TextEditingController(
    text: widget.saldo == widget.saldo.roundToDouble()
        ? widget.saldo.toStringAsFixed(0)
        : widget.saldo.toStringAsFixed(2),
  );
  String metodo = 'Efectivo';
  String? error;

  static const metodos = [
    'Efectivo',
    'Transferencia',
    'Tarjeta',
    'Mercado Pago',
    'Cheque',
  ];

  @override
  void dispose() {
    monto.dispose();
    super.dispose();
  }

  void _registrar() {
    final valor = numero(monto.text);
    if (valor == null || valor <= 0) {
      setState(() => error = 'Ingresá un monto válido.');
      return;
    }
    if (valor > widget.saldo + 0.009) {
      setState(() {
        error = 'El monto supera el saldo de ${dinero(widget.saldo)}.';
      });
      return;
    }
    Navigator.pop(context, (monto: valor, metodo: metodo));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar pago'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: monto,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Monto *',
                prefixText: '\$ ',
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: metodo,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Medio de pago'),
              items: [
                for (final item in metodos)
                  DropdownMenuItem(value: item, child: Text(item)),
              ],
              onChanged: (valor) {
                if (valor != null) setState(() => metodo = valor);
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Saldo pendiente: ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  dinero(widget.saldo),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
            if (error != null) ...[
              const SizedBox(height: 10),
              Text(
                error!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _registrar, child: const Text('Registrar')),
      ],
    );
  }
}
