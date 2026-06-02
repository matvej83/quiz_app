import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/core/usecases/usecase.dart';
import 'package:quiz_app/features/text_catalog/presentation/cubit/state.dart';

import '../../domain/usecases/load_catalog_usecase.dart';

@lazySingleton
class TextCatalogCubit extends Cubit<TextCatalogState> {
  TextCatalogCubit({required this.loadCatalogUseCase})
    : super(const TextCatalogState());
  final LoadCatalogUseCase loadCatalogUseCase;

  Future<void> loadCatalog() async {
    emit(state.copyWith(isLoading: true));
    final result = await loadCatalogUseCase.call(NoParams());
    result.fold(
      (l) {
        emit(state.copyWith(translations: [], isLoading: false));
      },
      (r) {
        emit(state.copyWith(translations: r, isLoading: false));
      },
    );
  }
}
