// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  static const Color BASE_COLOR = Color(0xffFEBB1B);
  static const Color YELLOW_LIGHT = Color(0xffFFE6AC);
  static const Color GREEN_LIGHT = Color(0xffE8F7ED);

  static const Color WHITE = Color(0xffFFFFFF);
  static const Color WHITE2 = Color(0xffFAFAFA);
  static const Color WHITE3 = Color(0xffF3F3F3);
  static const Color WHITE4 = Color(0xffF5F5F5);

  static const Color TRANSPARENT = Color.fromARGB(0, 250, 250, 250);
  static const Color BLACK = Color.fromARGB(255, 0, 0, 0);

  static const Color BG_SCAFOLLD = Color(0xfff9fbfe);
  static const Color ICON_SELECTED = Color(0xff33555C);

  static const Color RED = Color(0xffE63E3A);
  static const Color NAVY_BLUE = Color(0xff0473C0);
  static const Color GREEN = Color(0xff4CAF50);
  static const Color YELLOW = Color(0xffFFCA3C);
  static const Color ORANGE = Color(0xffF3AD39);

  static const Color ICON_COLOR = Color(0xffb5bec8);

  static const Color GRAY = Color(0xffA7A7A7);
  static const Color GRAY2 = Color(0xff6C6C6C);

  static const Color GRAY3 = Color(0xff606E7D);
  static const Color ICON_PLUS = Color(0xff113260);

  static const Color TEXT_LIGHT = Color(0xffAEAEAE);

  static const Color BG_MESSAGE = Color(0xffBEDCF6);

  static const Color BORDER = Color(0xffDFE0DF);

  static const Color pink = Color(0xFFFF4550);
  static Color pink100 = pink.withOpacity(.1);
  static Color pink300 = pink.withOpacity(.3);
  static Color pink400 = pink.withOpacity(.4);

  static MaterialColor APP_THEME = const MaterialColor(
    0xffFEBB1B,
    <int, Color>{
      50: Color(0xFFEEE6D3),
      100: Color(0xFFEFDDB2),
      200: Color(0xFFEACD86),
      300: Color(0xFFE7BD5B),
      400: Color(0xFFE5B33C),
      500: Color(0xffd0a02d),
      600: Color(0xFFD09918),
      700: Color(0xFFB68613),
      800: Color(0xFFAB7E12),
      900: Color(0xFF8A640A),
    },
  );
}
