import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/profile/domain/entity/profile_entity.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.profile,
    this.error,
    this.isLoading = false,
    this.success = false,
    this.initialized = false,
  });

  final ProfileEntity? profile;
  final String? error;
  final bool isLoading;
  final bool success;
  final bool initialized;

  ProfileState copyWith({
    ProfileEntity? profile,
    String? error,
    bool? isLoading,
    bool? success,
    bool? initialized,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      initialized: initialized ?? this.initialized,
    );
  }

  @override
  List<dynamic> get props => [profile, error, isLoading, success, initialized];
}
