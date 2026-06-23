import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/core/usecases/usecase.dart';
import 'package:quiz_app/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:quiz_app/features/auth/presentation/cubit/state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._checkAuthUseCase) : super(const AuthState());
  final CheckAuthUseCase _checkAuthUseCase;

  Future<void> checkAuth() async {
    final result = await _checkAuthUseCase(NoParams());

    result.fold(
      (l) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      },
      (r) {
        emit(
          state.copyWith(
            status: r ? AuthStatus.authenticated : AuthStatus.unauthenticated,
          ),
        );
      },
    );
  }

  Future<void> disableAuth() async {
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }
}
