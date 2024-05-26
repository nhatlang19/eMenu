import 'package:flutter/material.dart';

class ScreenUtil {
  static bool isPortrait(context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }
}