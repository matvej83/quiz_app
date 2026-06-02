import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/app/utils/app_utils.dart';

void main() {
  group('AppUtils.parseJson', () {
    final json = '''json = {
  "correctTranslation": "I like programming on Flutter.",
  "score": 45,
  "mistakes": [
    {
      "word": "program",
      "suggestion": "programming",
      "reason": "The Russian 'программировать' is an infinitive verb. After 'I like', it should be in the gerund form ('programming') or as an infinitive ('to program'), not the base form 'program' by itself."
    },
    {
      "word": "flutter",
      "suggestion": "on Flutter",
      "reason": "The Russian preposition 'на' (na) in 'на Flutter' indicates the platform or technology being used. This should be translated as 'on' in English (e.g., 'on Flutter')."
    }
  ]
}''';

    test('returns parsed json', () {
      final result = {
        'correctTranslation': 'I like programming on Flutter.',
        'score': 45,
        'mistakes': [
          {
            'word': 'program',
            'suggestion': 'programming',
            'reason':
                "The Russian 'программировать' is an infinitive verb. After 'I like', it should be in the gerund form ('programming') or as an infinitive ('to program'), not the base form 'program' by itself.",
          },
          {
            'word': 'flutter',
            'suggestion': 'on Flutter',
            'reason':
                "The Russian preposition 'на' (na) in 'на Flutter' indicates the platform or technology being used. This should be translated as 'on' in English (e.g., 'on Flutter').",
          },
        ],
      };
      final parsed = AppUtils.parseJson(json);
      expect(result, parsed);
    });
  });
}
