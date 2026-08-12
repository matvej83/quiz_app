import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/history/domain/entity/history_entity.dart';
import 'package:quiz_app/features/history/domain/repository/history_repository.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';

@lazySingleton
class FetchMonthHistoryUseCase
    implements UseCase<List<HistoryEntity>, FetchMonthHistoryParams> {
  FetchMonthHistoryUseCase(this.repository);

  final HistoryRepository repository;

  @override
  Future<Either<Failure, List<HistoryEntity>>> call(
    FetchMonthHistoryParams params,
  ) async {
    return await repository.fetchMonthHistory(params.date);
  }
}

class FetchMonthHistoryParams {
  FetchMonthHistoryParams({required this.date});

  final DateTime date;
}
