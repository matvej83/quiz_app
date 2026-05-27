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

extension NormalizeString on String {
  String normalize() => trim().toLowerCase();
}

extension DateX on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
