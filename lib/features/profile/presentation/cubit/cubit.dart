import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/utils/app_utils.dart';
import 'package:quiz_app/core/usecases/usecase.dart';
import 'package:quiz_app/features/profile/domain/entity/profile_entity.dart';
import 'package:quiz_app/features/profile/domain/usecases/delete_profile_usecase.dart';
import 'package:quiz_app/features/profile/domain/usecases/fetch_profile_usecase.dart';
import 'package:quiz_app/features/profile/domain/usecases/save_profile_usecase.dart';
import 'package:quiz_app/features/profile/presentation/cubit/state.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._fetchProfileUseCase,
    this._saveProfileUseCase,
    this._deleteProfileUseCase,
  ) : super(const ProfileState());
  final FetchProfileUseCase _fetchProfileUseCase;
  final SaveProfileUseCase _saveProfileUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true));
    final mode = await _fetchProfileUseCase(NoParams());
    mode.fold(
      (l) {
        emit(
          state.copyWith(
            error: AppUtils.parseFailureMessage(l),
            isLoading: false,
            initialized: true,
          ),
        );
      },
      (r) {
        emit(state.copyWith(profile: r, isLoading: false, initialized: true));
      },
    );
  }

  Future<void> createProfile({
    required String firstName,
    required String lastName,
  }) async {
    emit(state.copyWith(isLoading: true));
    final profile = ProfileEntity(firstName: firstName, lastName: lastName);
    await _saveProfileUseCase(ProfileParams(profile: profile));
    emit(state.copyWith(profile: profile, isLoading: false, success: true));
  }

  Future<void> deleteProfile() async {
    await _deleteProfileUseCase(NoParams());
    emit(
      state.copyWith(
        profile: const ProfileEntity(firstName: '', lastName: ''),
      ),
    );
  }

  Future<void> disableError() async {
    emit(state.copyWith(error: ''));
  }

  Future<void> disableSuccess() async {
    emit(state.copyWith(success: false));
  }
}
