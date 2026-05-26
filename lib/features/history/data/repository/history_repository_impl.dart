import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/core/error/failure.dart';

import '../../../../core/error/mapper.dart';
import '../../domain/entity/history_entity.dart';
import '../../domain/repository/history_repository.dart';
import '../data_sources/history_local_data_source.dart';

@LazySingleton(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl({required this.historyLocalDataSource});

  final HistoryLocalDataSource historyLocalDataSource;

  @override
  Future<Either<Failure, List<HistoryEntity>>> fetchHistory({
    required int limit,
    required int offset,
  }) async {
    try {
      final history = await historyLocalDataSource.fetchHistory(
        limit: limit,
        offset: offset,
      );
      if (history == null) {
        return Left(NoHistoryFailure());
      }
      return Right(HistoryEntity.fromHistoryModelList(history));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> saveHistory({
    required HistoryEntity history,
  }) async {
    try {
      await historyLocalDataSource.saveHistory(history.toModel());
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHistory() async {
    try {
      await historyLocalDataSource.deleteHistory();
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
