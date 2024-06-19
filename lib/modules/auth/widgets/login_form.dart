import 'package:emenu/constants/asset_path.dart';
import 'package:emenu/modules/auth/bloc/login_bloc.dart';
import 'package:emenu/modules/auth/widgets/exit_button.dart';
import 'package:emenu/modules/auth/widgets/login_button.dart';
import 'package:emenu/modules/auth/widgets/password_input.dart';
import 'package:emenu/modules/auth/widgets/username_input.dart';
import 'package:emenu/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          }

          if (state.status.isSuccess) {
            Global.setCashier(state.user);
            await Navigator.pushNamed(context, 'TablePage');
            context.read<LoginBloc>().add(const LogoutSubmitted());
          }
        },
        child: _buildUI());
  }

  Row _buildVersion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'SettingPage');
          },
          child: const Text('Settings'),
        ),
        const Text('Version: 0.1.0'),
      ],
    );
  }

  Widget _buildUI() {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  AssetPath.loginLogo,
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: UsernameInput()),
                  const SizedBox(width: 20),
                  Expanded(child: PasswordInput()),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: ExitButton()),
                  const SizedBox(width: 20),
                  Expanded(child: LoginButton()),
                ],
              ),
              _buildVersion()
            ],
          ),
        ),
      ),
    );
  }
}
