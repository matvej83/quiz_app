import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/core/presentation/widgets/app_loader.dart';
import 'package:quiz_app/features/profile/domain/entity/profile_entity.dart';
import 'package:quiz_app/features/profile/presentation/cubit/cubit.dart';
import 'package:quiz_app/features/profile/presentation/cubit/state.dart';

import '../../../../core/presentation/widgets/app_message.dart';
import '../../../../core/presentation/widgets/app_text_form_field.dart';
import '../../../../core/presentation/widgets/one_value_slider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late ProfileCubit cubit;
  late ProfileEntity profile;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  int _wordCount = 10;

  void _onSave() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final updatedProfile = profile.copyWith(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      wordCount: _wordCount,
    );

    if (updatedProfile == cubit.state.profile) {
      return;
    }

    cubit.updateProfile(profile: updatedProfile);
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfileCubit>();
    profile = cubit.state.profile!;
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _wordCount = profile.wordCount;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final isLoading = state.isLoading;
          return Center(
            child: SingleChildScrollView(
              padding: .only(
                top: 24.0,
                left: 24.0,
                right: 24.0,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .stretch,
                  spacing: 16.0,
                  children: [
                    AppTextFormField(
                      controller: _firstNameController,
                      enabled: !isLoading,
                      keyboardType: .name,
                      hintText: 'createProfilePage.fieldFirstName'.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'fieldValidation.fieldIsRequired'.tr();
                        }
                        return null;
                      },
                    ),
                    AppTextFormField(
                      controller: _lastNameController,
                      enabled: !isLoading,
                      keyboardType: .name,
                      hintText: 'createProfilePage.fieldLastName'.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'fieldValidation.fieldIsRequired'.tr();
                        }
                        return null;
                      },
                    ),
                    Column(
                      crossAxisAlignment: .start,
                      spacing: 8.0,
                      children: [
                        Text('${'createProfilePage.wordCount'.tr()}:'),
                        OneValueSlider(
                          initValue: profile.wordCount,
                          onChanged: (value) {
                            _wordCount = value;
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: state.isLoading ? null : _onSave,
                      child: state.isLoading
                          ? AppLoader.small()
                          : Text('editProfilePage.btnSave'.tr()),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.error?.isNotEmpty == true) {
            AppMessage.error(
              context,
              message: state.error!,
              onClose: () {
                cubit.disableError();
              },
            );
          }
          if (state.success) {
            AppMessage.success(
              context,
              message: 'editProfilePage.updated'.tr(),
              onClose: () {
                cubit.disableSuccess();
                context.pop();
              },
            );
          }
        },
      ),
    );
  }
}
