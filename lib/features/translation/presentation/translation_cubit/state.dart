import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_check_result_entity.dart';

enum TranslationStatus { initial, loading, loaded, error, answered, completed }

class TranslationState extends Equatable {
  const TranslationState({
    this.status = TranslationStatus.initial,
    this.result,
    this.russianText = const [],
    this.currentIndex = 0,
    this.totalScore = 0,
    this.error,
  });

  final TranslationStatus status;
  final TranslationCheckResultEntity? result;
  final List<String> russianText;
  final int currentIndex;
  final int totalScore;
  final String? error;

  TranslationState copyWith({
    TranslationStatus? status,
    TranslationCheckResultEntity? result,
    List<String>? russianText,
    int? currentIndex,
    int? totalScore,
    String? error,
  }) {
    return TranslationState(
      status: status ?? this.status,
      result: result ?? this.result,
      russianText: russianText ?? this.russianText,
      currentIndex: currentIndex ?? this.currentIndex,
      totalScore: totalScore ?? this.totalScore,
      error: error ?? this.error,
    );
  }

  @override
  List<dynamic> get props => [
    status,
    result,
    russianText,
    currentIndex,
    totalScore,
    error,
  ];
}
