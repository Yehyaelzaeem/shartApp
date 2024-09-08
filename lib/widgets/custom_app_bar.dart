import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/features/user/cart/logic/cart_cubit.dart';
import '../features/user/cart/presentation/screen/cart_screen.dart';
import 'package:badges/badges.dart' as badges;

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool? hasBackButton;
  final bool? hasCartButton;
  final Widget? actionWidget;
  void Function()? onTap;
  CustomAppBar({super.key, required this.title, this.hasBackButton,this.onTap, this.hasCartButton, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 17.h),
        child: Text(title),
      ),
      titleTextStyle: TextStyle(
        fontWeight: FontWeightManager.bold,
        fontSize: 24.sp,
        fontFamily: FontConstants.lateefFont,
        color: blackColor,
      ),
      centerTitle: true,
      // backgroundColor: primaryColor,
      leading: hasBackButton == true
          ? Padding(
              padding: EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w),
              child: InkWell(
                  onTap: onTap??(){
                    Navigator.pop(context);
                  },
                  //     () {
                  //   UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token2}', context);
                  //   Navigator.pop(context);
                  // },
                  child: Icon(Icons.arrow_back_ios_rounded)
                  // SvgPicture.asset(IconsManager.backIcon),
              ),
            )
          : null,
      actions: [
        hasCartButton==true?
        AuthCubit.get(context).token.isNotEmpty?
        badges.Badge(
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
          position:  badges.BadgePosition.topEnd(top: -5, end: -5),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ):SizedBox.shrink():SizedBox.shrink(),
        const SizedBox(
          width: 20.0,
        ),
        if(actionWidget!=null)
          actionWidget!
      ],
    );
  }
}
