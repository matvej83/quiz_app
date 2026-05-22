import 'package:equatable/equatable.dart';

import '../../../dictionary/data/database/app_database.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<dynamic> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  const QuizLoaded({
    required this.words,
    required this.additionalWords,
    required this.answers,
    required this.currentIndex,
    required this.answered,
    required this.correct,
    this.userAnswer,
    this.correctCount = 0,
  });

  final List<Word> words;
  final List<String> additionalWords;
  final List<String> answers;
  final int currentIndex;
  final bool answered;
  final bool correct;
  final String? userAnswer;
  final int correctCount;

  QuizLoaded copyWith({
    List<Word>? words,
    List<String>? additionalWords,
    List<String>? answers,
    int? currentIndex,
    bool? answered,
    bool? correct,
    String? userAnswer,
    int? correctCount,
  }) {
    return QuizLoaded(
      words: words ?? this.words,
      additionalWords: additionalWords ?? this.additionalWords,
      answers: answers ?? this.answers,
      currentIndex: currentIndex ?? this.currentIndex,
      answered: answered ?? this.answered,
      correct: correct ?? this.correct,
      userAnswer: userAnswer ?? this.userAnswer,
      correctCount: correctCount ?? this.correctCount,
    );
  }

  @override
  List<dynamic> get props => [
    words,
    additionalWords,
    answers,
    currentIndex,
    answered,
    correct,
    userAnswer,
    correctCount,
  ];
}

class QuizCompleted extends QuizState {
  const QuizCompleted({
    required this.correctAnswers,
    required this.totalQuestions,
  });

  final int correctAnswers;
  final int totalQuestions;

  @override
  List<dynamic> get props => [correctAnswers, totalQuestions];
}

class QuizError extends QuizState {
  const QuizError(this.message);

  final String message;

  @override
  List<dynamic> get props => [message];
}
