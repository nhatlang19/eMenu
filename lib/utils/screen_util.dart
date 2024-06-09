import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScreenUtil {
  static bool isPortrait(context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static String formatPrice(dynamic amount) {
    if (amount is String) {
      amount = double.parse(amount);
    }
    return NumberFormat.currency(locale: 'en_US', symbol: '', decimalDigits: 0).format(amount);
  }
}