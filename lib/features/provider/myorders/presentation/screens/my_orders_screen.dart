import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../widgets/custom_product_widget.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav.dart';

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
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ProviderBottomNavScreen(
              checkPage: '0',
            )));
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, 80.h),
              child: CustomAppBar(
                title: '${getLang(context, 'my_requests')}',
              )),

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
                        child:
                        Padding(padding:
                        EdgeInsets.only(left: 16.w, right: 16.w,), child:
                        CustomProductWidget(isOrder: false, isSparesParts: true, isCarCheck: false,),
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
                        child:
                        Padding(padding:
                        EdgeInsets.only(left: 16.w, right: 16.w,), child: CustomProductWidget(isOrder: false, isSparesParts: false, isCarCheck: true,),
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
      ),
    );
  }
}
