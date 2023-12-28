import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';


class CustomAppBar extends StatelessWidget {
  final String title;
  final bool? hasBackButton;
  void Function()? onTap;
  CustomAppBar({super.key, required this.title, this.hasBackButton,this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 25.h),
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
              padding: EdgeInsets.only(top: 25.h, right: 16.w, left: 16.w),
              child: InkWell(
                  onTap: onTap,
                  //     () {
                  //   UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token2}', context);
                  //   Navigator.pop(context);
                  // },
                  child: Icon(Icons.arrow_back_ios_rounded)
                  // SvgPicture.asset(IconsManager.backIcon),
              ),
            )
          : null,
    );
  }
}
