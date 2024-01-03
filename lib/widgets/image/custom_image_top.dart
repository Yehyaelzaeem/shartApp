import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageTop extends StatelessWidget {
  const CustomImageTop({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 54.h, bottom: 24.h),
      child: Image.asset(
        image,
        width: 220.sp,
        height: 220.sp,
      ),
    );
  }
}
