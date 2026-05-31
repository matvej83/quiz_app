import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/translation/domain/usecases/check_translation_usecase.dart';
import 'package:quiz_app/features/translation/presentation/cubit/state.dart';

import '../../../../core/error/failure.dart';

@lazySingleton
class TranslationCubit extends Cubit<TranslationState> {
  TranslationCubit({required this.checkTranslationUseCase})
    : super(const TranslationState());
  final CheckTranslationUseCase checkTranslationUseCase;

  Future<void> check({required String userTranslation}) async {
    emit(state.copyWith(status: TranslationStatus.loading));
    final result = await checkTranslationUseCase.call(
      CheckTranslationParams(
        russianText: state.russianText[state.currentIndex],
        userTranslation: userTranslation,
      ),
    );
    result.fold(
      (l) {
        final message = (l as GeminiFailure).message;
        emit(
          state.copyWith(
            error: message,
            status: TranslationStatus.error,
          ),
        );
      },
      (r) {
        emit(state.copyWith(result: r, status: TranslationStatus.answered));
      },
    );
  }

  Future<void> nextQuestion() async {
    final nextIndex = state.currentIndex + 1;
    final totalScore = state.totalScore + (state.result?.score ?? 0);
    if (nextIndex >= state.russianText.length) {
      emit(
        state.copyWith(
          status: TranslationStatus.completed,
          totalScore: totalScore,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: TranslationStatus.loaded,
          currentIndex: nextIndex,
          totalScore: totalScore,
          error: '',
        ),
      );
    }
  }

  Future<void> disableError() async {
    emit(state.copyWith(error: ''));
  }
}
