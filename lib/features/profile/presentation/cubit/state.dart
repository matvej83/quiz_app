import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/features/profile/domain/entity/profile_entity.dart';

part 'state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    ProfileEntity? profile,
    String? error,
    @Default(false) bool isLoading,
    @Default(false) bool success,
  }) = _ProfileState;
}
