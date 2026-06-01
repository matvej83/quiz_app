import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/app/router/app_routes.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_entity.dart';
import 'package:quiz_app/features/translation/presentation/translation_cubit/cubit.dart';

import '../../../../core/presentation/widgets/app_back_button.dart';
import '../translation_catalog_cubit/cubit.dart';
import '../translation_catalog_cubit/state.dart';

class TranslationsCatalogPage extends StatelessWidget {
  const TranslationsCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textCatalogPage.screenName'.tr()),
        leading: const AppBackButton(),
      ),
      body: BlocBuilder<TranslationCatalogCubit, TranslationCatalogState>(
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.translations.length,
            physics: const ClampingScrollPhysics(),
            padding: const .symmetric(horizontal: 16.0),
            itemBuilder: (context, index) {
              final item = state.translations[index];
              return GestureDetector(
                onTap: () {
                  context.read<TranslationCubit>().loadRussianText(item.text);
                  context.push(AppRoutes.translation);
                },
                child: TranslationItem(item: item),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          );
        },
      ),
    );
  }
}

class TranslationItem extends StatelessWidget {
  const TranslationItem({super.key, required this.item});

  final TranslationEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const .all(16.0),
        child: Column(
          spacing: 32.0,
          children: [
            Text(item.title, style: theme.textTheme.bodyLarge),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  '${'textCatalogPage.level'.tr()}: ${item.level}',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  'textCatalogPage.phrases'.plural(item.text.length),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
