import 'package:drift/drift.dart';

class Words extends Table {
  TextColumn get englishWord => text().named('english_word')();

  TextColumn get russianWord => text().named('russian_word')();

  IntColumn get count => integer().nullable()();

  RealColumn get probability => real().nullable()();

  @override
  Set<Column> get primaryKey => {englishWord, russianWord};
}
