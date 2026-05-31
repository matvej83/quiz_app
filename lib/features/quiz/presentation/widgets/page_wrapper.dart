import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/presentation/widgets/app_loader.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({
    super.key,
    required this.backgroundColor,
    required this.onCompleted,
    required this.onLoaded,
  });

  final Color backgroundColor;
  final Widget Function(QuizCompleted) onCompleted;
  final Widget Function(QuizLoaded) onLoaded;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const AppLoader();
          }
          if (state is QuizCompleted) {
            return onCompleted(state);
          }
          if (state is QuizLoaded) {
            return onLoaded(state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
