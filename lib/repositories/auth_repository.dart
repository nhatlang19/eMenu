import 'dart:async';

import 'package:emenu/providers/user_provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<User> logIn({
    required String username,
    required String password,
  }) async {
    final userProvider = UserProvider(
      serviceUrl: dotenv.get('SERVICE_URL'),
    );

    var jsonUser = await userProvider.loginAction(username, password);
    if (jsonUser == null) {
        throw Exception("Something wrongs!!!");
    }

    _controller.add(AuthenticationStatus.authenticated);
    return User.fromJson(jsonUser);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
