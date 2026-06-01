// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TextModel _$TextModelFromJson(Map<String, dynamic> json) => _TextModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  text: (json['text'] as List<dynamic>).map((e) => e as String).toList(),
  level: (json['level'] as num).toInt(),
);

Map<String, dynamic> _$TextModelToJson(_TextModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'level': instance.level,
    };
