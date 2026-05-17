import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/app_dialog.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widgets/theme_selector.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileCubit cubit;
  final _showSelector = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfileCubit>();
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
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                ),
                onPressed: () async {
                  final result = await AppDialog.show(
                    context,
                    title: 'Удаление профиля',
                    text:
                        'Вы действительно хотите удалить профиль? Это действие необратимо',
                    cancelText: 'Отмена',
                    okText: 'ОК',
                  );
                  if (result) {
                    cubit.deleteProfile();
                  }
                },
                child: const Text('Удалить профиль'),
              ),
            ],
          ),
        );
      },
    );
  }
}
