import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'data/repositorio_drift.dart';
import 'router/app_router.dart';
import 'router/app_state.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = AppState(repositorio: RepositorioDrift());
  await appState.cargar();
  runApp(TallerApp(appState: appState, themeController: AppThemeController()));
}

class TallerApp extends StatefulWidget {
  const TallerApp({
    required this.appState,
    required this.themeController,
    super.key,
  });

  final AppState appState;
  final AppThemeController themeController;

  @override
  State<TallerApp> createState() => _TallerAppState();
}

class _TallerAppState extends State<TallerApp> {
  late final GoRouter _router = crearRouter(widget.appState);

  @override
  Widget build(BuildContext context) {
    return TemaScope(
      controller: widget.themeController,
      child: ListenableBuilder(
        listenable: widget.themeController,
        builder: (context, _) => MaterialApp.router(
          title: 'El Pistón',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.claro,
          darkTheme: AppTheme.oscuro,
          themeMode: widget.themeController.tema,
          routerConfig: _router,
          locale: const Locale('es', 'AR'),
          supportedLocales: const [Locale('es', 'AR'), Locale('es')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
