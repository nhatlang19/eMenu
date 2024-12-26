import 'package:emenu/constants/asset_path.dart';
import 'package:emenu/models/setting.dart';
import 'package:emenu/modules/auth/bloc/login_bloc.dart';
import 'package:emenu/modules/auth/widgets/exit_button.dart';
import 'package:emenu/modules/auth/widgets/login_button.dart';
import 'package:emenu/modules/auth/widgets/password_input.dart';
import 'package:emenu/modules/auth/widgets/username_input.dart';
import 'package:emenu/utils/global.dart';
import 'package:emenu/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
            await Global.setCashier(state.user);
            await Navigator.pushNamed(context, 'TablePage');
            context.read<LoginBloc>().add(const LogoutSubmitted());
          }
        },
        child: FutureBuilder<Setting>(
            future: _getSettings(),
            builder: (BuildContext context, AsyncSnapshot<Setting> snapshot) {
              if (snapshot.hasData) {
                Setting? setting = snapshot.data;
                if (setting != null) {
                  return _buildUI(setting);
                }
              }
              return _buildUI(Setting.empty);
            }));
  }

  Row _buildVersion() {
    var version = dotenv.env['VERSION'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Text('Version: $version'),
      ],
    );
  }

  Future<Setting> _getSettings() async {
    var settings = Settings();
    var setting = await settings.read();
    return setting;
  }

  Widget loadLogo(Setting setting) {
    if (setting.serverIP != '') {
      var pathLogo = Global.logoPath(setting.serverIP) + setting.logoName;
      return Image.network(
        pathLogo,
        height: 100,
      );
    }
    return Image.asset(
      AssetPath.loginLogo,
      height: 100,
    );
  }

  Widget _buildUI(Setting setting) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) => current.refreshLogo == true,
                    builder: (context, state) {
                      context.read<LoginBloc>().add(const RefreshLogo());
                      return Center(
                        child: loadLogo(state.setting),
                      );
                    },
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
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.username != current.username ||
                        previous.password != current.password,
                    builder: (context, state) {
                      if (state.username.displayError != null) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Invalid username",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20)),
                        );
                      } else if (state.password.displayError != null) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Invalid password",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20)),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
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
        ),
      ),
    );
  }
}
