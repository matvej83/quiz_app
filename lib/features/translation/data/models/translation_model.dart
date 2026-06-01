import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_entity.dart';

part 'translation_model.freezed.dart';
part 'translation_model.g.dart';

@freezed
abstract class TranslationModel with _$TranslationModel {
  const TranslationModel._();

  const factory TranslationModel({
    required int id,
    required String title,
    required List<String> text,
    required int level,
  }) = _TranslationModel;

  factory TranslationModel.fromJson(Map<String, dynamic> json) =>
      _$TranslationModelFromJson(json);

  static List<TranslationModel> fromList(List<dynamic> list) {
    return list
        .map(
          (jsonItem) =>
              TranslationModel.fromJson(jsonItem as Map<String, dynamic>),
        )
        .toList();
  }
}

extension TranslationModelExt on TranslationModel {
  TranslationEntity toEntity() =>
      TranslationEntity(id: id, title: title, text: text, level: level);
}
