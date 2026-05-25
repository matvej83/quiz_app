import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/app/router/app_routes.dart';

import '../../../../core/presentation/widgets/app_dialog.dart';
import '../../../history/presentation/cubit/cubit.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widgets/theme_selector.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late HistoryCubit historyCubit;
  late ProfileCubit cubit;
  final _showSelector = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfileCubit>();
    historyCubit = context.read<HistoryCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _showSelector.value = true;
      }
    });
  }

  @override
  void dispose() {
    _showSelector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return ColoredBox(
          color: theme.scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: .center,
            spacing: 16.0,
            children: [
              Text(
                state.profile?.firstName ?? '',
                style: theme.textTheme.headlineSmall,
              ),
              Text(
                state.profile?.lastName ?? '',
                style: theme.textTheme.headlineSmall,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _showSelector,
                builder: (context, visible, child) {
                  return visible
                      ? const ThemeSelector()
                      : const SizedBox(height: 56.0);
                },
              ),
              OutlinedButton(
                onPressed: () {
                  context.push(AppRoutes.history);
                },
                child: Text('historyPage.screenName'.tr()),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                ),
                onPressed: () async {
                  final result = await AppDialog.show(
                    context,
                    title: 'profilePage.btnRemove'.tr(),
                    text: 'profilePage.youWantRemove'.tr(),
                    cancelText: 'cancelText'.tr(),
                    okText: 'okText'.tr(),
                  );
                  if (result) {
                    historyCubit.deleteHistory();
                    cubit.deleteProfile();
                  }
                },
                child: Text('profilePage.btnRemoveProfile'.tr()),
              ),
            ],
          ),
        );
      },
    );
  }
}
