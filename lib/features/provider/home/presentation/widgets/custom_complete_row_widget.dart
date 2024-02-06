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
      Column(
        children: [
          SizedBox(height: 20.h,),
          Container(
              height: 120.h,
              width: ScreenUtil().screenWidth - 50,
              child: Image.asset('assets/images/fixCarProvider.png',
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40.h,),
              Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width*0.4,
                child: FittedBox(
                  child:  Text(
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
              SizedBox(height: 20.h,),
              Container(
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
                    child: FittedBox(
                      child: Text(
                        '${getLang(context, 'complete')}',
                        style:  TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontFamily: 'Lateef',
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
              ),
              SizedBox(height: 20.h,),
            ],
          ),
          SizedBox(height: 20.h,)
        ],
      ),
    );
  }
}
