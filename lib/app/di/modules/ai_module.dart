import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AiModule {
  @lazySingleton
  GenerativeModel generativeModel() {
    return GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );
  }
}
