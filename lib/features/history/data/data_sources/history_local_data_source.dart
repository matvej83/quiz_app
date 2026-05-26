import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception.dart';
import '../../../dictionary/data/database/app_database.dart';
import '../models/history_model.dart';

abstract class HistoryLocalDataSource {
  Future<List<HistoryModel>?> fetchHistory({
    required int limit,
    required int offset,
  });

  Future<List<HistoryModel>?> fetchMonthHistory({
    required int year,
    required int month,
  });

  Future<void> saveHistory(HistoryModel history);

  Future<void> deleteHistory();
}

@LazySingleton(as: HistoryLocalDataSource)
class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  HistoryLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> deleteHistory() async {
    try {
      await _database.delete(_database.historyTable).go();
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<List<HistoryModel>?> fetchHistory({
    required int limit,
    required int offset,
  }) async {
    try {
      final result =
          await (_database.select(_database.historyTable)
                ..orderBy([(t) => OrderingTerm.desc(t.saved)])
                ..limit(limit, offset: offset))
              .get();

      return result
          .map(
            (item) => HistoryModel(
              testType: item.testType,
              saved: item.saved,
              correctAnswers: item.correctAnswers,
              totalAnswers: item.totalAnswers,
            ),
          )
          .toList();
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<List<HistoryModel>?> fetchMonthHistory({
    required int year,
    required int month,
  }) async {
    try {
      final startDate = DateTime(year, month);
      final endDate = month == 12
          ? DateTime(year + 1, 1)
          : DateTime(year, month + 1);

      final result =
          await (_database.select(_database.historyTable)
                ..where(
                  (t) =>
                      t.saved.isBiggerOrEqualValue(startDate) &
                      t.saved.isSmallerThanValue(endDate),
                )
                ..orderBy([(t) => OrderingTerm.desc(t.saved)]))
              .get();

      return result
          .map(
            (item) => HistoryModel(
              testType: item.testType,
              saved: item.saved,
              correctAnswers: item.correctAnswers,
              totalAnswers: item.totalAnswers,
            ),
          )
          .toList();
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<void> saveHistory(HistoryModel history) async {
    try {
      await _database
          .into(_database.historyTable)
          .insert(
            HistoryTableCompanion.insert(
              testType: history.testType,
              saved: history.saved,
              correctAnswers: history.correctAnswers,
              totalAnswers: history.totalAnswers,
            ),
          );
    } on Exception {
      throw CacheException();
    }
  }
}
