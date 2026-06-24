import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/quiz/presentation/cubit/cubit.dart';

import '../../../dictionary/data/database/app_database.dart';

class QuizState extends Equatable {
  const QuizState({
    this.status = QuizStatus.initial,
    this.words = const [],
    this.additionalWords = const [],
    this.answers = const [],
    this.currentIndex = 0,
    this.answered = false,
    this.correct = false,
    this.userAnswer,
    this.correctCount = 0,
    this.errorMessage,
  });

  final QuizStatus status;
  final List<Word> words;
  final List<String> additionalWords;
  final List<String> answers;
  final int currentIndex;
  final bool answered;
  final bool correct;
  final String? userAnswer;
  final int correctCount;
  final String? errorMessage;

  QuizState copyWith({
    QuizStatus? status,
    List<Word>? words,
    List<String>? additionalWords,
    List<String>? answers,
    int? currentIndex,
    bool? answered,
    bool? correct,
    String? userAnswer,
    int? correctCount,
    String? errorMessage,
  }) {
    return QuizState(
      status: status ?? this.status,
      words: words ?? this.words,
      additionalWords: additionalWords ?? this.additionalWords,
      answers: answers ?? this.answers,
      currentIndex: currentIndex ?? this.currentIndex,
      answered: answered ?? this.answered,
      correct: correct ?? this.correct,
      userAnswer: userAnswer ?? this.userAnswer,
      correctCount: correctCount ?? this.correctCount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<dynamic> get props => [
    status,
    words,
    additionalWords,
    answers,
    currentIndex,
    answered,
    correct,
    userAnswer,
    correctCount,
    errorMessage,
  ];
}
