import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resources/font_manager.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 32.sp,
            fontFamily: FontConstants.lateefFont,
            fontWeight: FontWeightManager.bold,
          ),
        ),
      ),
    );
  }
}
