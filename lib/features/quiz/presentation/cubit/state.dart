import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/features/quiz/presentation/cubit/cubit.dart';

import '../../../dictionary/data/database/app_database.dart';

part 'state.freezed.dart';

@freezed
abstract class QuizState with _$QuizState {
  const factory QuizState({
    @Default(QuizStatus.initial) QuizStatus status,
    @Default([]) List<Word> words,
    @Default([]) List<String> additionalWords,
    @Default([]) List<String> answers,
    @Default(0) int currentIndex,
    @Default(0) int correctCount,
    String? errorMessage,
    String? userAnswer,
    @Default(false) bool answered,
    @Default(false) bool correct,
  }) = _QuizState;
}
