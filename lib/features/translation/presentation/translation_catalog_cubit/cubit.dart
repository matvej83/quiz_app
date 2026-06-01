import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/core/usecases/usecase.dart';
import 'package:quiz_app/features/translation/domain/usecases/load_catalog_usecase.dart';
import 'package:quiz_app/features/translation/presentation/translation_catalog_cubit/state.dart';

@lazySingleton
class TranslationCatalogCubit extends Cubit<TranslationCatalogState> {
  TranslationCatalogCubit({required this.loadCatalogUseCase})
    : super(const TranslationCatalogState());
  final LoadCatalogUseCase loadCatalogUseCase;

  Future<void> loadCatalog() async {
    if (state.translations.isNotEmpty) {
      return;
    }
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
