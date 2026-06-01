import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/router/app_routes.dart';
import 'package:quiz_app/features/history/presentation/pages/history_page.dart';
import 'package:quiz_app/features/main/presentation/pages/tests_page.dart';
import 'package:quiz_app/features/profile/presentation/cubit/cubit.dart';
import 'package:quiz_app/features/profile/presentation/pages/create_profile_page.dart';
import 'package:quiz_app/features/quiz/presentation/pages/quiz_page.dart';
import 'package:quiz_app/features/quiz/presentation/pages/test_page.dart';
import 'package:quiz_app/features/text_catalog/presentation/pages/text_catalog_page.dart';
import 'package:quiz_app/features/translation/presentation/pages/translation_page.dart';

import '../../core/presentation/pages/splash_page.dart';
import '../../features/main/presentation/main_screen.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/quiz/presentation/pages/flashcards_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@lazySingleton
class AppRouter {
  AppRouter(this.cubit);

  final ProfileCubit cubit;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(cubit.stream),
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final initialized = cubit.state.initialized;
      final hasProfile =
          cubit.state.profile != null &&
          cubit.state.profile!.firstName.isNotEmpty;

      final isSplash = state.matchedLocation == AppRoutes.splash;

      final isCreateProfile = state.matchedLocation == AppRoutes.createProfile;

      // loading
      if (!initialized) {
        return isSplash ? null : AppRoutes.splash;
      }

      // no profile
      if (!hasProfile) {
        return isCreateProfile ? null : AppRoutes.createProfile;
      }

      // has profile
      if (isSplash || isCreateProfile) {
        return AppRoutes.tests;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.createProfile,
        builder: (context, state) => const CreateProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, state) => const HistoryPage(),
      ),
      GoRoute(
        path: AppRoutes.translation,
        builder: (context, state) => const TranslationPage(),
      ),
      GoRoute(
        path: AppRoutes.catalog,
        builder: (context, state) => const TextCatalogPage(),
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
                  GoRoute(
                    path: AppRoutes.flashcards,
                    builder: (context, state) => const FlashcardsPage(),
                  ),
                  GoRoute(
                    path: AppRoutes.test,
                    builder: (context, state) => const TestPage(),
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

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
