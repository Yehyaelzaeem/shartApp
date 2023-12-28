import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'تفاصيل الباقة', hasBackButton: true),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'التفاصيل',
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
            Container(
              height: 85.h,
              margin: EdgeInsets.only(top: 16.h),
              decoration: BoxDecoration(
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r)),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 134.w,
                      height: 85.h,
                      decoration: BoxDecoration(color: packagesColor),
                      child: Image.asset(
                        'assets/images/reportcar.png',
                        height: 50.h,
                        width: 80.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 11.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'فحص شرط',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'ر.س 1000',
                        style: TextStyle(
                          fontWeight: FontWeightManager.regular,
                          fontSize: 16.sp,
                          color: Color(0xffDB3022),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: 28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'مدة الباقة',
                    style: TextStyle(fontSize: 14.sp, color: Color(0xff6E6D71)),
                  ),
                  Text('ابتداءا من 27 سبتمبر إلى 27 أكتوبر',
                      style: TextStyle(fontSize: 14.sp))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: 28.w),
              child: Row(
                children: <Widget>[
                  Text(
                    'عنوان الفحص',
                    style: TextStyle(fontSize: 14.sp, color: Color(0xff6E6D71)),
                  ),
                  SizedBox(width: 20.w),
                  Container(height: 18.h, width: 1, color: primaryColor)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: 28.w),
              child: Row(
                children: <Widget>[
                  Text(
                    'طريقة الدفع',
                    style: TextStyle(fontSize: 14.sp, color: Color(0xff6E6D71)),
                  ),
                  SizedBox(width: 20.w),
                  SvgPicture.asset('assets/icons/mastercard.svg'),
                  SizedBox(width: 15.w),
                  Text('3947 **** **** **** ',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: 28.w),
              child: Row(
                children: <Widget>[
                  Text(
                    'قيمة الطلب',
                    style: TextStyle(fontSize: 14.sp, color: Color(0xff6E6D71)),
                  ),
                  SizedBox(width: 28.w),
                  Text('300 ر.س', style: TextStyle(fontSize: 14.sp))
                ],
              ),
            ),
            Divider(
              height: 20.h,
              thickness: 1,
              color: greyColor,
            ),
            SizedBox(height: 16.h),
            Row(
              children: <Widget>[
                Text('إجمالى المطلوب',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
                SizedBox(width: 27.w),
                Text(
                  '300 ر.س',
                  style: TextStyle(fontSize: 14.sp, color: Color(0xffDB3022)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
