import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/app/router/app_routes.dart';

class MainScreenUtils {
  static String getAppBarTitle(BuildContext context) {
    final location = GoRouterState.of(context).uri;
    if (location.pathSegments.length == 2) {
      if (location.pathSegments.last == AppRoutes.translate) {
        return 'Перевод';
      }
    }
    return switch (location.toString()) {
      AppRoutes.tests => 'Тесты',
      AppRoutes.profile => 'Профиль',
      _ => '',
    };
  }

  static bool showBackButton(BuildContext context) {
    final uri = GoRouterState.of(context).uri;
    return uri.pathSegments.length > 1;
  }
}
