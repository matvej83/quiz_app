import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/translation/domain/entity/mistake_entity.dart';

class TranslationCheckResultEntity extends Equatable {
  const TranslationCheckResultEntity({
    required this.correctTranslation,
    required this.score,
    required this.mistakes,
  });

  final String correctTranslation;
  final int score;
  final List<MistakeEntity> mistakes;

  @override
  List<Object?> get props => [correctTranslation, score, mistakes];
}
