import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/features/translation/domain/entity/mistake_entity.dart';

part 'mistake_model.freezed.dart';
part 'mistake_model.g.dart';

@freezed
abstract class MistakeModel with _$MistakeModel {
  const factory MistakeModel({
    required String word,
    required String suggestion,
    required String reason,
  }) = _MistakeModel;

  factory MistakeModel.fromJson(Map<String, dynamic> json) =>
      _$MistakeModelFromJson(json);
}

extension MistakeModelExt on MistakeModel {
  MistakeEntity toEntity() =>
      MistakeEntity(word: word, suggestion: suggestion, reason: reason);
}
