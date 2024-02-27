import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/features/provider/favorite/presentation/screens/favorite_screen.dart';
import 'package:shart/features/provider/messages/presentation/screens/messages_screen.dart';
import 'package:shart/features/provider/more/presentation/screens/more_screen.dart';
import 'package:shart/features/provider/myorders/presentation/screens/my_orders_screen.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../../user/book_package_service/logic/book_package_cubit.dart';
import '../../../../user/menu/logic/menu_cubit.dart';
import '../../../auth/logic/auth_provider_cubit.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../profile/logic/provider_profile_cubit.dart';
import '../../../profile_bottom/profile_bottom_screen.dart';
import '../../../work_and_products/logic/work_products_cubit.dart';

class ProviderBottomNavScreen extends StatefulWidget {
  const ProviderBottomNavScreen({Key? key, this.checkPage}) : super(key: key);
  final String? checkPage;
  @override
  State<ProviderBottomNavScreen> createState() =>
      _ProviderBottomNavScreenState();
}

class _ProviderBottomNavScreenState extends State<ProviderBottomNavScreen> {
  List<Widget> pages = <Widget>[
    const ProviderHomeScreen(),
    const ProviderOrdersScreen(isNotNotification: true,),
    const ProfileBottomScreen(),
    // const ProviderMoreScreen(),
    const ProviderMoreScreen(),
  ];

  @override
  void initState() {
    AuthProviderCubit.get(context).getToken(context);
    WorkProductsCubit workProductsCubit = WorkProductsCubit.get(context);
    workProductsCubit.getSize(context);
    workProductsCubit.getWidth(context);
    workProductsCubit.getHeight(context);

    MenuCubit.get(context).getBanners('provider',context);
    if (widget.checkPage != null) {
      currentPage = int.parse(widget.checkPage.toString()).toInt();
    } else {
      currentPage = 0;
    }
    BookPackageCubit.get(context).getBrands(type: 'spare_parts', context: context,);
    BookPackageCubit.get(context).getBrandModel(context);
    BookPackageCubit.get(context).getBrandColors(context);
    MenuCubit.get(context).getPackageCheck(context);
    ProviderProfileCubit.get(context).getAboutCompanyProvider(context);
    ProviderProfileCubit.get(context).getPrivacyProvider(context);
    ProviderProfileCubit.get(context).getTermsAndConditionsProvider(context);
    super.initState();
  }

  int currentPage = 0;
  void setCurrentPage(int currentPage) =>
      setState(() => this.currentPage = currentPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedIconTheme: IconThemeData(color: primaryColor),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: getLang(context,'the_menu')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: getLang(context,'my_orders')),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp), label: getLang(context,'profile')),

          // BottomNavigationBarItem(
          //     icon: Icon(Icons.person), label:  getLang(context,'profile')),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label:getLang(context,'the_more')),
        ],
        currentIndex: currentPage,
        onTap: (int val) {
          currentPage = val;
          setState(() {});
        },
      ),
    );
  }
}
