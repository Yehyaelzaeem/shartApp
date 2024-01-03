import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';

class CustomOrderWithInvoiceAndReportWidget extends StatelessWidget {
  const CustomOrderWithInvoiceAndReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        NavigationManager.push(Routes.orderDetails);
      },
      child: Container(
        height: 135.h,
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
                height: 130.h,
                decoration: BoxDecoration(color: packagesColor),
                child: Image.asset(
                  ImagesManager.fixCar1,
                  fit: BoxFit.fill,
                  height: 130.h,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 8.w),
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
                      '${'rs'} 1000',
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
            SizedBox(width: 9.w),
            Container(
              margin: EdgeInsets.only(top: 16.h),
              child: FittedBox(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        NavigationManager.push(Routes.report);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.info_outline,
                              size: 15, color: Colors.grey.shade400),
                          SizedBox(width: 2),
                          FittedBox(
                            child: Text('مشاهدة تقرير \nالفحص',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10)),
                          ),
                        ],
                      ),
                    ),

                    Container(
                        width: 80.w,
                        height: 1,
                        color: Colors.black,
                        margin: EdgeInsets.only(top: 5, bottom: 15)),

                    InkWell(
                      onTap: () {
                        NavigationManager.push(Routes.invoice);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.remove_red_eye_rounded,
                              size: 15, color: Colors.grey.shade400),
                          SizedBox(width: 1),
                          Text('مشاهدة الفاتورة', style: TextStyle(fontSize: 9)),
                        ],
                      ),
                    ),                  Container(
                        width: 80.w,
                        height: 1,
                        color: Colors.black,
                        margin: EdgeInsets.only(top: 5, bottom: 15)),
                    Container(
                      height:24.h ,
                      width:87.w ,
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Color(0xff136B79),
                      ),
                      child: Center(
                        child: Text(
                          'تم الفحص',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h,)
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
