// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_check_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TranslationCheckResultModel _$TranslationCheckResultModelFromJson(
  Map<String, dynamic> json,
) => _TranslationCheckResultModel(
  correctTranslation: json['correctTranslation'] as String,
  score: (json['score'] as num).toInt(),
  mistakes: (json['mistakes'] as List<dynamic>)
      .map((e) => MistakeModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TranslationCheckResultModelToJson(
  _TranslationCheckResultModel instance,
) => <String, dynamic>{
  'correctTranslation': instance.correctTranslation,
  'score': instance.score,
  'mistakes': instance.mistakes.map((e) => e.toJson()).toList(),
};
