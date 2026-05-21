import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../database/app_database.dart';

@lazySingleton
class DictionaryLocalDataSource {
  DictionaryLocalDataSource(this.database);

  final AppDatabase database;

  Future<List<Word>> getWords(int limit) {
    return (database.select(database.words)..limit(limit * 4)).get();
  }

  Future<List<Word>> getQuizWords(int limit) async {
    final words =
        await (database.select(database.words)
              ..where((tbl) => tbl.probability.isBiggerThanValue(0.7))
              ..orderBy([(t) => OrderingTerm.desc(t.count)])
              ..limit(100))
            .get();

    words.shuffle();

    return words.take(limit).toList();
  }
}
