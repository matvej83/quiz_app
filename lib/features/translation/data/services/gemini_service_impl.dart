import 'package:dartz/dartz.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/utils/app_utils.dart';
import 'package:quiz_app/features/translation/domain/services/gemini_service.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/translation_check_result_entity.dart';
import '../models/translation_check_result_model.dart';

@LazySingleton(as: GeminiService)
class GeminiServiceImpl implements GeminiService {
  GeminiServiceImpl(this._model);

  final GenerativeModel _model;

  @override
  Future<Either<Failure, TranslationCheckResultEntity>> checkTranslation({
    required String russianText,
    required String userTranslation,
  }) async {
    final prompt =
        '''
You are an English teacher.

Russian sentence:
"$russianText"

User translation:
"$userTranslation"

Analyze the translation.

Return ONLY valid JSON:

{
  "correctTranslation": "...",
  "score": 0-100,
  "mistakes": [
    {
      "word": "...",
      "suggestion": "...",
      "reason": "..."
    }
  ]
}
''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      final text = response.text ?? '';
      final json = AppUtils.parseJson(text);
      return Right(TranslationCheckResultModel.fromJson(json).toEntity());
    } catch (e) {
      return Left(GeminiFailure());
    }
  }
}
