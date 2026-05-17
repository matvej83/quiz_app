import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/profile/domain/entity/profile_entity.dart';

import '../../../../core/error/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> fetchProfile();

  Future<Either<Failure, void>> saveProfile({required ProfileEntity profile});

  Future<Either<Failure, void>> deleteProfile();
}
