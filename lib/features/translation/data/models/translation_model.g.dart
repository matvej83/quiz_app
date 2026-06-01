// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TranslationModel _$TranslationModelFromJson(Map<String, dynamic> json) =>
    _TranslationModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      text: (json['text'] as List<dynamic>).map((e) => e as String).toList(),
      level: (json['level'] as num).toInt(),
    );

Map<String, dynamic> _$TranslationModelToJson(_TranslationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'level': instance.level,
    };
