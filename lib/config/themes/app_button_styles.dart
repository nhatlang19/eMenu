import 'package:flutter/material.dart';

class AppButtonStyles {
  static var btnSaveEnabled = ButtonStyle();
  static var btnSaveDisabled = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.grey),
  );
}