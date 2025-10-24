import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteTransitions {
  RouteTransitions._();

  static CustomTransitionPage<T> slideFromTop<T>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return _buildTransition(
      state: state,
      duration: const Duration(milliseconds: 500),
      transition: (animation, child) => SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: child,
      ),
      child: child,
    );
  }

  static CustomTransitionPage<T> fade<T>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return _buildTransition(
      state: state,
      duration: const Duration(milliseconds: 800),
      transition: (animation, child) => FadeTransition(
        opacity: CurveTween(curve: Curves.linear).animate(animation),
        child: child,
      ),
      child: child,
    );
  }

  static CustomTransitionPage<T> _buildTransition<T>({
    required GoRouterState state,
    required Duration duration,
    required Widget child,
    required Widget Function(Animation<double> animation, Widget child)
    transition,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      transitionDuration: duration,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return transition(animation, child);
      },
    );
  }
}
