import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/core/error/failure.dart';
import 'package:quiz_app/features/text_catalog/domain/entity/text_entity.dart';

import '../../../../core/error/mapper.dart';
import '../../domain/repository/text_catalog_repository.dart';
import '../data_sources/text_catalog_local_data_source.dart';
import '../models/text_model.dart';

@LazySingleton(as: TextCatalogRepository)
class TextCatalogRepositoryImpl implements TextCatalogRepository {
  TextCatalogRepositoryImpl({required this.catalogLocalDataSource});

  final TextCatalogLocalDataSource catalogLocalDataSource;

  @override
  Future<Either<Failure, List<TextEntity>>> loadData() async {
    try {
      final catalog = await catalogLocalDataSource.loadCatalog();
      final list = catalog?.map((e) => e.toEntity()).toList() ?? [];
      return Right(list);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
