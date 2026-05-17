import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../database/app_database.dart';

@lazySingleton
class DictionaryLocalDataSource {
  DictionaryLocalDataSource(this.database);

  final AppDatabase database;

  Future<List<Word>> searchWords(String query) {
    return (database.select(database.words)
          ..where((tbl) => tbl.englishWord.like('$query%'))
          ..orderBy([(t) => OrderingTerm.desc(t.count)])
          ..limit(20))
        .get();
  }

  Future<List<Word>> getQuizWords(int limit) {
    return (database.select(database.words)
          ..where((tbl) => tbl.probability.isBiggerThanValue(0.7))
          ..orderBy([(t) => OrderingTerm.desc(t.count)])
          ..limit(limit))
        .get();
  }
}
