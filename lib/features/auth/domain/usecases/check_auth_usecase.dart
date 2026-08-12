import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../profile/domain/repository/profile_repository.dart';

@lazySingleton
class CheckAuthUseCase implements UseCase<bool, NoParams> {
  CheckAuthUseCase(this.repository);

  final ProfileRepository repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.hasProfile();
  }
}
