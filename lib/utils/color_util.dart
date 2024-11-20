import 'package:flutter/material.dart';

class ColorUtil {
   static Color parseColor(String colorDelphi, {double alpha = 1.0}) {
		int rgbDelphi = int.parse(colorDelphi);

		int R = (rgbDelphi % 256);
		int G = (( rgbDelphi / 256) % 256).toInt();
		int B = (( rgbDelphi / 256 / 256) % 256).toInt();

		return Color.fromRGBO(R, G, B, alpha);
	}
}