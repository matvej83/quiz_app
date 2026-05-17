import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/core/error/failure.dart';
import 'package:quiz_app/features/profile/data/data_sources/profile_local_data_source.dart';
import 'package:quiz_app/features/profile/domain/entity/profile_entity.dart';

import '../../../../core/error/mapper.dart';
import '../../domain/repository/profile_repository.dart';
import '../models/profile_model.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required this.profileLocalDataSource});

  final ProfileLocalDataSource profileLocalDataSource;

  @override
  Future<Either<Failure, ProfileEntity>> fetchProfile() async {
    try {
      final profile = await profileLocalDataSource.fetchProfile();
      if (profile == null) {
        return Left(NoProfileFailure());
      }
      return Right(profile.toEntity());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> saveProfile({
    required ProfileEntity profile,
  }) async {
    try {
      await profileLocalDataSource.saveProfile(profile.toModel());
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfile() async {
    try {
      await profileLocalDataSource.deleteProfile();
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
