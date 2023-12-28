import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/features/user/book_package_service/logic/book_package_cubit.dart';
import 'package:shart/features/user/favorite/presentation/screens/favorite_screen.dart';
import 'package:shart/features/user/menu/logic/menu_cubit.dart';
import 'package:shart/features/user/messages/presentation/screens/messages_screen.dart';
import 'package:shart/features/user/more/presentation/screens/more_screen.dart';
import 'package:shart/features/user/myorders/presentation/screens/myorders_screen.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../menu/presentation/menu/menu_screen.dart';
import '../../../profile/logic/user_profile_cubit.dart';

class UserBottomNavScreen extends StatefulWidget {
   UserBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<UserBottomNavScreen> createState() => _UserBottomNavScreenState();
}

class _UserBottomNavScreenState extends State<UserBottomNavScreen> {
  int selectedIndex = 0;
  final Color iconColor = primaryColor;
  final Color unSelectedIconColor = blackColor;

  List<Widget> pages = <Widget>[
    UserMenuScreen(),
    UserFavoriteScreen(),
    UserOrdersScreen(),
    UserMessagesScreen(),
    UserMoreScreen(),
  ];
@override
  void initState() {
   AuthCubit.get(context).getToken(context);
   MenuCubit.get(context).getPackageCheck(context);
   BookPackageCubit.get(context).getBrands(context);
   BookPackageCubit.get(context).getBrandModel(context);
   BookPackageCubit.get(context).getBrandColors(context);
   UserProfileCubit.get(context).getAboutCompanyUser(context);
   UserProfileCubit.get(context).getPrivacyUser(context);
   UserProfileCubit.get(context).getTermsAndConditionsUser(context);
  // UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token2==''?AuthCubit.get(context).token:AuthCubit.get(context).token2}', context);
  // UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token2}', context);
    super.initState();
  }


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
        resizeToAvoidBottomInset: true,
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
                icon: Icon(Icons.favorite_border), label:getLang(context,'favorite')),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: getLang(context,'my_orders')),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined), label: getLang(context,'messages')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: getLang(context,'the_more')),
          ],
          currentIndex: selectedIndex,
          onTap: (int val) {
            selectedIndex = val;
            setState(() {});
          },
        ),
        body: pages[selectedIndex],
      ),
    );
  }
}
