import 'package:equatable/equatable.dart';

import '../../domain/entity/history_entity.dart';

class HistoryState extends Equatable {
  const HistoryState({
    this.history = const [],
    this.error,
    this.isLoading = false,
    this.success = false,
    this.initialized = false,
  });

  final List<HistoryEntity> history;
  final String? error;
  final bool isLoading;
  final bool success;
  final bool initialized;

  HistoryState copyWith({
    List<HistoryEntity>? history,
    String? error,
    bool? isLoading,
    bool? success,
    bool? initialized,
  }) {
    return HistoryState(
      history: history ?? this.history,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      initialized: initialized ?? this.initialized,
    );
  }

  @override
  List<dynamic> get props => [history, error, isLoading, success, initialized];
}
