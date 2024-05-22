part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.user = User.empty,
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final User user;
  final bool isValid;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    User? user,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      user: user ?? this.user,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}