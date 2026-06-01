import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/error/failure.dart';
import 'package:quiz_app/features/text_catalog/domain/entity/text_entity.dart';

abstract class TextCatalogRepository {
  Future<Either<Failure, List<TextEntity>>> loadData();
}
