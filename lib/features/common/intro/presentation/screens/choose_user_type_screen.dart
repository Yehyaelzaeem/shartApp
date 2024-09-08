import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/widgets/custom_button.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/shared_preference/shared_preference.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../../user/bottom_nav/presentation/screens/bottom_nav_screen.dart';

class ChooseUserTypeScreen extends StatefulWidget {
  const ChooseUserTypeScreen({Key? key}) : super(key: key);

  @override
  State<ChooseUserTypeScreen> createState() => _ChooseUserTypeScreenState();
}

class _ChooseUserTypeScreenState extends State<ChooseUserTypeScreen> {
  @override
  void initState() {
    AuthCubit.get(context).getPermission();
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
            title: getLang(context,'exit'),
            desc: getLang(context, 'sure_exit'),
            btnOkText: getLang(context, 'yes'),
            btnCancelText:getLang(context, 'no'),
          );
          // NavigationManager.pushReplacement(Routes.login);
        },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 243.h,),
            Image.asset(
              ImagesManager.newLogo,
              fit: BoxFit.fill,
              height: 220.h,
              width:220.h,
            ),
            SizedBox(height: 70.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${getLang(context, 'entry_as')}',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontFamily: FontConstants.lateefFont,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, bottom: 16.h),
                    child: CustomElevatedButton(
                        onTap: () {
                          CacheHelper.saveDate(key: 'type', value: 'user');
                          NavigationManager.push(Routes.authScreen);
                        },
                        buttonText: '${getLang(context, 'client')}',
                        fontColor: blackColor),
                  ),
                  CustomElevatedButton(
                      onTap: () {
                        CacheHelper.saveDate(key: 'type', value: 'provider');
                        NavigationManager.push(Routes.authProviderScreen);
                      },
                      buttonText: '${getLang(context, 'provider2')}',
                      fontColor: blackColor),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: InkWell(
                      onTap: () {
                        AuthCubit.get(context).token='';
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>UserBottomNavScreen(isVisitor: true,)));
                      },
                      child: Text(
                        '${getLang(context, 'visitor')}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeightManager.regular,
                          fontFamily: FontConstants.lateefFont,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 24.w,
                    color: primaryColor,
                  )
                ],
              ),
            )
          ],
        ),
      )
    );

  }
}

