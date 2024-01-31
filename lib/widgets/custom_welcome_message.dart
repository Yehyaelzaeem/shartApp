import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/localization/appLocale.dart';
import '../core/resources/font_manager.dart';

class CustomWelcomeMessage extends StatelessWidget {
  const CustomWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16.w, right: 16.w, bottom: 4.h, top: 12.h),
      child: Text(
        getLang(context, 'welcome_message'),
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeightManager.bold,
          fontFamily: FontConstants.lateefFont,
        ),
      ),
    );
  }
}
