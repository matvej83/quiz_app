import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Words extends Table {
  TextColumn get englishWord =>
      text().named('english_word')();

  TextColumn get russianWord =>
      text().named('russian_word')();

  IntColumn get count =>
      integer().nullable()();

  RealColumn get probability =>
      real().nullable()();

  @override
  Set<Column> get primaryKey => {
    englishWord,
    russianWord,
  };
}

@DriftDatabase(tables: [Words])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Word>> searchWords(
      String query,
      ) {
    return (select(words)
      ..where(
            (tbl) => tbl.englishWord.like('$query%'),
      )
      ..orderBy([
            (t) => OrderingTerm.desc(t.count),
      ])
      ..limit(20))
        .get();
  }

  Future<List<Word>> getQuizWords(
      int limit,
      ) {
    return (select(words)
      ..where(
            (tbl) => tbl.probability.isBiggerThanValue(0.7),
      )
      ..orderBy([
            (t) => OrderingTerm.desc(t.count),
      ])
      ..limit(limit))
        .get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir =
    await getApplicationDocumentsDirectory();

    final file = File(
      p.join(dir.path, 'en_ru_dictionary.db'),
    );

    if (!await file.exists()) {
      final data = await rootBundle.load(
        'assets/database/en_ru_dictionary.db',
      );

      final bytes = data.buffer.asUint8List();

      await file.writeAsBytes(bytes);
    }

    return NativeDatabase.createInBackground(
      file,
    );
  });
}