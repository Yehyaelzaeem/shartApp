import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../widgets/custom_product_widget.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav.dart';

class ProviderOrdersScreen extends StatelessWidget {
  const ProviderOrdersScreen({Key? key}) : super(key: key);
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
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 80.h),
            child: CustomAppBar(
              title: '${getLang(context, 'my_requests')}',
            )),

        body:
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

      ),
    );
  }
}
