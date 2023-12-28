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
import '../../../auth/logic/auth_provider_cubit.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../profile/logic/provider_profile_cubit.dart';

class ProviderBottomNavScreen extends StatefulWidget {
  const ProviderBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<ProviderBottomNavScreen> createState() =>
      _ProviderBottomNavScreenState();
}

class _ProviderBottomNavScreenState extends State<ProviderBottomNavScreen> {
  List<Widget> pages = <Widget>[
    const ProviderHomeScreen(),
    const ProviderFavoriteScreen(),
    const ProviderOrdersScreen(),
    const ProviderMessagesScreen(),
    const ProviderMoreScreen(),
  ];

  @override
  void initState() {
    AuthProviderCubit.get(context).getToken(context);
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
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        CustomDialogs.showAlertDialog(
          type: DialogType.warning,
          btnOkOnPress: () {
            exit(0);
          },
          ctx: context,
          btnCancelOnPress: () {},
          title: 'الخروج',
          desc: 'هل أنت متأكد من أنك تريد  الخروج ؟',
          btnOkText: 'نعم',
          btnCancelText: 'لا',
        );
        // NavigationManager.pushReplacement(Routes.login);
      },
      child: Scaffold(
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
                icon: Icon(Icons.favorite_border), label: getLang(context,'favorite')),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: getLang(context,'my_orders')),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined), label:  getLang(context,'messages')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label:getLang(context,'the_more')),
          ],
          currentIndex: currentPage,
          onTap: (int val) {
            currentPage = val;
            setState(() {});
          },
        ),
      ),
    );
  }
}
