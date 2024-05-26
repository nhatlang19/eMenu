import 'package:emenu/modules/auth/bloc/login_bloc.dart';
import 'package:emenu/modules/auth/widgets/login_form.dart';
import 'package:emenu/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final AuthRepository _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthRepository();
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationRepository.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocProvider(
              create: (context) {
                return LoginBloc(
                  authenticationRepository: 
                      RepositoryProvider.of<AuthRepository>(context),
                );
              },
              child: const LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}


