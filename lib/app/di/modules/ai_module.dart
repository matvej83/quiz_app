import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

import '../../constants/app_constants.dart';

@module
abstract class AiModule {
  @lazySingleton
  GenerativeModel generativeModel() {
    return GenerativeModel(
      model: AppConstants.aiModelName,
      apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );
  }
}
