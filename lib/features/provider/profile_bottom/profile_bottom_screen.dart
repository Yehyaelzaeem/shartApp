import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/provider/profile_bottom/widgets/store_data_widget.dart';

import '../../../core/localization/appLocale.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../user/auth/logic/auth_cubit.dart';
import '../bottom_nav/presentation/screens/bottom_nav.dart';
import '../work_and_products/presentation/screens/products_screen.dart';
import '../work_and_products/presentation/screens/work_screen.dart';

class ProfileBottomScreen extends StatefulWidget {
  const ProfileBottomScreen({Key? key}) : super(key: key);

  @override
  State<ProfileBottomScreen> createState() => _MyWorkScreenState();
}

class _MyWorkScreenState extends State<ProfileBottomScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return
      PopScope(
        canPop: false,
        onPopInvoked: (_) async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProviderBottomNavScreen(
                checkPage: '0',
              )));
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 80.h),
            child: CustomAppBar(title: '${getLang(context,'store_data')}',
              hasBackButton: false,

            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 24.h),
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // alignment: Alignment.topRight,
                  // width: MediaQuery.of(context).size.width*0.5,
                  child: TabBar(
                    onTap: (value) {
                      setState(() {
                        controller.index = value;
                      });
                    },
                    controller: controller,
                    tabs: <Widget>[
                      Tab(text: '${getLang(context, 'store_data')}'),
                      Tab(text: '${getLang(context, 'my_business')}'),
                      Tab(text: '${getLang(context, 'my_products')}'),
                    ],
                    padding: AuthCubit.get(context).localeLanguage==Locale('ar')?EdgeInsets.only(left: 120.w):EdgeInsets.only(right: 70.w),
                    unselectedLabelColor: Colors.black,
                    labelColor: Color(0xff136B79),
                    // padding: EdgeInsets.only(left: 0.w),
                    indicatorColor: Color(0xff136B79),
                    // indicatorPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                    labelStyle: TextStyle(
                      fontFamily: 'Lateef',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: Color(0xff136B79),
                    ),
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
                    child: controller.index == 0 ? StoreDataWidget() :
                            controller.index == 1?WorkScreen():
                            ProductsScreen()),
              ],
            ),
          ),
        ),
      );
  }
}