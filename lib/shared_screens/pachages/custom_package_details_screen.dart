import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/resources/assets_menager.dart';
import '../../core/resources/color.dart';
import '../../core/resources/font_manager.dart';
import '../../widgets/custom_app_bar.dart';

class CustomPackageDetailsScreen extends StatelessWidget {
  const CustomPackageDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(title: 'تفاصيل الباقة', hasBackButton: true),
          preferredSize: Size(double.infinity, 80.h)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('التفاصيل'),
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
                    'فحص شرط',
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    'ر.س1000',
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
                  'مدة الباقة',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.regular,
                    color: highGreyColor,
                  ),
                ),
                Text(
                  'ابتداءا من 27 سبتمبر إلى 27 أكتوبر',
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
                  'طريقة الدفع',
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
                  'قيمة الطلب',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.regular,
                    color: highGreyColor,
                  ),
                ),
                Text(
                  '300 ر.س',
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
                  'إجمالي المطلوب',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                Text(
                  '300 ر.س',
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
