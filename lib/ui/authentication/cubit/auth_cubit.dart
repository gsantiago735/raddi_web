import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:raddi_web/models/generic/wrapped.dart';
import 'package:raddi_web/models/generic/generic_enums.dart';
import 'package:raddi_web/providers/auth_local_provider.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  final _authLocalProvider = AuthLocalProvider();

  void setPasswordVisibility() =>
      emit(state.copyWith(isHiddenPass: !state.isHiddenPass));

  void setCPasswordVisibility() =>
      emit(state.copyWith(isHiddenCpass: !state.isHiddenCpass));

  void setRememberMe() => emit(state.copyWith(rememberMe: !state.rememberMe));

  // ==========================================================================
  // Login
  // ==========================================================================

  Future<void> login({required String email, required String password}) async {
    if (state.genericStatus == WidgetStatus.loading) return;
    emit(state.copyWith(genericStatus: WidgetStatus.loading));

    try {
      await _authLocalProvider.loginUser(email, password);
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(genericStatus: WidgetStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        genericStatus: WidgetStatus.error,
        exception: Wrapped.value(e.toString()),
      ));
    }
  }

  // ==========================================================================
  // Register
  // ==========================================================================

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (state.genericStatus == WidgetStatus.loading) return;
    emit(state.copyWith(genericStatus: WidgetStatus.loading));

    try {
      await _authLocalProvider.registerUser(email, password);
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(genericStatus: WidgetStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        genericStatus: WidgetStatus.error,
        exception: Wrapped.value(e.toString()),
      ));
    }
  }

  // ==========================================================================
  // Forgot Password
  // ==========================================================================

  Future<void> forgotPassword({required String email}) async {
    if (state.genericStatus == WidgetStatus.loading) return;
    emit(state.copyWith(genericStatus: WidgetStatus.loading));

    try {
      await _authLocalProvider.resetPassword(email);
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(genericStatus: WidgetStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        genericStatus: WidgetStatus.error,
        exception: Wrapped.value(e.toString()),
      ));
    }
  }
}
