import 'package:flutter/material.dart';

import '../color.dart';

class Palette {
  static MaterialColor kToDark = MaterialColor(
     primaryColor.value,
    <int, Color>{
      50: primaryColor.withOpacity(0.1), //10%
      100: primaryColor.withOpacity(0.2), //20%
      200: primaryColor.withOpacity(0.3), //30%
      300: primaryColor.withOpacity(0.4), //40%
      400: primaryColor.withOpacity(0.5), //50%
      500: primaryColor.withOpacity(0.6), //60%
      600: primaryColor.withOpacity(0.7), //70%
      700: primaryColor.withOpacity(0.8), //80%
      800: primaryColor.withOpacity(0.9), //90%
      900: primaryColor, //100%
    },
  );
}
