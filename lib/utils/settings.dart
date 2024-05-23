import 'dart:convert';
import 'dart:io';

import 'package:emenu/models/setting.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/settings.txt');
  }

  Future<void> write(Setting setting) async {
    // final file = await _localFile;

    // String content = jsonEncode(setting.toJson());

    // Write the file
    // return file.writeAsString('$content');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String json = jsonEncode(setting.toJson());
    prefs.setString('setting', json);
  }

  Future<Setting> read() async {
    // try {
    //   final file = await _localFile;

    //   // Read the file
    //   final contents = await file.readAsString();

    //   return Setting.fromJson(jsonDecode(contents!) as Map<String, dynamic>);
    // } catch (e) {
    //   // If encountering an error, return 0
    //   return null;
    // }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? json = prefs.getString('setting');
    if (json != null) {
      return Setting.fromJson(jsonDecode(json) as Map<String, dynamic>);
    }

    return Setting.empty;
  }
}
