import 'package:flutter/material.dart';
import 'package:scouting_app/core/navigation/navigation_service.dart';
import 'package:scouting_app/di/service_locator.dart';

/// Class to make navigation calling shorter and faster to use
class Nav {
  /// Push
  static Future<T?> to<T extends Object?>(
    String routeName, {
    required Object arguments,
    BuildContext? context,
  }) {
    // return getIt<NavigationRoute>().router.push(
    //       routeName,
    //       extra: arguments,
    //     );
    return Navigator.pushNamed(
      context ?? getIt<NavigationService>().appContext!,
      routeName,
      arguments: arguments,
    );
  }

  /// Push replacement
  static Future<T?> off<T extends Object?, TO extends Object?>(
    String routeName, {
    required Object arguments,
    BuildContext? context,
    TO? result,
  }) {
    return Navigator.pushReplacementNamed(
      context ?? getIt<NavigationService>().appContext!,
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  /// Pop
  static void pop<T extends Object?>([BuildContext? context, T? result]) {
    // if (getIt<NavigationRoute>().router.canPop()) {
    //   return getIt<NavigationRoute>().router.pop(result);
    // }
    if (Navigator.canPop(context ?? getIt<NavigationService>().appContext!)) {
      Navigator.pop(context ?? getIt<NavigationService>().appContext!, result);
    } else {
      throw Exception("Can't go back to the previous screen");
    }
  }

  /// Pop until
  static void popTo(bool Function(Route<dynamic>) predicate,
      {BuildContext? context}) {
    // while (getIt<NavigationRoute>().router.canPop() &&
    //     getIt<NavigationRoute>()
    //             .router
    //             .routeInformationProvider
    //             .value
    //             .location !=
    //         routeName) {
    //   getIt<NavigationRoute>().router.pop();
    // }
    Navigator.popUntil(
        context ?? getIt<NavigationService>().appContext!, predicate);
  }
}
