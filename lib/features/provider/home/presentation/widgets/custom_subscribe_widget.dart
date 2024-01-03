import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color.dart';

class CustomSubscribeWidget extends StatelessWidget {
  const CustomSubscribeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24.h, bottom: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width: MediaQuery.of(context).size.width*0.4,
      height: 163.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff136B79)),
      child:
      FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.h,),
            Text(
              'الأن تستطيع الإشتراك\n فى إحدى باقات شرط',
              style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  fontFamily: 'Cairo'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  minimumSize: Size(134.w, 36.h),
                ),
                onPressed: () {},
                child: Text(
                  'إشترك الأن',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontFamily: 'Lateef',
                      fontWeight: FontWeight.bold),
                )),

          ],
        ),
      ),
    );
  }
}
