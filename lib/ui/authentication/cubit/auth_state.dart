part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.genericStatus = WidgetStatus.initial,
    //this.exception,
    //this.stateSelected,
    this.isHiddenPass = true,
    this.rememberMe = false,
  });

  // General
  //final DataException? exception;
  final WidgetStatus genericStatus;
  //final LoginResponseModel? responseRegister;

  final bool isHiddenPass;
  final bool rememberMe;

  @override
  List<Object?> get props => [
        genericStatus,
        isHiddenPass,
        rememberMe,
      ];

  AuthState copyWith({
    WidgetStatus? genericStatus,
    bool? isHiddenPass,
    bool? rememberMe,
    // Wrapped<TerritorialStateModel?>? stateSelected,
  }) {
    return AuthState(
      genericStatus: genericStatus ?? this.genericStatus,
      isHiddenPass: isHiddenPass ?? this.isHiddenPass,
      rememberMe: rememberMe ?? this.rememberMe,
      // stateSelected:
      //     (stateSelected != null) ? stateSelected.value : this.stateSelected,
    );
  }
}
