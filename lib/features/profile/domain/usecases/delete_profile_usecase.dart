import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/profile/domain/repository/profile_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

@lazySingleton
class DeleteProfileUseCase implements UseCase<void, NoParams> {
  DeleteProfileUseCase(this.repository);

  final ProfileRepository repository;

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.deleteProfile();
  }
}
