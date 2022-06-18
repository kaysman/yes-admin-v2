enum LoginStatus { idle, loading, error, success }

class LoginState {
  final LoginStatus? status;

  LoginState({
    this.status = LoginStatus.idle,
  });

  LoginState copyWith({
    LoginStatus? status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }
}
