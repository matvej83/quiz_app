import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_entity.dart';
import 'package:quiz_app/features/translation/domain/respository/catalog_respository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

@lazySingleton
class LoadCatalogUseCase implements UseCase<List<TranslationEntity>, NoParams> {
  LoadCatalogUseCase(this.repository);

  final CatalogRepository repository;

  @override
  Future<Either<Failure, List<TranslationEntity>>> call(NoParams params) async {
    return await repository.loadCatalog();
  }
}
