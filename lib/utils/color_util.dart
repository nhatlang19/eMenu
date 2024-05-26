import 'package:flutter/material.dart';

class ColorUtil {
   static Color parseColor(String colorDelphi, {double alpha = 1.0}) {
		int RGB_Delphi = int.parse(colorDelphi);

		int R = (RGB_Delphi % 256);
		int G = (( RGB_Delphi / 256) % 256).toInt();
		int B = (( RGB_Delphi / 256 / 256) % 256).toInt();

		return Color.fromRGBO(R, G, B, alpha);
	}
}