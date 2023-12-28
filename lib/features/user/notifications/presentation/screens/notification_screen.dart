import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/widgets/custom_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'الإشعارات',hasBackButton: true),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 16.h,right: 16.w,left: 16.w),
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xffDCDCDC))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset(IconsManager.notificationDone),
                SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'أستلم التاجر الطلب الخاص بك وسيتواصل معك قريبا',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'منذ 3 دقائق',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xff818181),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: 10,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 24.h),
      ),
    );
  }
}
