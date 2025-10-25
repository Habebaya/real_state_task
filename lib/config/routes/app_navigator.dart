import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum NavigateType { pushNamed, goNamed, pushReplacementNamed }

class AppNavigator {
  AppNavigator._();

  static void navigateToScreen(
    String screenName,
    NavigateType navigateType,
    BuildContext context, {
    Map<String, String>? queryParameters,
    Object? extra,
    VoidCallback? afterComplete,
  }) {
    if (screenName.isEmpty) return;

    final goRouter = GoRouter.of(context);

    final params = queryParameters ?? {};

    Future<void> future;

    switch (navigateType) {
      case NavigateType.pushNamed:
        future = goRouter.push(screenName, extra: extra);
        break;

      case NavigateType.goNamed:
        goRouter.goNamed(screenName, queryParameters: params, extra: extra);
        return;

      case NavigateType.pushReplacementNamed:
        future = goRouter.pushReplacement(screenName, extra: extra);
        break;
    }

    future.whenComplete(() => afterComplete?.call());
  }

  static void navigateToFirstScreen(BuildContext context) {
    while (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }
}
