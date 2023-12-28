import 'package:flutter/cupertino.dart';

extension CurrentLang on BuildContext {
  // bool get isCurrentEnglish => locale == const Locale('en');
  // bool get isCurrentArabic => locale == const Locale('ar');
}


extension ToColorFilter on Color {
  ColorFilter? get toColorFilter {
    return ColorFilter.mode(this, BlendMode.srcIn);
  }
}
