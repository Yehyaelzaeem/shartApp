import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../shared_screens/pachages/custom_packages_screen.dart';
import '../../logic/provider_home_cubit.dart';
import '../screens/packages/packages_screen.dart';

class CustomCompleteWidgetRow extends StatelessWidget {
  const CustomCompleteWidgetRow({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24.h, bottom: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width:width?? ScreenUtil().screenWidth - 50,
      // height:height?? 200.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        color: primaryColor,),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 120.h,
              width: 120.w,
              child: Image.asset('assets/images/fixCarProvider.png',
              )),
          Spacer(),
          Column(children: <Widget>[
            Text(
              '${getLang(context, 'complete_message')}',
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeightManager.bold,
                  fontFamily: 'Cairo'),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5.h,),
            Container(
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
                    style:  TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontFamily: 'Lateef',
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
          ],)

        ],
      ),
    );
  }
}
