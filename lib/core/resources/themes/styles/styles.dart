
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../color.dart';
import '../../font_manager.dart';

class TextStyles{

  static TextStyle font15BlueColor500WeightTajawal =  TextStyle(
      color: blueColor,
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      fontFamily:FontConstants.Tajawal
  );
  static TextStyle font16GeryColor400WeightLateefFont =  TextStyle(
      fontSize: 16,
      fontFamily: FontConstants.lateefFont,
      fontWeight: FontWeight.w400,
      color: textGeryColor
  );
  static TextStyle font16BlackColor500WeightTajawal =  TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: FontConstants.Tajawal,
      fontSize: 16,
      color: blackTextColor
  );
  static TextStyle font16GeryColor400WeightTajawal =  TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: FontConstants.Tajawal,
      fontSize: 14,
      color: textGeryColor
  );
  static TextStyle font12BlackColor700WeightTajawal =  TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: FontConstants.Tajawal,
      fontSize: 12,
      color: blackTextColor

  );


}