import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/constants/asset_paths.dart';
import 'package:quiz_app/core/utils/extensions.dart';
import 'package:quiz_app/enums/app_enums.dart';

import '../../../../app/constants/app_constants.dart';
import '../../../dictionary/data/data_sources/dictionary_local_data_source.dart';
import '../../../dictionary/data/database/app_database.dart';
import '../../../dictionary/services/tts_service.dart';
import 'quiz_state.dart';

@lazySingleton
class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this.dataSource, this.ttsService) : super(QuizInitial());
  final DictionaryLocalDataSource dataSource;
  final TtsService ttsService;
  TranslationType type = TranslationType.enRu;

  void loadWords({
    required TranslationType type,
    bool loadAdditionalWords = false,
  }) async {
    try {
      List<String> additionalWords = [];
      List<String> answers = [];
      this.type = type;
      await ttsService.setLanguage(
        type == TranslationType.enRu
            ? AppConstants.enLocale
            : AppConstants.ruLocale,
      );
      emit(QuizLoading());
      final words = await dataSource.getQuizWords(10);
      if (loadAdditionalWords) {
        final list = await dataSource.getWords(10);
        additionalWords = getAdditionalWords(list);
        answers = getAnswers(
          current: words.first,
          additionalWords: additionalWords,
        );
      }
      if (words.isEmpty) {
        emit(const QuizCompleted(correctAnswers: 0, totalQuestions: 0));
      } else {
        emit(
          QuizLoaded(
            words: words,
            additionalWords: additionalWords,
            answers: answers,
            currentIndex: 0,
            answered: false,
            correct: false,
            correctCount: 0,
          ),
        );
      }
    } catch (e, st) {
      log(st.toString());
      emit(QuizError('${'errors.noWords'.tr()}: $e'));
    }
  }

  List<String> getAdditionalWords(List<Word> words) {
    final shuffled = List<Word>.from(words)..shuffle();

    return shuffled.map((e) => e.answerFor(type)).toList();
  }

  List<String> getAnswers({
    required Word current,
    required List<String> additionalWords,
  }) {
    final answer = current.answerFor(type);
    final tmp = [...additionalWords]..shuffle();
    final answers = tmp.take(3).toList();
    answers.add(answer);
    answers.shuffle();
    return answers;
  }

  void checkAnswer(String userAnswer, {bool goToNext = false}) {
    if (state is! QuizLoaded) return;
    final loadedState = state as QuizLoaded;
    final currentWord = loadedState.words[loadedState.currentIndex];
    final correctAnswer = currentWord.answerFor(type).normalize();
    final isCorrect = userAnswer.normalize() == correctAnswer;
    emit(
      loadedState.copyWith(
        answered: true,
        correct: isCorrect,
        userAnswer: userAnswer.trim(),
      ),
    );
    if (goToNext) {
      Future.delayed(const Duration(seconds: 5), () {
        nextQuestion(loadAdditionalWords: true);
      });
    }
  }

  String getCup({required int total, required int correct}) {
    final percent = total != 0 ? (correct / total) : 0;
    if (percent >= 0.8) {
      return AssetPaths.goldenCup;
    }
    if (percent >= 0.6) {
      return AssetPaths.silverCup;
    }
    return AssetPaths.bronzeCup;
  }

  void nextQuestion({bool loadAdditionalWords = false}) {
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
      List<String> answers = [];
      if (loadAdditionalWords) {
        final current = loadedState.words[nextIndex];
        answers = getAnswers(
          current: current,
          additionalWords: loadedState.additionalWords,
        );
      }
      emit(
        loadedState.copyWith(
          answers: answers,
          currentIndex: nextIndex,
          answered: false,
          userAnswer: '',
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
      loadedState.copyWith(
        currentIndex: previousIndex,
        answered: false,
        userAnswer: '',
        correct: false,
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
