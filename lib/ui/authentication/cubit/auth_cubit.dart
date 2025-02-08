import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/models/generic/generic_enums.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void setPasswordVisibility() =>
      emit(state.copyWith(isHiddenPass: !state.isHiddenPass));

  void setRememberMe() => emit(state.copyWith(rememberMe: !state.rememberMe));

  // ==========================================================================
  // Login
  // ==========================================================================

  Future<void> login() async {
    if (state.genericStatus == WidgetStatus.loading) return;
    emit(state.copyWith(genericStatus: WidgetStatus.loading));

    await Future.delayed(Duration(seconds: 2));

    emit(state.copyWith(genericStatus: WidgetStatus.success));
  }

  // ==========================================================================
  // Register
  // ==========================================================================

  Future<void> register() async {
    if (state.genericStatus == WidgetStatus.loading) return;
    emit(state.copyWith(genericStatus: WidgetStatus.loading));

    await Future.delayed(Duration(seconds: 2));

    emit(state.copyWith(genericStatus: WidgetStatus.success));
  }

  // ==========================================================================
  // Forgot Password
  // ==========================================================================

  Future<void> forgotPassword() async {
    if (state.genericStatus == WidgetStatus.loading) return;
    emit(state.copyWith(genericStatus: WidgetStatus.loading));

    await Future.delayed(Duration(seconds: 2));

    emit(state.copyWith(genericStatus: WidgetStatus.success));
  }
}
