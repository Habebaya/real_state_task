import 'package:go_router/go_router.dart';
import 'package:nawy_real_state/config/routes/routes_transitions.dart';

import '../../core/constant/nav_bar.dart';
import '../../feature/home/home_screen.dart';
import 'const/route_paths.dart';

class AppRoutes {
  AppRoutes._();

  static final AppRoutes _instance = AppRoutes._();

  factory AppRoutes() => _instance;

  List<RouteBase> routes = [
    /// Shell with an IndexedStack to preserve each tab's state
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavScaffold(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.homeScreen,
              pageBuilder: (context, state) =>
                  RouteTransitions.fade(context, state, HomeScreen()),
              routes: [],
            ),
            GoRoute(
              path: RoutePaths.searchScreen,
              pageBuilder: (context, state) =>
                  RouteTransitions.fade(context, state, HomeScreen()),
              routes: [],
            ),
          ],
        ),
      ],
    ),
  ];
}
