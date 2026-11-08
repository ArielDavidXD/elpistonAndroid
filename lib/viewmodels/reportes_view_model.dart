import 'package:flutter/foundation.dart';

import '../models/cliente.dart';
import '../models/orden_servicio.dart';
import '../models/repuesto.dart';
import '../router/app_state.dart';
import '../utils/formato.dart';

enum PeriodoReporte { ultimos30, ultimos60, ultimos90, esteMes, personalizado }

extension PeriodoReporteUi on PeriodoReporte {
  String get etiqueta {
    switch (this) {
      case PeriodoReporte.ultimos30:
        return '30 días';
      case PeriodoReporte.ultimos60:
        return '60 días';
      case PeriodoReporte.ultimos90:
        return '90 días';
      case PeriodoReporte.esteMes:
        return 'Este mes';
      case PeriodoReporte.personalizado:
        return 'Personalizado';
    }
  }
}

class ReportesViewModel extends ChangeNotifier {
  ReportesViewModel({required this.appState}) {
    appState.addListener(_alCambiar);
    _aplicarPeriodo(PeriodoReporte.ultimos60);
  }

  final AppState appState;

  PeriodoReporte _periodo = PeriodoReporte.ultimos60;
  late DateTime _desde;
  late DateTime _hasta;

  PeriodoReporte get periodo => _periodo;
  DateTime get desde => _desde;
  DateTime get hasta =>
      DateTime(_hasta.year, _hasta.month, _hasta.day, 23, 59, 59);

  String get etiquetaRango => '${fechaCorta(_desde)} al ${fechaCorta(_hasta)}';

  List<OrdenServicio> get entregadas =>
      appState.entregadasEntre(_desde, _hasta.add(const Duration(days: 1)));
  double get facturado =>
      appState.facturadoEntre(_desde, _hasta.add(const Duration(days: 1)));
  double get cobrado =>
      appState.cobradoEntre(_desde, _hasta.add(const Duration(days: 1)));
  double get saldo => appState.saldoTotal;
  double get promedio => entregadas.isEmpty
      ? 0
      : entregadas.fold(0.0, (total, item) => total + item.total) /
            entregadas.length;

  Map<EstadoOrden, int> get abiertasPorEstado {
    final mapa = <EstadoOrden, int>{};
    for (final orden in appState.ordenesAbiertas) {
      mapa[orden.estado] = (mapa[orden.estado] ?? 0) + 1;
    }
    return mapa;
  }

  List<({String nombre, String especialidad, int abiertas, int entregadas})>
  get mecanicos {
    final resultado =
        <
          ({String nombre, String especialidad, int abiertas, int entregadas})
        >[];
    for (final mecanico in appState.mecanicos) {
      resultado.add((
        nombre: mecanico.nombre,
        especialidad: mecanico.especialidad,
        abiertas: appState.cargaDeMecanico(mecanico.id),
        entregadas: entregadas
            .where((orden) => orden.idMecanico == mecanico.id)
            .length,
      ));
    }
    resultado.sort((a, b) => b.abiertas.compareTo(a.abiertas));
    return resultado;
  }

  List<({Cliente cliente, double saldo})> get deudas => [
    for (final cliente in appState.clientesConDeuda)
      (cliente: cliente, saldo: appState.saldoDeCliente(cliente.id)),
  ];

  List<Repuesto> get bajos => appState.repuestosBajos;

  void cambiarPeriodo(PeriodoReporte periodo) {
    if (periodo == PeriodoReporte.personalizado) {
      _periodo = periodo;
      notifyListeners();
      return;
    }
    _aplicarPeriodo(periodo);
  }

  void establecerPersonalizado(DateTime desde, DateTime hasta) {
    var inicio = DateTime(desde.year, desde.month, desde.day);
    var fin = DateTime(hasta.year, hasta.month, hasta.day);
    if (fin.isBefore(inicio)) {
      final temporal = inicio;
      inicio = fin;
      fin = temporal;
    }
    _periodo = PeriodoReporte.personalizado;
    _desde = inicio;
    _hasta = fin;
    notifyListeners();
  }

  void _aplicarPeriodo(PeriodoReporte periodo) {
    final ahora = DateTime.now();
    final hoy = DateTime(ahora.year, ahora.month, ahora.day);
    _periodo = periodo;
    switch (periodo) {
      case PeriodoReporte.ultimos30:
        _hasta = hoy;
        _desde = hoy.subtract(const Duration(days: 29));
      case PeriodoReporte.ultimos60:
        _hasta = hoy;
        _desde = hoy.subtract(const Duration(days: 59));
      case PeriodoReporte.ultimos90:
        _hasta = hoy;
        _desde = hoy.subtract(const Duration(days: 89));
      case PeriodoReporte.esteMes:
        _hasta = hoy;
        _desde = DateTime(hoy.year, hoy.month, 1);
      case PeriodoReporte.personalizado:
        break;
    }
    notifyListeners();
  }

  void _alCambiar() => notifyListeners();

  @override
  void dispose() {
    appState.removeListener(_alCambiar);
    super.dispose();
  }
}
