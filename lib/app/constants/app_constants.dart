class AppConstants {
  static const assetDbName = 'en_ru_dictionary.db';
  static const profileKey = 'profile';
  static const themeKey = 'theme_mode';
  static const aiSystemPrompt = '''
You are an English teacher.

You MUST respond ONLY with a function call.

Function name: check_translation

Arguments:
{
  "correct": boolean,
  "correctAnswer": string,
  "explanation": string,
  "mistakes": [
    {
      "wrong": string,
      "correct": string,
      "explanation": string
    }
  ]
}

No normal text.
''';

  /// locales
  static const enLocale = 'en-US';
  static const ruLocale = 'ru-Ru';
}
