part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {
  const FetchUsers();
}

class ChangeSelectUser extends UserEvent {
  final User user;

  const ChangeSelectUser({required this.user});
}
