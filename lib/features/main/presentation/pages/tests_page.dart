import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/app/constants/asset_paths.dart';
import 'package:quiz_app/app/router/app_routes.dart';
import 'package:quiz_app/enums/app_enums.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/quiz_cubit.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium;
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .stretch,
        spacing: 16.0,
        children: [
          OutlinedButton(
            onPressed: () {
              context.read<QuizCubit>().loadWords(type: TranslationType.enRu);
              context.go('${AppRoutes.tests}/${AppRoutes.translate}');
            },
            child: Row(
              mainAxisSize: .min,
              spacing: 4.0,
              children: [
                Text('Перевод слов', style: textStyle),
                SvgPicture.asset(AssetPaths.flagUs, height: 20.0),
                SvgPicture.asset(AssetPaths.flagRu, height: 20.0),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              context.read<QuizCubit>().loadWords(type: TranslationType.ruEn);
              context.go('${AppRoutes.tests}/${AppRoutes.translate}');
            },
            child: Row(
              mainAxisSize: .min,
              spacing: 4.0,
              children: [
                Text('Перевод слов', style: textStyle),
                SvgPicture.asset(AssetPaths.flagRu, height: 20.0),
                SvgPicture.asset(AssetPaths.flagUs, height: 20.0),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              context.read<QuizCubit>().loadWords(type: TranslationType.enRu);
              context.go('${AppRoutes.tests}/${AppRoutes.flashcards}');
            },
            child: Row(
              mainAxisSize: .min,
              spacing: 4.0,
              children: [
                Text('Карточки', style: textStyle),
                SvgPicture.asset(AssetPaths.flagUs, height: 20.0),
                SvgPicture.asset(AssetPaths.flagRu, height: 20.0),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              context.read<QuizCubit>().loadWords(type: TranslationType.ruEn);
              context.go('${AppRoutes.tests}/${AppRoutes.flashcards}');
            },
            child: Row(
              mainAxisSize: .min,
              spacing: 4.0,
              children: [
                Text('Карточки', style: textStyle),
                SvgPicture.asset(AssetPaths.flagRu, height: 20.0),
                SvgPicture.asset(AssetPaths.flagUs, height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
