import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_check_result_entity.dart';

import 'mistake_model.dart';

part 'translation_check_result_model.freezed.dart';
part 'translation_check_result_model.g.dart';

@freezed
abstract class TranslationCheckResultModel with _$TranslationCheckResultModel {
  const factory TranslationCheckResultModel({
    required String correctTranslation,
    required int score,
    required List<MistakeModel> mistakes,
  }) = _TranslationCheckResultModel;

  factory TranslationCheckResultModel.fromJson(Map<String, dynamic> json) =>
      _$TranslationCheckResultModelFromJson(json);
}

extension TranslationCheckResultModelExt on TranslationCheckResultModel {
  TranslationCheckResultEntity toEntity() => TranslationCheckResultEntity(
    correctTranslation: correctTranslation,
    score: score,
    mistakes: mistakes.map((e) => e.toEntity()).toList(),
  );
}
