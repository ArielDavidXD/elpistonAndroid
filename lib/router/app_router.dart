import 'package:go_router/go_router.dart';

import '../router/app_state.dart';
import '../views/cliente_detalle_screen.dart';
import '../views/clientes_screen.dart';
import '../views/inventario_screen.dart';
import '../views/nueva_orden_screen.dart';
import '../views/orden_detalle_screen.dart';
import '../views/ordenes_screen.dart';
import '../views/panel_screen.dart';
import '../views/reportes_screen.dart';
import '../views/vehiculo_detalle_screen.dart';
import '../widgets/main_shell.dart';

GoRouter crearRouter(AppState appState) {
  return GoRouter(
    initialLocation: '/panel',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/panel',
                builder: (context, state) => PanelScreen(appState: appState),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/ordenes',
                builder: (context, state) => OrdenesScreen(appState: appState),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/clientes',
                builder: (context, state) => ClientesScreen(appState: appState),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/inventario',
                builder: (context, state) =>
                    InventarioScreen(appState: appState),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reportes',
                builder: (context, state) => ReportesScreen(appState: appState),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/nueva-orden',
        builder: (context, state) => NuevaOrdenScreen(appState: appState),
      ),
      GoRoute(
        path: '/orden/:id',
        builder: (context, state) => OrdenDetalleScreen(
          appState: appState,
          idOrden: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/cliente/:id',
        builder: (context, state) => ClienteDetalleScreen(
          appState: appState,
          idCliente: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/vehiculo/:id',
        builder: (context, state) => VehiculoDetalleScreen(
          appState: appState,
          idVehiculo: state.pathParameters['id']!,
        ),
      ),
    ],
  );
}
