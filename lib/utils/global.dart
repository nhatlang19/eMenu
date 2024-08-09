import 'dart:convert';

import 'package:emenu/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static Future<void> setCashier(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String json = jsonEncode(user.toJson());
    prefs.setString('cashier', json);
  }

  static Future<User> getCashier() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? json = prefs.getString('cashier');
    if (json != null) {
      return User.fromJson(jsonDecode(json) as Map<String, dynamic>);
    }
    return User.empty; 
  }
}