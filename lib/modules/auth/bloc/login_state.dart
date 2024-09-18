part of 'login_bloc.dart';


enum ConfirmStatus { initial, success, failure }

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.user = User.empty,
    this.isValid = false,
    this.confirmStatus = ConfirmStatus.initial
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final User user;
  final bool isValid;
  final ConfirmStatus confirmStatus;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    User? user,
    bool? isValid,
    ConfirmStatus? confirmStatus,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      user: user ?? this.user,
      isValid: isValid ?? this.isValid,
      confirmStatus: confirmStatus ?? this.confirmStatus,
    );
  }

  @override
  List<Object> get props => [status, username, password, confirmStatus];
}