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

  static String getCurrentDate(String format) {
		DateTime now = DateTime.now();
    DateFormat formatter = DateFormat(format);
    String formattedDate = formatter.format(now);
    return formattedDate;
	}

  static String convertDoubleToInt(String doubleString) {
    double doubleValue = double.parse(doubleString);  // Convert to double
    int intValue = doubleValue.toInt();  // Convert to int
    String intString = intValue.toString();  // Convert back to string

    return intString;
  }
}