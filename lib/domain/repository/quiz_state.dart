library quiz_domain;

import 'package:equatable/equatable.dart';

abstract class QuizState extends Equatable {
  const QuizState();
  @override
  List<dynamic> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Word> words;
  final int currentIndex;
  final bool answered;
  final bool correct;
  final String? userAnswer;
  final int correctCount;

  const QuizLoaded({
    required this.words,
    required this.currentIndex,
    required this.answered,
    required this.correct,
    this.userAnswer,
    this.correctCount = 0,
  });

  QuizLoaded copyWith({
    List<Word>? words,
    int? currentIndex,
    bool? answered,
    bool? correct,
    String? userAnswer,
    int? correctCount,
  }) {
    return QuizLoaded(
      words: words ?? this.words,
      currentIndex: currentIndex ?? this.currentIndex,
      answered: answered ?? this.answered,
      correct: correct ?? this.correct,
      userAnswer: userAnswer ?? this.userAnswer,
      correctCount: correctCount ?? this.correctCount,
    );
  }

  @override
  List<dynamic> get props => [words, currentIndex, answered, correct, userAnswer, correctCount];
}

class QuizCompleted extends QuizState {
  final int correctAnswers;
  final int totalQuestions;

  const QuizCompleted({
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  List<dynamic> get props => [correctAnswers, totalQuestions];
}

class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<dynamic> get props => [message];
}

class Word extends Equatable {
  final String englishWord;
  final String russianWord;
  final int? count;
  final double? probability;

  const Word({
    required this.englishWord,
    required this.russianWord,
    this.count,
    this.probability,
  });

  @override
  List<dynamic> get props => [englishWord, russianWord, count, probability];
}