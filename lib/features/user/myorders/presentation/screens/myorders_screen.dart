import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/localization/appLocale.dart' as tr;
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../widgets/order_widgets.dart';

class UserOrdersScreen extends StatefulWidget {
  const UserOrdersScreen({Key? key}) : super(key: key);

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen>
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
            child: CustomAppBar(title: 'طلباتي')),

        body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
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
                    if (index == 0) return buildCurrentOrder(context);
                    if (index == 1) return buildCancelledOrder();
                    return buildOrderWithInvoice();
                  },
                  itemCount: 3,
                  shrinkWrap: true,
                )
              else
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) return buildCarCurrentOrder();
                    if (index == 1) return buildCarCancelledOrder();
                    return buildOrderWithInvoiceAndReport();
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

  InkWell buildOrderWithInvoiceAndReport() {
    return InkWell(
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

  InkWell buildCarCurrentOrder() {
    return InkWell(
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

  InkWell buildCarCancelledOrder() {
    return InkWell(
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
              width: 124.w,
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'فحص شرط بلس',
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
            Container(
              height: 30.h,
              width:63.w ,
              decoration: BoxDecoration(
                  color: Color(0xffFF0000),
                  borderRadius: BorderRadius.circular(50.r)
              ),
              margin: EdgeInsets.zero,
              child: Center(
                child: FittedBox(
                  child: Text(
                    '    ${"ملغي"}    ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: whiteColor,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),



          ],
        ),
      ),
    );
  }
}
