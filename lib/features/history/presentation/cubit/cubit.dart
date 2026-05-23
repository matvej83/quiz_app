import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/utils/app_utils.dart';
import 'package:quiz_app/core/usecases/usecase.dart';
import 'package:quiz_app/enums/app_enums.dart';
import 'package:quiz_app/features/history/presentation/cubit/state.dart';

import '../../domain/entity/history_entity.dart';
import '../../domain/usecases/delete_history_usecase.dart';
import '../../domain/usecases/fetch_history_usecase.dart';
import '../../domain/usecases/save_history_usecase.dart';

@lazySingleton
class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({
    required this.fetchHistoryUseCase,
    required this.saveHistoryUseCase,
    required this.deleteHistoryUseCase,
  }) : super(const HistoryState());
  final FetchHistoryUseCase fetchHistoryUseCase;
  final SaveHistoryUseCase saveHistoryUseCase;
  final DeleteHistoryUseCase deleteHistoryUseCase;

  Future<void> loadHistory({bool loadSilent = true}) async {
    if (!loadSilent) {
      emit(state.copyWith(isLoading: true));
    }
    final mode = await fetchHistoryUseCase(NoParams());
    mode.fold(
      (l) {
        emit(
          state.copyWith(
            error: AppUtils.parseFailureMessage(l),
            isLoading: false,
            initialized: true,
          ),
        );
      },
      (r) {
        emit(state.copyWith(history: r, isLoading: false, initialized: true));
      },
    );
  }

  Future<void> addHistoryItem({
    required TestType testType,
    required int correctAnswers,
    required int totalAnswers,
  }) async {
    emit(state.copyWith(isLoading: true));
    final history = HistoryEntity(
      testType: testType,
      saved: DateTime.now(),
      correctAnswers: correctAnswers,
      totalAnswers: totalAnswers,
    );
    await saveHistoryUseCase(HistoryParams(history: history));
    loadHistory();
  }

  Future<void> deleteHistory() async {
    await deleteHistoryUseCase(NoParams());
    emit(state.copyWith(history: []));
  }
}
