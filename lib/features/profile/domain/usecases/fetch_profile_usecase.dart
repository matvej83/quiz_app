import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/profile/domain/entity/profile_entity.dart';
import 'package:quiz_app/features/profile/domain/repository/profile_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

@lazySingleton
class FetchProfileUseCase implements UseCase<ProfileEntity, NoParams> {
  FetchProfileUseCase(this.repository);

  final ProfileRepository repository;

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) async {
    return await repository.fetchProfile();
  }
}
