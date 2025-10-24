import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import 'const/route_paths.dart';

class RouteService {
  RouteService._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePaths.splash,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: false,
    routes: AppRoutes().routes,

    observers: [],
    redirect: _handleRedirect,
  );

  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    return RoutePaths.updateScreen;
  }
}
