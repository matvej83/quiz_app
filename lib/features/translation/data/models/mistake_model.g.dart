// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mistake_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MistakeModel _$MistakeModelFromJson(Map<String, dynamic> json) =>
    _MistakeModel(
      word: json['word'] as String,
      suggestion: json['suggestion'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$MistakeModelToJson(_MistakeModel instance) =>
    <String, dynamic>{
      'word': instance.word,
      'suggestion': instance.suggestion,
      'reason': instance.reason,
    };
