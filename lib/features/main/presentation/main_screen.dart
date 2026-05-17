import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/features/main/presentation/widgets/bottom_nav_bar.dart';

import '../../../app/di/injection.dart';
import '../../quiz/presentation/bloc/quiz_cubit.dart';
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
      create: (_) => getIt<QuizCubit>()..loadWords(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(MainScreenUtils.getAppBarTitle(context)),
          centerTitle: true,
          leading: MainScreenUtils.showBackButton(context)
              ? BackButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                )
              : null,
        ),
        body: SafeArea(
          left: true,
          right: true,
          minimum: const EdgeInsets.only(left: 10, right: 10),
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
