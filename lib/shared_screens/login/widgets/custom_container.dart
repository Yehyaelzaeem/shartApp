import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/color.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return   Container(
        margin: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          border: Border.all(color: greyColor),
        ),
        padding: EdgeInsets.all(16.sp),
        child:
        widget
    );
  }
}
