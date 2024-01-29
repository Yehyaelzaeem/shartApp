import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../../../core/resources/color.dart';
import '../../../../../shared_screens/pachages/custom_packages_screen.dart';
import '../../logic/provider_home_cubit.dart';
import '../screens/packages/packages_screen.dart';

class CustomSubscribeWidgetRow extends StatelessWidget {
  const CustomSubscribeWidgetRow({super.key, this.height, this.width});
   final double? height;
   final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24.h, bottom: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width:width?? ScreenUtil().screenWidth - 50,
      height:height?? 110.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff136B79)),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40.h,),
          Container(
            height: 40.h,
            width: MediaQuery.of(context).size.width*0.4,
            child: FittedBox(
              child: Text(
                '${getLang(context, 'subscription_message')}',
                style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    fontFamily: 'Cairo'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          Container(
            width: MediaQuery.of(context).size.width*0.3,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  minimumSize: Size(134.w, 36.h),
                ),
                onPressed: () {
                  ProviderHomeCubit.get(context).getPackages(context);
                  Navigator.push(context, MaterialPageRoute(builder:
                      (BuildContext context)=>ProviderPackagesScreen(
                        isHistory: false,
                      )));
                },
                child: Text(
                  '${getLang(context, 'subscription_now')}',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontFamily: 'Lateef',
                      fontWeight: FontWeight.bold),
                )),
          ),
          SizedBox(height: 20.h,),
        ],
      ),
    );
  }
}
