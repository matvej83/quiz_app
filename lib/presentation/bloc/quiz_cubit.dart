import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/data/repository/quiz_repository_impl.dart';
import 'package:quiz_app/domain/repository/quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this.repository) : super(QuizInitial());
  final QuizRepository repository;

  void loadWords() async {
    try {
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
    final isCorrect =
        userAnswer.trim().toLowerCase() ==
        currentWord.russianWord.toLowerCase();
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
}
