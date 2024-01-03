import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';

class CustomCompletePaperWidget extends StatelessWidget {
  const CustomCompletePaperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width*0.4,
      height: 163.h,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: primaryColor.withOpacity(0.8),
                blurRadius: 2,
                spreadRadius: 5)
          ]),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/fixCarProvider.png'),
            Text(
              'لإكمال تفعيل الحساب\n يجب رفع باقى الأوراق',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeightManager.bold,
                  fontFamily: 'Cairo'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff136B79),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  minimumSize: Size(134.w, 36.h),
                ),
                onPressed: () {
                  NavigationManager.push(Routes.providerCompleteRenterData);
                },
                child: Text(
                  'إكمال',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontFamily: 'Lateef',
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
