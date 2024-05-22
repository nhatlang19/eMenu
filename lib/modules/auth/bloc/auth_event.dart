part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class _AuthenticationStatusChanged extends AuthEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

final class AuthenticationLogoutRequested extends AuthEvent {}