import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/history/domain/repository/history_repository.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';

@lazySingleton
class DeleteHistoryUseCase implements UseCase<void, NoParams> {
  DeleteHistoryUseCase(this.repository);

  final HistoryRepository repository;

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.deleteHistory();
  }
}
