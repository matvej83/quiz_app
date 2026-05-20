import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/constants/asset_paths.dart';
import 'package:quiz_app/enums/app_enums.dart';

import '../../../../app/constants/app_constants.dart';
import '../../../dictionary/data/data_sources/dictionary_local_data_source.dart';
import '../../../dictionary/services/tts_service.dart';
import 'quiz_state.dart';

@lazySingleton
class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this.repository, this.ttsService) : super(QuizInitial());
  final DictionaryLocalDataSource repository;
  final TtsService ttsService;
  TranslationType? type;

  void loadWords({required TranslationType type}) async {
    try {
      this.type = type;
      await ttsService.setLanguage(
        type == TranslationType.enRu
            ? AppConstants.enLocale
            : AppConstants.ruLocale,
      );
      emit(QuizLoading());
      final words = await repository.getQuizWords(10);
      if (words.isEmpty) {
        emit(const QuizCompleted(correctAnswers: 0, totalQuestions: 0));
      } else {
        emit(
          QuizLoaded(
            words: words,
            currentIndex: 0,
            answered: false,
            correct: false,
            correctCount: 0,
          ),
        );
      }
    } catch (e) {
      emit(QuizError('Failed to load words: $e'));
    }
  }

  void checkAnswer(String userAnswer) {
    if (state is! QuizLoaded) return;
    final loadedState = state as QuizLoaded;
    final currentWord = loadedState.words[loadedState.currentIndex];
    final correctAnswer = type == TranslationType.enRu
        ? currentWord.russianWord.toLowerCase()
        : currentWord.englishWord.toLowerCase();
    final isCorrect = userAnswer.trim().toLowerCase() == correctAnswer;
    emit(
      QuizLoaded(
        words: loadedState.words,
        currentIndex: loadedState.currentIndex,
        answered: true,
        correct: isCorrect,
        userAnswer: userAnswer.trim(),
        correctCount: loadedState.correctCount,
      ),
    );
  }

  String getCup({required int total, required int correct}) {
    final percent = (correct / total);
    if (percent >= 0.8) {
      return AssetPaths.goldenCup;
    }
    if (percent >= 0.6) {
      return AssetPaths.silverCup;
    }
    return AssetPaths.bronzeCup;
  }

  void nextQuestion() {
    if (state is! QuizLoaded) return;
    final loadedState = state as QuizLoaded;
    final nextIndex = loadedState.currentIndex + 1;
    if (nextIndex >= loadedState.words.length) {
      final totalQuestions = loadedState.words.length;
      final finalCorrect =
          loadedState.correctCount + (loadedState.correct ? 1 : 0);
      emit(
        QuizCompleted(
          correctAnswers: finalCorrect,
          totalQuestions: totalQuestions,
        ),
      );
    } else {
      emit(
        QuizLoaded(
          words: loadedState.words,
          currentIndex: nextIndex,
          answered: false,
          userAnswer: null,
          correct: false,
          correctCount:
              loadedState.correctCount + (loadedState.correct ? 1 : 0),
        ),
      );
    }
  }

  /// uses for flashcards only
  void previousQuestion() {
    if (state is! QuizLoaded) return;
    final loadedState = state as QuizLoaded;
    if (loadedState.currentIndex == 0) return;
    final previousIndex = loadedState.currentIndex - 1;
    emit(
      QuizLoaded(
        words: loadedState.words,
        currentIndex: previousIndex,
        answered: false,
        userAnswer: null,
        correct: false,
        correctCount: loadedState.correctCount,
      ),
    );
  }

  Future<void> pronounceWord(String word, {String? language}) async {
    if (language != null) {
      await ttsService.setLanguage(language);
    }
    await ttsService.speak(word);
  }
}
