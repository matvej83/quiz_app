import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/history_entity.dart';

part 'state.freezed.dart';

@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default([]) List<HistoryEntity> history,
    @Default([]) List<DateTime> trainingDays,
    String? error,
    @Default(false) bool isLoading,
    @Default(false) bool isShowLoader,
    @Default(false) bool success,
    @Default(false) bool initialized,
  }) = _HistoryState;
}
