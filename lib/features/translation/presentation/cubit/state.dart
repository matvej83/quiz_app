import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_check_result_entity.dart';

class TranslationState extends Equatable {
  const TranslationState({this.result, this.error, this.isLoading = false});

  final TranslationCheckResultEntity? result;
  final String? error;
  final bool isLoading;

  TranslationState copyWith({
    TranslationCheckResultEntity? result,
    String? error,
    bool? isLoading,
  }) {
    return TranslationState(
      result: result ?? this.result,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<dynamic> get props => [result, error, isLoading];
}
