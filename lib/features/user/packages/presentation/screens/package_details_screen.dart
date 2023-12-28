import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/font_manager.dart';

class UserPackageDetailsScreen extends StatefulWidget {
  const UserPackageDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserPackageDetailsScreen> createState() =>
      _UserPackageDetailsScreenState();
}

class _UserPackageDetailsScreenState extends State<UserPackageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(title: 'تفاصيل الباقة', hasBackButton: true),
          preferredSize: Size(double.infinity, 80.h)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              getLang(context, 'التفاصيل'),),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                ImagesManager.car2,
                width: 134.w,
                height: 75.h,
              ),
              SizedBox(width: 11.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      getLang(context,'فحص شرط'),
                      style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    '${getLang(context, 'rs')} 1000',
                    style: TextStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: 16.sp,
                      color: Colors.red,
                    ),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  getLang(context, 'مدة الباقة'),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.regular,
                    color: highGreyColor,
                  ),
                ),
                Text(
                  getLang(context, 'ابتداءا من 27 سبتمبر إلى 27 أكتوبر'),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.regular,
                    color: blackColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  getLang(context, 'طريقة الدفع'),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.regular,
                    color: highGreyColor,
                  ),
                ),
                Text(
                  'Visa ***99 99 99944 ',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.regular,
                    color: blackColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  getLang(context, 'قيمة الطلب'),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.regular,
                    color: highGreyColor,
                  ),
                ),
                Text(
                  '300 ${ getLang(context, 'rs')}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.regular,
                    color: blackColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20.h,
            thickness: 1,
            color: blackColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  getLang(context, 'إجمالي المطلوب'),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                Text(
                  '300 ${getLang(context, 'rs')}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.bold,
                    color: redColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
