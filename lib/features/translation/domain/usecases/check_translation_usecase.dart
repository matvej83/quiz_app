import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_check_result_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../services/gemini_service.dart';

@lazySingleton
class CheckTranslationUseCase
    implements UseCase<TranslationCheckResultEntity, CheckTranslationParams> {
  CheckTranslationUseCase(this.geminiService);

  final GeminiService geminiService;

  @override
  Future<Either<Failure, TranslationCheckResultEntity>> call(
    CheckTranslationParams params,
  ) async {
    return await geminiService.checkTranslation(
      russianText: params.russianText,
      userTranslation: params.userTranslation,
    );
  }
}

class CheckTranslationParams {
  CheckTranslationParams({
    required this.russianText,
    required this.userTranslation,
  });

  final String russianText;
  final String userTranslation;
}
