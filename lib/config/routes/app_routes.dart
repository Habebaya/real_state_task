import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nawy_real_state/config/routes/routes_transitions.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_filter/property_search_model.dart';
import 'package:nawy_real_state/feature/favorite/screen/favorite_screen.dart';

import '../../core/constant/nav_bar.dart';
import '../../feature/explore/presentation/screen/explore_screen.dart';
import '../../feature/explore/presentation/screen/search_result_screen.dart';
import '../../feature/update/presentation/screen/update_screen.dart';
import 'const/route_paths.dart';

class AppRoutes {
  AppRoutes._();

  static final AppRoutes _instance = AppRoutes._();

  factory AppRoutes() => _instance;

  List<RouteBase> routes = [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavScaffold(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.exploreScreen,
              pageBuilder: (context, state) =>
                  RouteTransitions.fade(context, state, SearchPage()),
            ),
            GoRoute(
              path: RoutePaths.searchResultScreen,
              pageBuilder: (context, state) => RouteTransitions.fade(
                context,
                state,
                SearchResultScreen(
                  key: state.pageKey,
                  propertySearchModel: state.extra as PropertySearchModel,
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.updateScreen,
              pageBuilder: (context, state) =>
                  RouteTransitions.fade(context, state, UpdatesScreen()),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.favoriteScreen,
              pageBuilder: (context, state) => RouteTransitions.fade(
                context,
                state,
                FavoriteScreen(key: state.pageKey),
              ),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.moreScreen,
              pageBuilder: (context, state) =>
                  RouteTransitions.fade(context, state, Scaffold()),
              routes: [],
            ),
          ],
        ),
      ],
    ),
  ];
}
