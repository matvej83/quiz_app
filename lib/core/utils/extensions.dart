import '../../app/constants/app_constants.dart';
import '../../enums/app_enums.dart';
import '../../features/dictionary/data/database/app_database.dart';

extension WordX on Word {
  String questionFor(TranslationType type) {
    return type == TranslationType.enRu ? englishWord : russianWord;
  }

  String answerFor(TranslationType type) {
    return type == TranslationType.enRu ? russianWord : englishWord;
  }
}

extension TranslationTypeX on TranslationType {
  String get questionFor => switch (this) {
    TranslationType.enRu => AppConstants.enLocale,
    TranslationType.ruEn => AppConstants.ruLocale,
  };

  String get answerFor => switch (this) {
    TranslationType.enRu => AppConstants.ruLocale,
    TranslationType.ruEn => AppConstants.enLocale,
  };
}

extension NormalizeString on String {
  String normalize() => trim().toLowerCase();
}

extension DateX on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
