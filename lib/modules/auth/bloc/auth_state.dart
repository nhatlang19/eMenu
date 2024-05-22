part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}