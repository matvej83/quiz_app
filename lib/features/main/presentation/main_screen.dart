import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/core/presentation/widgets/app_back_button.dart';
import 'package:quiz_app/features/main/presentation/widgets/bottom_nav_bar.dart';

import '../../../app/di/injection.dart';
import '../../quiz/presentation/cubit/cubit.dart';
import '../utils.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.navigationShell,
    required this.state,
  });

  final StatefulNavigationShell navigationShell;
  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<QuizCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(MainScreenUtils.getAppBarTitle(context)),
          centerTitle: true,
          leading: MainScreenUtils.showBackButton(context)
              ? const AppBackButton()
              : null,
        ),
        body: SafeArea(
          left: true,
          right: true,
          minimum: const .only(left: 16.0, right: 16.0),
          child: navigationShell,
        ),
        bottomNavigationBar: BottomNavBar(
          currentPage: navigationShell.currentIndex,
          onItemTap: (index) {
            navigationShell.goBranch(index);
          },
        ),
      ),
    );
  }
}
