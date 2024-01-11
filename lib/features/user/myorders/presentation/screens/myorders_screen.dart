import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../shared_screens/visitor_screen/visitor_screen.dart';
import '../../../../provider/myorders/presentation/widgets/custom_car_cancelled_order_widget.dart';
import '../../../../provider/myorders/presentation/widgets/custom_car_current_order_widget.dart';
import '../../../../provider/myorders/presentation/widgets/custom_order_invoice_widget.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
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
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => UserBottomNavScreen(
              checkPage: '0',
            )));
      },
      child:
      AuthCubit.get(context).token.isEmpty?
      CustomVisitorScreen():
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, 80.h),
              child: CustomAppBar(title: '${getLang(context, 'my_requests')}')),
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
                      Tab(text: '${getLang(context, 'spare_parts')}'),
                      Tab(text: '${getLang(context, 'check_cars')}'),
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
                    // indicatorPadding: EdgeInsets.symmetric(horizontal: 0.w,vertical: ),
                    unselectedLabelColor: Colors.black,
                  ),
                ),
                if (tabController.index == 0)
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) return buildCurrentOrder(context);
                      if (index == 1) return buildCancelledOrder(context);
                      return buildOrderWithInvoice(context);
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
      ),
    );
  }
}
