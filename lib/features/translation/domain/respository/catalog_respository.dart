import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_entity.dart';

import '../../../../core/error/failure.dart';

abstract class CatalogRepository {
  Future<Either<Failure, List<TranslationEntity>>> loadCatalog();
}
