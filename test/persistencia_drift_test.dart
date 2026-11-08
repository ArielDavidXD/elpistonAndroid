import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piston/data/base_datos.dart';
import 'package:piston/data/repositorio_drift.dart';
import 'package:piston/router/app_state.dart';

void main() {
  test('Drift guarda y recupera la operación completa del taller', () async {
    final baseDatos = BaseDatosTaller.conEjecutor(NativeDatabase.memory());
    final repositorio = RepositorioDrift(baseDatos: baseDatos);

    final estado = AppState(repositorio: repositorio);
    await estado.cargar();

    expect(estado.cargado, isTrue);
    expect(estado.clientes, hasLength(6));
    expect(estado.ordenes, hasLength(8));

    // Modifica datos de varias tablas relacionadas: stock, repuesto usado y pago.
    expect(estado.agregarRepuesto('o4', 'r1', 1), isNull);
    expect(estado.registrarPago('o2', 1000, 'Efectivo'), isNull);
    await estado.persistir();

    final recargado = AppState(repositorio: repositorio);
    await recargado.cargar();

    final orden4 = recargado.ordenPorId('o4');
    final orden2 = recargado.ordenPorId('o2');
    expect(orden4, isNotNull);
    expect(orden4!.repuestos.map((item) => item.idRepuesto), contains('r1'));
    expect(recargado.repuestoPorId('r1')!.existencias, 11);
    expect(orden2, isNotNull);
    expect(orden2!.pagado, 101000);
    expect(recargado.saldoTotal, closeTo(109800, 0.01));

    await baseDatos.close();
  });

  test('Drift aplica la integridad referencial configurada', () async {
    final baseDatos = BaseDatosTaller.conEjecutor(NativeDatabase.memory());
    final repositorio = RepositorioDrift(baseDatos: baseDatos);
    final estado = AppState(repositorio: repositorio);
    await estado.cargar();

    await expectLater(
      baseDatos
          .into(baseDatos.vehiculos)
          .insert(
            VehiculosCompanion.insert(
              id: 'v-invalido',
              idCliente: 'cliente-inexistente',
              matricula: 'ZZ999ZZ',
              marca: 'Marca',
              modelo: 'Modelo',
              anio: 2020,
              kilometraje: 0,
              actualizadoEn: DateTime.now(),
            ),
          ),
      throwsA(anything),
    );

    await baseDatos.close();
  });
}
