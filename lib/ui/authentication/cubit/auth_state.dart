part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.exception,
    this.genericStatus = WidgetStatus.initial,
    this.isHiddenPass = true,
    this.isHiddenCpass = true,
    this.rememberMe = false,
  });

  // General
  final String? exception;
  final WidgetStatus genericStatus;

  final bool isHiddenPass;
  final bool isHiddenCpass;
  final bool rememberMe;

  @override
  List<Object?> get props => [
        exception,
        genericStatus,
        isHiddenPass,
        isHiddenCpass,
        rememberMe,
      ];

  AuthState copyWith({
    Wrapped<String?>? exception,
    WidgetStatus? genericStatus,
    bool? isHiddenPass,
    bool? isHiddenCpass,
    bool? rememberMe,
  }) {
    return AuthState(
      exception: (exception != null) ? exception.value : this.exception,
      genericStatus: genericStatus ?? this.genericStatus,
      isHiddenPass: isHiddenPass ?? this.isHiddenPass,
      isHiddenCpass: isHiddenCpass ?? this.isHiddenCpass,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
