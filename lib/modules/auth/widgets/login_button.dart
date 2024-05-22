import 'package:emenu/modules/auth/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';


class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.isValid
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: !state.status.isInProgress ? const Text('Login') : const Text('Waiting'),
              );
      },
    );
  }
}