import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/routes.dart';

class SparePartsScreen extends StatefulWidget {
  const SparePartsScreen({Key? key}) : super(key: key);

  @override
  State<SparePartsScreen> createState() => _SparePartsScreenState();
}

class _SparePartsScreenState extends State<SparePartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: 'قطع غيار',hasBackButton: true),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => NavigationManager.push(Routes.sparePartsDetails),
              child: Container(
                margin: EdgeInsets.all(16.w),
                width: double.infinity,
                height: 103.h,
                decoration: BoxDecoration(
                  color: tireColor1,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      ImagesManager.tire2,
                      width: 95.w,
                      height: 75.h,
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      'قطع الغيار',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeightManager.light,
                        fontFamily: FontConstants.lateefFont,
                      ),
                    ),
                    SizedBox(width: 15.w),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => NavigationManager.push(Routes.tiresTypes),
              child: Container(
                margin: EdgeInsets.all(16.w),
                width: double.infinity,
                height: 103.h,
                decoration: BoxDecoration(
                  color: tireColor2.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      ImagesManager.tire1,
                      width: 95.w,
                      height: 75.h,
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      'الإطارات',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeightManager.light,
                        fontFamily: FontConstants.lateefFont,
                      ),
                    ),
                    SizedBox(width: 15.w),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => NavigationManager.push(Routes.carSupplies),
              child: Container(
                margin: EdgeInsets.all(16.w),
                width: double.infinity,
                height: 103.h,
                decoration: BoxDecoration(
                  color: tireColor3,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      ImagesManager.oil2,
                      width: 95.w,
                      height: 75.h,
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      'مستلزمات',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeightManager.light,
                        fontFamily: FontConstants.lateefFont,
                      ),
                    ),
                    SizedBox(width: 15.w),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
