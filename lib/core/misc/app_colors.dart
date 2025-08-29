import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xfff2f0ed);
  static const Color purple = Color(0xFF3c0680);
  static const Color grey = Color(0xFF726b7b);
  static const Color darkPurple = Color(0xFF39077C);
  static const Color lightGrey = Color(0xFFD9D8DC);

  static const MaterialColor purpleSwatch = MaterialColor(
    0xFF3c0680, // base purple
    <int, Color>{
      50: Color(0xFFF2ECF8),
      100: Color(0xFFE0D1F0),
      200: Color(0xFFCCB5E8),
      300: Color(0xFFB398DE),
      400: Color(0xFF9B7CD5),
      500: purple, // main
      600: Color(0xFF644B8A),
      700: Color(0xFF57417A),
      800: Color(0xFF49386A),
      900: Color(0xFF362853),
    },
  );
}
