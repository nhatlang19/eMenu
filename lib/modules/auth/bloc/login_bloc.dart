import 'package:bloc/bloc.dart';
import 'package:emenu/models/user.dart';
import 'package:emenu/modules/auth/models/password.dart';
import 'package:emenu/modules/auth/models/username.dart';
import 'package:emenu/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginConfirmed>(_onLoginConfirmed);
    on<LogoutSubmitted>(_onLogout);
  }

  final AuthRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([state.password, username]),
        status: FormzSubmissionStatus.initial
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username]),
        status: FormzSubmissionStatus.initial
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        User user = await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        // User user = User.empty;
        emit(state.copyWith(status: FormzSubmissionStatus.success, user: user));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  Future<void> _onLoginConfirmed(
    LoginConfirmed event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(confirmStatus: ConfirmStatus.initial));
      try {
        User user = await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        // User user = User.empty;
        emit(state.copyWith(confirmStatus: ConfirmStatus.success));
      } catch (_) {
        emit(state.copyWith(confirmStatus: ConfirmStatus.failure));
        emit(state.copyWith(confirmStatus: ConfirmStatus.initial));
      }
    }
  }

  

  void _onLogout(LogoutSubmitted event, Emitter<LoginState> emit) {
    _authenticationRepository.logOut();
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }
}