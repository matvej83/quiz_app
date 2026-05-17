import 'package:drift/drift.dart';

import '../models/words.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Words])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;
}
