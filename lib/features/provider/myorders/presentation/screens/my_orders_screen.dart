import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/routes.dart';

class ProviderOrdersScreen extends StatefulWidget {
  const ProviderOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ProviderOrdersScreen> createState() => _ProviderOrdersScreenState();
}

class _ProviderOrdersScreenState extends State<ProviderOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 80.h),
            child: CustomAppBar(
              title: 'طلباتي',
            )),

        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.h),
              SizedBox(
                height: 50,
                child: TabBar(
                  controller: tabController,
                  onTap: (int val) {
                    setState(() {
                      // print(val);
                    });
                  },
                  tabs: <Widget>[
                    Tab(text: 'قطع الغيار'),
                    Tab(text: 'فحص المركبارت'),
                  ],
                  padding: EdgeInsets.only(left: 170.w),
                  labelStyle: TextStyle(
                      color: Color(0xff136B79),
                      fontSize: 16.sp,
                      fontFamily: 'Lateef'),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Lateef',
                      color: Colors.black),
                  indicatorColor: Color(0xff136B79),
                  labelColor: Color(0xff136B79),
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  unselectedLabelColor: Colors.black,
                ),
              ),
              if (tabController.index == 0)
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        NavigationManager.push(Routes.orderDetails);
                      },
                      child: Container(
                        height: 115.h,
                        margin:
                        EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
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
                                height: 115.h,
                                decoration: BoxDecoration(color: packagesColor),
                                child: Image.asset(
                                  ImagesManager.fixCar1,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(width: 11.w),
                            FittedBox(
                              child: Column(
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
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(bottom: 15.h, left: 10.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 16.h),
                                  // if (index == 2)
                                  //   InkWell(
                                  //     onTap: () {
                                  //       NavigationManager.push(Routes.invoice);
                                  //     },
                                  //     child: Text('مشاهدة الفاتورة',
                                  //         style: TextStyle(fontSize: 12)),
                                  //   ),
                                  // if (index == 2)
                                  //   Container(
                                  //       width: 80.w,
                                  //       height: 1,
                                  //       color: Colors.black,
                                  //       margin: EdgeInsets.only(top: 2)),
                                  Spacer(),
                                  Card(
                                    margin: EdgeInsets.zero,
                                    color: Color(0xff136B79),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(50.r)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        'تم الاستلام',
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
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 3,
                  shrinkWrap: true,
                )
              else
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        NavigationManager.push(Routes.productDetails);
                      },
                      child: Container(
                        height: 115.h,
                        margin:
                        EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
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
                                width: 120.w,
                                height: 115.h,
                                decoration: BoxDecoration(color: packagesColor),
                                child: Image.asset(
                                  ImagesManager.fixCar1,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            FittedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 15.h),
                                  Text(
                                    'فحص شرط',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 15.h),
                                  Text(
                                    'ر.س 1000',
                                    style: TextStyle(
                                      fontWeight: FontWeightManager.regular,
                                      fontSize: 14.sp,
                                      color: Color(0xffDB3022),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                              EdgeInsets.only(bottom: 15.h, left: 10.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // SizedBox(height: 16.h),
                                  // if (index == 2)
                                  //   InkWell(
                                  //     onTap: () {
                                  //       NavigationManager.push(Routes.report);
                                  //     },
                                  //     child: Row(
                                  //       children: [
                                  //         Icon(Icons.info_outline,
                                  //             color: Colors.grey.shade400,
                                  //             size: 15),
                                  //         SizedBox(width: 2),
                                  //         Text('مشاهدة تقرير الفحص',
                                  //             style:
                                  //             TextStyle(fontSize: 10.sp)),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // if (index == 2)
                                  //   Container(
                                  //       width: 100.w,
                                  //       height: 1,
                                  //       color: Colors.black,
                                  //       margin: EdgeInsets.only(top: 3)),
                                  // if (index == 2) SizedBox(height: 10),
                                  // if (index == 2)
                                  //   InkWell(
                                  //     onTap: () {
                                  //       NavigationManager.push(Routes.invoice);
                                  //     },
                                  //     child: Row(
                                  //       children: [
                                  //         Icon(Icons.visibility,
                                  //             color: Colors.grey.shade400,
                                  //             size: 17),
                                  //         SizedBox(width: 5),
                                  //         Text('مشاهدة الفاتورة',
                                  //             style:
                                  //             TextStyle(fontSize: 10.sp)),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // if (index == 2)
                                  //   Container(
                                  //       width: 92.w,
                                  //       height: 1,
                                  //       color: Colors.black,
                                  //       margin: EdgeInsets.only(top: 2)),
                                  Spacer(),
                                  Card(
                                    margin: EdgeInsets.zero,
                                    color:Colors.red,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(50.r)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        'طلب ملغي',
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
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 3,
                  shrinkWrap: true,
                )
            ],
          ),
        ),
      ),
    );
  }
}
