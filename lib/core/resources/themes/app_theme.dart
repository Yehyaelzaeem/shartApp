import 'package:flutter/material.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/resources/themes/palette.dart';

import '../color.dart';

class AppThemes {
  static ThemeData whiteTheme = ThemeData(
    dividerTheme: const DividerThemeData(color: Colors.transparent),
    fontFamily: FontConstants.fontFamily,
    scaffoldBackgroundColor: whiteColor,
    primaryColor: primaryColor,
    splashColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(textStyle: TextStyle())),
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Palette.kToDark,
    )
        .copyWith(background: whiteColor)
        .copyWith(background: whiteColor)
        .copyWith(background: whiteColor),
  );
}
