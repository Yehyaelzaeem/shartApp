import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../data/model/check_car_model.dart';

class ReportScreen extends StatelessWidget {
  final GetCheckCarsModelData getCheckCarsModelData;
  const ReportScreen({Key? key, required this.getCheckCarsModelData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit= AuthCubit.get(context);
    bool x =cubit.localeLanguage==Locale('en');
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: getLang(context, 'package_details'), hasBackButton: true),
        preferredSize: Size(double.infinity, 70.h),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              getLang(context, 'details'),
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
                        topRight: Radius.circular( x?0:10.r),
                        bottomRight: Radius.circular(x?0:10.r),
                        topLeft: Radius.circular( x?10:0.r),
                        bottomLeft: Radius.circular(x?10:0.r),
                    ),
                    child: Container(
                      // padding: const EdgeInsets.all(8.0),
                      width: 134.w,
                      height: 85.h,
                      decoration: BoxDecoration(color: packagesColor),
                      child: Image.network(
                        getCheckCarsModelData.package!.image!,
                        height: 50.h,
                        width: 80.w,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context,Object error,StackTrace? r){
                          return Center(child: Text('waiting....'));

                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 11.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        getCheckCarsModelData.package!.title!,
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${getCheckCarsModelData.package!.price!} ${getLang(context, 'rs')}',
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
            // Padding(
            //   padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: x?5:28.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Text(
            //         getLang(context, 'package_duration'),
            //         style: TextStyle(fontSize: 14.sp, color: Color(0xff6E6D71)),
            //       ),
            //       Text('ابتداءا من 27 سبتمبر إلى 27 أكتوبر',
            //           style: TextStyle(fontSize: 14.sp))
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: x?5:28.w),
            //   child: Row(
            //     children: <Widget>[
            //       Text(
            //         getLang(context, 'checked_address'),
            //         style: TextStyle(fontSize: 14.sp, color: Color(0xff6E6D71)),
            //       ),
            //       SizedBox(width: 20.w),
            //       Container(height: 18.h, width: 1, color: primaryColor)
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: x?5:28.w),
              child: Row(
                children: <Widget>[
                  Text(
                    getLang(context, 'payment_method'),
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
              padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: x?5:28.w),
              child: Row(
                children: <Widget>[
                  Text(
                    getLang(context, 'order_value'),
                    style: TextStyle(fontSize: 14.sp, color: Color(0xff6E6D71)),
                  ),
                  SizedBox(width: 28.w),
                  Text('${getCheckCarsModelData.package!.price!} ${getLang(context, 'rs')}', style: TextStyle(fontSize: 14.sp))
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
                Text(getLang(context, 'total_required'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
                SizedBox(width: 27.w),
                Text(
                  '${getCheckCarsModelData.package!.price!} ${getLang(context, 'rs')}',
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
