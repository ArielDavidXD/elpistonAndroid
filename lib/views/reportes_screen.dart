import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/orden_servicio.dart';
import '../router/app_state.dart';
import '../utils/formato.dart';
import '../viewmodels/reportes_view_model.dart';
import '../widgets/boton_tema.dart';
import '../widgets/estado_chip.dart';
import '../widgets/seccion_titulo.dart';
import '../widgets/stat_card.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({required this.appState, super.key});

  final AppState appState;

  @override
  State<ReportesScreen> createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  late final ReportesViewModel viewModel = ReportesViewModel(
    appState: widget.appState,
  );

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Future<void> _elegirRango() async {
    final ahora = DateTime.now();
    final rango = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: ahora,
      initialDateRange: DateTimeRange(
        start: viewModel.desde,
        end: viewModel.hasta,
      ),
      helpText: 'Período del reporte',
      cancelText: 'Cancelar',
      confirmText: 'Aplicar',
      saveText: 'Aplicar',
    );
    if (rango == null || !mounted) return;
    viewModel.establecerPersonalizado(rango.start, rango.end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
        actions: const [BotonTema(), SizedBox(width: 6)],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final colores = Theme.of(context).colorScheme;
          final abiertas = viewModel.abiertasPorEstado.values.fold(
            0,
            (total, valor) => total + valor,
          );
          final maxCarga = viewModel.mecanicos.fold(
            1,
            (maximo, item) => item.abiertas > maximo ? item.abiertas : maximo,
          );

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 30),
            children: [
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final periodo in PeriodoReporte.values) ...[
                      ChoiceChip(
                        selected: viewModel.periodo == periodo,
                        onSelected: (_) {
                          if (periodo == PeriodoReporte.personalizado) {
                            _elegirRango();
                          } else {
                            viewModel.cambiarPeriodo(periodo);
                          }
                        },
                        showCheckmark: false,
                        label: Text(periodo.etiqueta),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    size: 15,
                    color: colores.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    viewModel.etiquetaRango,
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: colores.onSurfaceVariant),
                  ),
                  if (viewModel.periodo == PeriodoReporte.personalizado) ...[
                    const Spacer(),
                    Text(
                      'Personalizado',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colores.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 14),
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
                          icono: Icons.receipt_long_outlined,
                          etiqueta: 'Facturado',
                          valor: dineroCorto(viewModel.facturado),
                          detalle: '${viewModel.entregadas.length} entregadas',
                        ),
                      ),
                      SizedBox(
                        width: ancho,
                        child: StatCard(
                          icono: Icons.payments_outlined,
                          etiqueta: 'Cobrado',
                          valor: dineroCorto(viewModel.cobrado),
                          detalle: 'Pagos del período',
                          color: const Color(0xFF1E7A4C),
                        ),
                      ),
                      SizedBox(
                        width: ancho,
                        child: StatCard(
                          icono: Icons.account_balance_wallet_outlined,
                          etiqueta: 'Saldo por cobrar',
                          valor: dineroCorto(viewModel.saldo),
                          detalle: 'Deuda total actual',
                          color: colores.tertiary,
                        ),
                      ),
                      SizedBox(
                        width: ancho,
                        child: StatCard(
                          icono: Icons.trending_up_rounded,
                          etiqueta: 'Promedio por orden',
                          valor: dineroCorto(viewModel.promedio),
                          detalle: 'En el período',
                          color: const Color(0xFF3E6A9E),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              SeccionTitulo(
                titulo: 'Órdenes abiertas por estado',
                subtitulo: '$abiertas órdenes en curso',
              ),
              const SizedBox(height: 9),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: abiertas == 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'No hay órdenes abiertas. ¡Todo al día!',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colores.onSurfaceVariant),
                          ),
                        )
                      : Column(
                          children: [
                            for (final estado in EstadoOrden.values)
                              if (estado.abierta &&
                                  (viewModel.abiertasPorEstado[estado] ?? 0) >
                                      0)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                  ),
                                  child: Row(
                                    children: [
                                      EstadoChip(
                                        estado: estado,
                                        compacto: true,
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${viewModel.abiertasPorEstado[estado]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),
              const SeccionTitulo(
                titulo: 'Carga por mecánico',
                subtitulo: 'Órdenes abiertas y entregas del período',
              ),
              const SizedBox(height: 9),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      for (var i = 0; i < viewModel.mecanicos.length; i++) ...[
                        if (i > 0) const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                    backgroundColor: colores.secondaryContainer,
                                    foregroundColor:
                                        colores.onSecondaryContainer,
                                    child: Text(
                                      iniciales(viewModel.mecanicos[i].nombre),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          viewModel.mecanicos[i].nombre,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          viewModel.mecanicos[i].especialidad,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                color: colores.onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${viewModel.mecanicos[i].abiertas} abiertas',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: colores.primary,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: LinearProgressIndicator(
                                  value:
                                      viewModel.mecanicos[i].abiertas /
                                      maxCarga,
                                  minHeight: 5,
                                  backgroundColor:
                                      colores.surfaceContainerHighest,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${viewModel.mecanicos[i].entregadas} entregadas en el período',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        fontSize: 9,
                                        color: colores.onSurfaceVariant,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SeccionTitulo(
                titulo: 'Deudas de clientes',
                subtitulo: '${viewModel.deudas.length} clientes con saldo',
              ),
              const SizedBox(height: 9),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: viewModel.deudas.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'No hay deudas pendientes.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colores.onSurfaceVariant),
                          ),
                        )
                      : Column(
                          children: [
                            for (
                              var i = 0;
                              i < viewModel.deudas.length;
                              i++
                            ) ...[
                              if (i > 0) const Divider(),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                onTap: () => context.push(
                                  '/cliente/${viewModel.deudas[i].cliente.id}',
                                ),
                                leading: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: colores.errorContainer
                                      .withAlpha(100),
                                  foregroundColor: colores.onErrorContainer,
                                  child: Text(
                                    iniciales(
                                      viewModel.deudas[i].cliente.nombre,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  viewModel.deudas[i].cliente.nombre,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                trailing: Text(
                                  dinero(viewModel.deudas[i].saldo),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: colores.error,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ],
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),
              SeccionTitulo(
                titulo: 'Repuestos con stock bajo',
                subtitulo: '${viewModel.bajos.length} requieren reposición',
                accion: TextButton(
                  onPressed: () => context.go('/inventario'),
                  child: const Text('Ver inventario'),
                ),
              ),
              const SizedBox(height: 9),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: viewModel.bajos.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'Todo el inventario está por encima del mínimo.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colores.onSurfaceVariant),
                          ),
                        )
                      : Column(
                          children: [
                            for (
                              var i = 0;
                              i < viewModel.bajos.length;
                              i++
                            ) ...[
                              if (i > 0) const Divider(),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                leading: Icon(
                                  Icons.warning_amber_rounded,
                                  color: colores.error,
                                  size: 20,
                                ),
                                title: Text(
                                  viewModel.bajos[i].nombre,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  viewModel.bajos[i].codigo,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                trailing: Text(
                                  '${viewModel.bajos[i].existencias} / '
                                  '${viewModel.bajos[i].stockMinimo}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: colores.error,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ],
                          ],
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
