import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/core/error/failure.dart';
import 'package:quiz_app/features/translation/data/data_sources/catalog_local_data_source.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_entity.dart';

import '../../../../core/error/mapper.dart';
import '../../domain/respository/catalog_respository.dart';
import '../models/translation_model.dart';

@LazySingleton(as: CatalogRepository)
class ProductsRepositoryImpl implements CatalogRepository {
  ProductsRepositoryImpl({required this.catalogLocalDataSource});

  final CatalogLocalDataSource catalogLocalDataSource;

  @override
  Future<Either<Failure, List<TranslationEntity>>> loadCatalog() async {
    try {
      final catalog = await catalogLocalDataSource.loadCatalog();
      final list = catalog?.map((e) => e.toEntity()).toList() ?? [];
      return Right(list);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
