import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_check_result_entity.dart';

import '../../../../core/error/failure.dart';

abstract class GeminiService {
  Future<Either<Failure, TranslationCheckResultEntity>> checkTranslation({
    required String russianText,
    required String userTranslation,
  });
}
