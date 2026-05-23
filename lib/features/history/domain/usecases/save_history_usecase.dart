import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/history_entity.dart';
import '../repository/history_repository.dart';

@lazySingleton
class SaveHistoryUseCase implements UseCase<void, HistoryParams> {
  SaveHistoryUseCase(this.repository);

  final HistoryRepository repository;

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.saveHistory(history: params.history);
  }
}

class HistoryParams {
  HistoryParams({required this.history});

  final HistoryEntity history;
}
