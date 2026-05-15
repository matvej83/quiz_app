import 'package:quiz_app/database/app_database.dart' as db;
import 'package:quiz_app/domain/repository/quiz_state.dart' as domain;
import 'package:drift/drift.dart';

abstract class QuizRepository {
  Future<List<domain.Word>> getQuizWords(int limit);
  Future<List<domain.Word>> searchWords(String query);
  Future<void> updateWordProgress(String englishWord, String russianWord, bool correct);
}

class QuizRepositoryImpl implements QuizRepository {
  final db.AppDatabase database;

  QuizRepositoryImpl(this.database);

  @override
  Future<List<domain.Word>> getQuizWords(int limit) async {
    final words = await database.getQuizWords(limit);
    return words
        .map((word) => domain.Word(
              englishWord: word.englishWord,
              russianWord: word.russianWord,
              count: word.count,
              probability: word.probability,
            ))
        .toList();
  }

  @override
  Future<List<domain.Word>> searchWords(String query) async {
    final words = await database.searchWords(query);
    return words
        .map((word) => domain.Word(
              englishWord: word.englishWord,
              russianWord: word.russianWord,
              count: word.count,
              probability: word.probability,
            ))
        .toList();
  }

  @override
  Future<void> updateWordProgress(String englishWord, String russianWord, bool correct) async {
    final existing = await (database.select(database.words)
          ..where((tbl) => tbl.englishWord.equals(englishWord) & tbl.russianWord.equals(russianWord)))
        .get();
    if (existing.isNotEmpty) {
      final word = existing.first;
      final newCount = (word.count ?? 0) + 1;
      final newProbability = correct ? 0.9 : 0.1;
      await (database.update(database.words)
            ..where((tbl) => tbl.englishWord.equals(englishWord) & tbl.russianWord.equals(russianWord)))
          .write(db.WordsCompanion(
            englishWord: Value(englishWord),
            russianWord: Value(russianWord),
            count: Value(newCount),
            probability: Value(newProbability),
          ));
    }
  }
}