import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_check_result_entity.dart';

part 'state.freezed.dart';

enum TranslationStatus { initial, loading, loaded, error, answered, completed }

@freezed
abstract class TranslationState with _$TranslationState {
  const factory TranslationState({
    @Default(TranslationStatus.initial) TranslationStatus status,
    TranslationCheckResultEntity? result,
    @Default([]) List<String> russianText,
    @Default(0) int currentIndex,
    @Default(0) int totalScore,
    String? error,
  }) = _TranslationState;
}
