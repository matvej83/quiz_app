import 'package:equatable/equatable.dart';

import '../../domain/entity/history_entity.dart';

class HistoryState extends Equatable {
  const HistoryState({
    this.history = const [],
    this.trainingDays = const [],
    this.error,
    this.isLoading = false,
    this.isShowLoader = false,
    this.success = false,
    this.initialized = false,
  });

  final List<HistoryEntity> history;
  final List<DateTime> trainingDays;
  final String? error;
  final bool isLoading;
  final bool isShowLoader;
  final bool success;
  final bool initialized;

  HistoryState copyWith({
    List<HistoryEntity>? history,
    List<DateTime>? trainingDays,
    String? error,
    bool? isLoading,
    bool? isShowLoader,
    bool? success,
    bool? initialized,
  }) {
    return HistoryState(
      history: history ?? this.history,
      trainingDays: trainingDays ?? this.trainingDays,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isShowLoader: isShowLoader ?? this.isShowLoader,
      success: success ?? this.success,
      initialized: initialized ?? this.initialized,
    );
  }

  @override
  List<dynamic> get props => [
    history,
    trainingDays,
    error,
    isLoading,
    isShowLoader,
    success,
    initialized,
  ];
}
