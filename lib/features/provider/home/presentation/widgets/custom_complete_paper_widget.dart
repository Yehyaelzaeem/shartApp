import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';

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
      // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 80.h,
                child: Image.asset('assets/images/fixCarProvider.png')),
            Container(
              height: 30.h,
              width: MediaQuery.of(context).size.width*0.4,
              child: FittedBox(
                child: Text(
                  '${getLang(context, 'complete_message')}',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeightManager.bold,
                      fontFamily: 'Cairo'),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
             SizedBox(height: 10.h),
            Container(
              height: 25.h,
              width: MediaQuery.of(context).size.width*0.3,
              child: ElevatedButton(
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
                    '${getLang(context, 'complete')}',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontFamily: 'Lateef',
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],

      ),
    );
  }
}
