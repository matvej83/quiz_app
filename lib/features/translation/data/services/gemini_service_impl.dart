import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/constants/app_constants.dart';
import 'package:quiz_app/app/utils/app_utils.dart';
import 'package:quiz_app/features/translation/domain/services/gemini_service.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/translation_check_result_entity.dart';
import '../models/translation_check_result_model.dart';

@LazySingleton(as: GeminiService)
class GeminiServiceImpl implements GeminiService {
  GeminiServiceImpl();

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

Provide "reason" value as a text in russian language.
''';

    try {
      final response = await http.post(
        Uri.parse(AppConstants.cloudFlareWorkerUrl),
        headers: {
          'Content-Type': 'application/json',
          'X-APP-TOKEN': AppConstants.cloudFlareWorkerToken,
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt},
              ],
            },
          ],
        }),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      final text = json['candidates'][0]['content']['parts'][0]['text'];

      final parsed = AppUtils.parseJson(text);

      return Right(TranslationCheckResultModel.fromJson(parsed).toEntity());
    } catch (e) {
      log('error $e');
      final userMessage = AppUtils.parseGeminiError(e);
      return Left(GeminiFailure(message: userMessage));
    }
  }
}
