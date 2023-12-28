import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 70.h,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: Image.asset(
              ImagesManager.logoCircle,
            ),
          ),
        ),
        leadingWidth: double.infinity,
        actions: <Widget>[
          InkWell(
            onTap: () {
              NavigationManager.push(Routes.notifications);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 10.w),
              child: Lottie.asset('assets/json/notification.json',
                  width: 30.sp, height: 30.sp),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        // physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 16.h, top: 12.h),
              child: Text(
                'أهلا بك احمد',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeightManager.medium,
                  fontFamily: FontConstants.lateefFont,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 163.h,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: primaryColor.withOpacity(0.8),
                        blurRadius: 2,
                        spreadRadius: 5)
                  ]),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'لإكمال تفعيل الحساب\n يجب رفع باقى الأوراق',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeightManager.bold,
                            fontFamily: 'Cairo'),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff136B79),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            minimumSize: Size(134.w, 36.h),
                          ),
                          onPressed: () {
                            NavigationManager.push(Routes.providerCompleteRenterData);
                          },
                          child: Text(
                            'إكمال',
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontFamily: 'Lateef',
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  Image.asset('assets/images/fixCarProvider.png'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24.h, bottom: 24.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              width: double.infinity,
              height: 109.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff136B79)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'الأن تستطيع الإشتراك\n فى إحدى باقات شرط',
                    style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        fontFamily: 'Cairo'),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        minimumSize: Size(134.w, 36.h),
                      ),
                      onPressed: () {},
                      child: Text(
                        'إشترك الأن',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontFamily: 'Lateef',
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            TabBar(
              controller: controller,
              onTap: (int val) {},
              tabs: <Widget>[
                Tab(text: 'الطلبات الحالية'),
                Tab(text: 'الطلبات السابقة'),
                Tab(text: 'الطلبات الملغاة'),
              ],
              labelColor: Color(0xff136B79),
              unselectedLabelColor: Colors.black,
              indicatorColor: Color(0xff136B79),
              labelStyle: TextStyle(fontSize: 16.sp, fontFamily: 'Lateef'),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
            ),
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // NavigationManager.push(Routes.orderDetails);
                  },
                  child: Container(
                    height: 115.h,
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
                                color: greyColor,
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
                              'ر.س 300',
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
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
