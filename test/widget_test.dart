import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piston/data/repositorio_memoria.dart';
import 'package:piston/main.dart';
import 'package:piston/router/app_state.dart';
import 'package:piston/theme/app_theme.dart';

void main() {
  testWidgets('navega por las cinco secciones principales', (tester) async {
    tester.view.physicalSize = const Size(430, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final estado = AppState(repositorio: RepositorioMemoria());
    await estado.cargar();
    final tema = AppThemeController();

    await tester.pumpWidget(TallerApp(appState: estado, themeController: tema));
    await tester.pumpAndSettle();

    expect(find.text('El Pistón'), findsOneWidget);
    expect(find.text('Órdenes en curso'), findsOneWidget);

    await tester.tap(find.text('Órdenes'));
    await tester.pumpAndSettle();
    expect(find.text('Nueva'), findsOneWidget);
    expect(find.text('OS 0006'), findsWidgets);

    await tester.tap(find.text('Clientes'));
    await tester.pumpAndSettle();
    expect(find.text('María Fernández'), findsOneWidget);
    expect(find.text('6 clientes'), findsOneWidget);

    await tester.tap(find.text('Inventario'));
    await tester.pumpAndSettle();
    expect(find.text('Repuestos'), findsOneWidget);
    expect(find.text('Stock bajo · 3'), findsOneWidget);

    await tester.tap(find.text('Reportes'));
    await tester.pumpAndSettle();
    expect(find.text('Facturado'), findsOneWidget);
    expect(find.text('\$230.800'), findsOneWidget);
    expect(find.text('Órdenes abiertas por estado'), findsOneWidget);

    await tester.tap(find.text('Panel'));
    await tester.pumpAndSettle();
    expect(find.text('Stock bajo'), findsOneWidget);
  });
}
