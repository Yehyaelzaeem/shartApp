import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextTitleBookingWidget extends StatelessWidget {
  const CustomTextTitleBookingWidget({super.key, required this.text, required this.topPadding});
final String text;
final int topPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding.h,left: 5.w,bottom: 5.h),
      child: Text(text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
