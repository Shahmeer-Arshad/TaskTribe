// lib/logic/blocs/auth/auth_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
    on<CheckAuthStatus>(_onCheckAuth);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthFailure('Login failed.'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRegister(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUp(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthFailure('Registration failed.'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    emit(Unauthenticated());
  }

  Future<void> _onCheckAuth(CheckAuthStatus event, Emitter<AuthState> emit) async {
    final user = authRepository.getCurrentUser();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }
}
