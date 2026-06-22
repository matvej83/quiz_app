import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/history_entity.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<HistoryEntity>>> fetchHistory({
    required int limit,
    required int offset,
  });

  Future<Either<Failure, List<HistoryEntity>>> fetchMonthHistory(DateTime date);

  Future<Either<Failure, void>> saveHistory({required HistoryEntity history});

  Future<Either<Failure, void>> deleteHistory();
}
