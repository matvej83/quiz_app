import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/features/text_catalog/domain/entity/text_entity.dart';

part 'text_model.freezed.dart';
part 'text_model.g.dart';

@freezed
abstract class TextModel with _$TextModel {
  const TextModel._();

  const factory TextModel({
    required int id,
    required String title,
    required List<String> text,
    required int level,
  }) = _TextModel;

  factory TextModel.fromJson(Map<String, dynamic> json) =>
      _$TextModelFromJson(json);

  static List<TextModel> fromList(List<dynamic> list) {
    return list
        .map((jsonItem) => TextModel.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
  }
}

extension TextModelExt on TextModel {
  TextEntity toEntity() =>
      TextEntity(id: id, title: title, text: text, level: level);
}
