import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/resources/color.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';

class UserPackagesScreen extends StatefulWidget {
  const UserPackagesScreen({Key? key}) : super(key: key);

  @override
  State<UserPackagesScreen> createState() =>
      _UserPackagesScreenState();
}

class _UserPackagesScreenState extends State<UserPackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: 'سجل الباقات',hasBackButton: true),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ClipRRect(
              child: ExpansionTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: blackColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    side: BorderSide(color: blackColor.withOpacity(0.5))),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 10.h),
                              height: 95.h,
                              width: double.infinity,
                              color: Color(0xffF9F7EE),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'صالحة من 26 سبتمبر إلى 26 أكتوبر',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Text(
                                    'فحص شرط',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontFamily: FontConstants.lateefFont,
                                      fontWeight: FontWeightManager.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 77.h, bottom: 10.h),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: (){
                                    NavigationManager.push(Routes.productDetails);

                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 32.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    decoration: BoxDecoration(
                                        color: index % 2 != 0
                                            ? whiteColor
                                            : Color(0xffF9F7EE)),
                                    child: Row(
                                      children: <Widget>[
                                        SvgPicture.asset(IconsManager.trueIcon),
                                        SizedBox(width: 8.w),
                                        Text('فحص الماكينة')
                                      ],
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              itemCount: 8,
                            ),
                          ],
                        ),
                        Positioned(
                          top: 70.h,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircleAvatar(
                                radius: 44.sp,
                                child: CircleAvatar(
                                  radius: 40.sp,
                                  backgroundColor: Color(0xffF9F7EE),
                                  child: Text(
                                    '1000\n ر.س',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeightManager.bold,
                                        fontFamily: FontConstants.lateefFont,
                                        color: blackColor),
                                  ),
                                ),
                                backgroundColor: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                textColor: blackColor,
                iconColor: blackColor,
                tilePadding: EdgeInsets.only(left: 16.w),
                title: SizedBox(
                  height: 75.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        ImagesManager.car2,
                        width: 134.w,
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 11.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              color: Color(0xffDB3022),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        physics: BouncingScrollPhysics(),
        itemCount: 10 ,
        padding: EdgeInsets.all(16.w),
        shrinkWrap: true,
      ),
    );
  }
}
