import 'package:bloc/bloc.dart';
import 'package:emenu/models/user.dart';
import 'package:emenu/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(
      {required UserRepository userRepository,
})
      : _userRepository = userRepository,
        super(const UserState()) {
    on<FetchUsers>(_onFetchUsers);
    on<ChangeSelectUser>(_onChange);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      if (state.status == UserStatus.initial) {
        List<User> users = await _userRepository.getUserList();
        emit(state.copyWith(users: users, status: UserStatus.success, selectedUser: users[1]));
      }
    } catch (_) {
      emit(state.copyWith(status: UserStatus.failure));
    }
  }

  void _onChange(ChangeSelectUser event, Emitter<UserState> emit) {
    emit(state.copyWith(selectedUser: event.user, status: UserStatus.changed));
  }
}
