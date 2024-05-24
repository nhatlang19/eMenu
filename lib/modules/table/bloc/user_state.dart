part of 'user_bloc.dart';

enum UserStatus { initial, success, failure, changed }

final class UserState extends Equatable {
  const UserState({
    this.status = UserStatus.initial,
    this.users = const <User>[],
    this.selectedUser = User.empty,
  });

  final UserStatus status;
  final List<User> users;
  final User selectedUser;

  UserState copyWith({
    UserStatus? status,
    List<User>? users,
    User? selectedUser
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      selectedUser: selectedUser ?? this.selectedUser,
    );
  }
  @override
  List<Object> get props => [status, users, selectedUser];
}
