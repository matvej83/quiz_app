import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/presentation/widgets/app_loader.dart';
import 'package:quiz_app/features/auth/presentation/cubit/cubit.dart';
import 'package:quiz_app/features/profile/presentation/cubit/cubit.dart';
import 'package:quiz_app/features/profile/presentation/cubit/state.dart';

import '../../../../core/presentation/widgets/app_message.dart';
import '../../../../core/presentation/widgets/app_text_form_field.dart';
import '../../../../core/presentation/widgets/one_value_slider.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  late ProfileCubit cubit;
  late AuthCubit authCubit;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  int _wordCount = 10;
  bool created = false;

  void _handleCreateProfile() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileCubit>().createProfile(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        wordCount: _wordCount,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfileCubit>();
    authCubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('createProfilePage.screenName'.tr()),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final isLoading = state.isLoading;
          final isBlocked = created;
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
                      children: [
                        Text('createProfilePage.wordCount'.tr()),
                        OneValueSlider(
                          onChanged: (value) {
                            _wordCount = value;
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: isLoading || isBlocked
                          ? null
                          : _handleCreateProfile,
                      child: isLoading
                          ? AppLoader.small()
                          : Text('createProfilePage.btnCreate'.tr()),
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
            created = true;
            _firstNameController.text = '';
            _lastNameController.text = '';
            AppMessage.success(
              context,
              message: 'profilePage.created'.tr(),
              onClose: () {
                cubit.disableSuccess();
                authCubit.checkAuth();
              },
            );
          }
        },
      ),
    );
  }
}
