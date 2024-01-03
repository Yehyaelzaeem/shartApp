import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../provider/myorders/presentation/widgets/custom_car_cancelled_order_widget.dart';
import '../../../../provider/myorders/presentation/widgets/custom_car_current_order_widget.dart';
import '../../../../provider/myorders/presentation/widgets/custom_order_invoice_widget.dart';
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
                    if (index == 0) return CustomCarCurrentOrderWidget();
                    if (index == 1) return CustomCarCancelledOrderWidget();
                    return CustomOrderWithInvoiceAndReportWidget();
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
