import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/history/domain/entity/history_entity.dart';
import 'package:quiz_app/features/history/domain/repository/history_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

@lazySingleton
class FetchHistoryUseCase
    implements UseCase<List<HistoryEntity>, FetchHistoryParams> {
  FetchHistoryUseCase(this.repository);

  final HistoryRepository repository;

  @override
  Future<Either<Failure, List<HistoryEntity>>> call(
    FetchHistoryParams params,
  ) async {
    return await repository.fetchHistory(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

class FetchHistoryParams {
  FetchHistoryParams({required this.limit, required this.offset});

  final int limit;
  final int offset;
}
