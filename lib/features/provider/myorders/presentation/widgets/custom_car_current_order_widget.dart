import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';

class CustomCarCurrentOrderWidget extends StatelessWidget {
  const CustomCarCurrentOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
        NavigationManager.push(Routes.orderDetails);
      },
      child: Container(
        height: 80.h,
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
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
                decoration: BoxDecoration(color: packagesColor),
                child: Image.asset(
                  ImagesManager.fixCar1,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 88.w,
              child: FittedBox(
                child: Column(
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
                      '${'rs'} 300',
                      style: TextStyle(
                        fontWeight: FontWeightManager.regular,
                        fontSize: 16.sp,
                        color: Color(0xffDB3022),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 35.w),
            Container(
              width: 63.w,
              height: 30.h,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(50.r)
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    '    ${'حالي'}    ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
