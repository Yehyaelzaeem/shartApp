import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/extensions/context_extension.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';

InkWell buildCurrentOrder(BuildContext context) {
  return InkWell(
    onTap: () {
      NavigationManager.push(Routes.orderDetails);
    },
    child: Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 134.w,
                  height: 115.h,
                  decoration: BoxDecoration(color: packagesColor),
                  child: Image.asset(
                    ImagesManager.fixCar1,
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
                    'أسم الماركة',
                    style: TextStyle(
                      fontWeight: FontWeightManager.light,
                      fontSize: 12.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    'أسم المنتج',
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    'أسم المتجر',
                    style: TextStyle(
                      fontWeight: FontWeightManager.regular,
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
              SizedBox(width: 11.w),
              Card(
                margin: EdgeInsets.zero,
                color: primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 5),
                  child: Text(
                    ' ${getLang(context, 'current')}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    ),
  );
}

InkWell buildOrderWithInvoice(context) {
  return InkWell(
    onTap: () {
      NavigationManager.push(Routes.orderDetails);
    },
    child: Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 134.w,
                  height: 115.h,
                  decoration: BoxDecoration(color: packagesColor),
                  child: Image.asset(
                    ImagesManager.fixCar1,
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
                    'أسم الماركة',
                    style: TextStyle(
                      fontWeight: FontWeightManager.light,
                      fontSize: 12.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    'أسم المنتج',
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    'أسم المتجر',
                    style: TextStyle(
                      fontWeight: FontWeightManager.regular,
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
              SizedBox(width: 11.w),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      NavigationManager.push(Routes.invoice);
                    },
                    child: Text('${getLang(context, 'view_invoice')}',
                        style: TextStyle(fontSize: 12)),
                  ),
                  Container(
                      width: 80.w,
                      height: 1,
                      color: Colors.black,
                      margin: EdgeInsets.only(top: 5, bottom: 30)),
                  Card(
                    margin: EdgeInsets.zero,
                    color: Color(0xff136B79),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8,top: 5),
                      child: Center(
                        child: Text(
                          '${getLang(context, 'delivered')}',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Positioned(
          //   child: Container(
          //     margin: EdgeInsets.only(left: 10.w, right: 16.w, top: 50.h),
          //     child:
          //     Column(
          //       children: <Widget>[
          //         InkWell(
          //           onTap: () {
          //             NavigationManager.push(Routes.invoice);
          //           },
          //           child: Text('مشاهدة الفاتورة',
          //               style: TextStyle(fontSize: 12)),
          //         ),
          //         Container(
          //             width: 80.w,
          //             height: 1,
          //             color: Colors.black,
          //             margin: EdgeInsets.only(top: 5, bottom: 30)),
          //         Card(
          //           margin: EdgeInsets.zero,
          //           color: Color(0xff136B79),
          //           elevation: 0,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(50.r)),
          //           child: Padding(
          //             padding: const EdgeInsets.only(left: 8,right: 8),
          //             child: Text(
          //               'تم التوصيل',
          //               style: TextStyle(
          //                 color: whiteColor,
          //                 fontSize: 12.sp,
          //                 fontWeight: FontWeightManager.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   left: 0,
          //   bottom: 15,
          // )
        ],
      ),
    ),
  );
}

InkWell buildCancelledOrder(context) {
  return InkWell(
    onTap: () {
      NavigationManager.push(Routes.orderDetails);
    },
    child: Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 134.w,
                  height: 115.h,
                  decoration: BoxDecoration(color: packagesColor),
                  child: Image.asset(
                    ImagesManager.fixCar1,
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
                    'أسم الماركة',
                    style: TextStyle(
                      fontWeight: FontWeightManager.light,
                      fontSize: 12.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    'أسم المنتج',
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    'أسم المتجر',
                    style: TextStyle(
                      fontWeight: FontWeightManager.regular,
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
              SizedBox(width: 11.w),
              Card(
                margin: EdgeInsets.zero,
                color: Color(0xffFF0000),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 5),
                  child: Text(
                    '${getLang(context, 'canceled')}',
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}