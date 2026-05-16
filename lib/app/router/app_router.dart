import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/router/app_routes.dart';
import 'package:quiz_app/features/main/presentation/pages/tests_page.dart';
import 'package:quiz_app/features/quiz/presentation/pages/quiz_page.dart';

import '../../core/presentation/pages/splash_page.dart';
import '../../features/main/presentation/main_screen.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@lazySingleton
class AppRouter {
  AppRouter();

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // TODO(): will be added in profile feature
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell, state: state);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.tests,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: TestsPage()),
                routes: [
                  GoRoute(
                    path: AppRoutes.translate,
                    builder: (context, state) => const QuizPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfilePage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
