import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/text_catalog/domain/entity/text_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/text_catalog_repository.dart';

@lazySingleton
class LoadCatalogUseCase implements UseCase<List<TextEntity>, NoParams> {
  LoadCatalogUseCase(this.repository);

  final TextCatalogRepository repository;

  @override
  Future<Either<Failure, List<TextEntity>>> call(NoParams params) async {
    return await repository.loadData();
  }
}
