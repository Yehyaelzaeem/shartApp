import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/provider/work_and_products/presentation/screens/products_screen.dart';
import 'package:shart/features/provider/work_and_products/presentation/screens/work_screen.dart';
import 'package:shart/widgets/custom_app_bar.dart';

class ProviderWorkAndProductsScreen extends StatefulWidget {
  const ProviderWorkAndProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProviderWorkAndProductsScreen> createState() => _MyWorkScreenState();
}

class _MyWorkScreenState extends State<ProviderWorkAndProductsScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: 'اعمالي', hasBackButton: true),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 24.h),
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              onTap: (value) {
                setState(() {
                  controller.index = value;
                });
              },
              controller: controller,
              tabs: [
                Tab(text: 'أعمالي'),
                Tab(text: 'منتجاتي'),
              ],
              unselectedLabelColor: Colors.black,
              labelColor: Color(0xff136B79),
              padding: EdgeInsets.only(left: 180.w),
              indicatorColor: Color(0xff136B79),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
              labelStyle: TextStyle(
                fontFamily: 'Lateef',
                fontSize: 16.sp,
                color: Color(0xff136B79),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
                margin: EdgeInsets.only(top: 24.h),
                width: double.infinity,
                height: ScreenUtil().screenHeight * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    border: Border.all(color: Color(0xffD0D5DD))),
                child: controller.index == 0 ? WorkScreen() : ProductsScreen()),
          ],
        ),
      ),
    );
  }
}
