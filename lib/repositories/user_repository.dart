import 'package:emenu/providers/user_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(cashierID: const Uuid().v4(), cashierName: '', cashierPwd: '', userGroup: ''),
    );
  }

  Future<List<User>> getUserList() async {
    final provider = UserProvider();

    var json = await provider.getUserList();

    final List<User> result = [];
    json.forEach((data) {
      result.add(User.fromJson(data['Table'] as Map<String, dynamic>));
    });
     
    return result;
  }
}