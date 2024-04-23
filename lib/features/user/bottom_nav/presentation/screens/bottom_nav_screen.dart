import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../../../provider/work_and_products/logic/work_products_cubit.dart';
import '../../../cart/logic/cart_cubit.dart';
import '../../../cart/presentation/screen/cart_bottom_nav_screen.dart';
import '../../../cart/presentation/screen/cart_screen.dart';
import '../../../favorite/logic/favorite_cubit.dart';
import '../../../menu/presentation/menu/menu_screen.dart';
import '../../../myorders/logic/my_orders_cubit.dart';
import '../../../profile/logic/user_profile_cubit.dart';
import 'package:badges/badges.dart' as badges;

class UserBottomNavScreen extends StatefulWidget {
   UserBottomNavScreen({Key? key, this.checkPage, this.isVisitor, this.initialIndex}) : super(key: key);
   final String? checkPage;
   final bool? isVisitor;
   final int? initialIndex;
  @override
  State<UserBottomNavScreen> createState() => _UserBottomNavScreenState();
}

class _UserBottomNavScreenState extends State<UserBottomNavScreen> {
  int selectedIndex = 0;
  final Color iconColor = primaryColor;
  final Color unSelectedIconColor = blackColor;

  List<Widget> pages = <Widget>[];
@override
  void initState() {
  pages=<Widget>[ UserMenuScreen(),
    UserFavoriteScreen(),
    UserOrdersScreen(isNotNotification: true,initialIndex: widget.initialIndex,),
    CartBottomNavScreen(),
    UserMoreScreen(),];
  MenuCubit.get(context).getPaymentVisibility();
  WorkProductsCubit workProductsCubit = WorkProductsCubit.get(context);
  workProductsCubit.getSize(context);
  workProductsCubit.getWidth(context);
  workProductsCubit.getHeight(context);
  if(widget.isVisitor!=null){
    AuthCubit.get(context).token='';
    MenuCubit.get(context).getPackageCheck(context);
    MenuCubit.get(context).getBanners('user',context);
     BookPackageCubit.get(context).getBrands(type:'spare_parts',context: context);
    BookPackageCubit.get(context).getBrandModel(context);
    BookPackageCubit.get(context).getBrandColors(context);
  }else{

    AuthCubit.get(context).getToken(context);
    MenuCubit.get(context).getPackageCheck(context);
    MenuCubit.get(context).getBanners('user',context);
    if (widget.checkPage != null) {
      selectedIndex = int.parse(widget.checkPage.toString()).toInt();
    } else {
      selectedIndex = 0;
    }
    BookPackageCubit.get(context).getBrands(type: 'spare_parts',context: context);
    BookPackageCubit.get(context).getBrandModel(context);
    BookPackageCubit.get(context).getBrandColors(context);
    UserProfileCubit.get(context).getAboutCompanyUser(context);
    UserProfileCubit.get(context).getPrivacyUser(context);
    UserProfileCubit.get(context).getTermsAndConditionsUser(context);
  }

  // UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token2==''?AuthCubit.get(context).token:AuthCubit.get(context).token2}', context);
  // UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token2}', context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              icon:   badges.Badge(
                badgeContent: BlocConsumer<CartCubit, CartState>(
                  builder: (BuildContext context, CartState state) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 3.3),
                      child: Text(
                        '${CartCubit.get(context).products.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  listener: (BuildContext context, CartState state) {},
                ),
                position:  badges.BadgePosition.topEnd(top: -13, end: -20),
                child: const Icon(Icons.shopping_cart),
                ),
              label: getLang(context,'cart')),
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
    );
  }
}
