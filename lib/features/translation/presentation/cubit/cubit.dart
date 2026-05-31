import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/translation/domain/usecases/check_translation_usecase.dart';
import 'package:quiz_app/features/translation/presentation/cubit/state.dart';

@lazySingleton
class TranslationCubit extends Cubit<TranslationState> {
  TranslationCubit({required this.checkTranslationUseCase})
    : super(const TranslationState());
  final CheckTranslationUseCase checkTranslationUseCase;

  Future<void> check({
    required String russianText,
    required String userTranslation,
  }) async {
    emit(state.copyWith(isLoading: true));
    final result = await checkTranslationUseCase.call(
      CheckTranslationParams(
        russianText: russianText,
        userTranslation: userTranslation,
      ),
    );
    result.fold(
      (l) {
        emit(state.copyWith(error: 'Gemini error', isLoading: false));
      },
      (r) {
        emit(state.copyWith(result: r, isLoading: false));
      },
    );
  }

  Future<void> disableError() async {
    emit(state.copyWith(error: ''));
  }
}
