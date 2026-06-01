import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/app/router/app_routes.dart';

import '../../../../app/constants/asset_paths.dart';
import '../../../../core/presentation/widgets/app_back_button.dart';
import '../../../translation/presentation/cubit/cubit.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widgets/catalog_item.dart';

class TextCatalogPage extends StatelessWidget {
  const TextCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textCatalogPage.screenName'.tr()),
        leading: const AppBackButton(),
      ),
      body: BlocBuilder<TextCatalogCubit, TextCatalogState>(
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.translations.length,
            physics: const ClampingScrollPhysics(),
            padding: const .all(16.0),
            itemBuilder: (context, index) {
              final item = state.translations[index];
              return GestureDetector(
                onTap: () {
                  context.read<TranslationCubit>().loadRussianText(item.text);
                  context.push(AppRoutes.translation);
                },
                child: CatalogItem(
                  image: '${AssetPaths.coversPath}${item.id}.png',
                  title: item.title,
                  level: item.level,
                  phraseCount: item.text.length,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
          );
        },
      ),
    );
  }
}
