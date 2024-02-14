import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/features/user/menu/presentation/search/search_screen.dart';
import 'package:shart/widgets/custom_menu_top_log_widget.dart';
import 'package:shart/features/user/menu/presentation/menu/widget/custom_services_type_widget.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../../../widgets/custom_slider_widget.dart';
import '../../../../../widgets/custom_welcome_message.dart';
import '../../../../common/intro/presentation/screens/choose_user_type_screen.dart';
import '../../logic/menu_cubit.dart';

class UserMenuScreen extends StatelessWidget {
  const UserMenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if(AuthCubit.get(context).token.isNotEmpty){
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
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ChooseUserTypeScreen()));
        }

        // NavigationManager.pushReplacement(Routes.login);
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30.h,),
                CustomTopRowLogo(type: 'user',),
                CustomWelcomeMessage(),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                  child: InkWell(
                    onTap: (){
                      MenuCubit c = MenuCubit.get(context);
                      c.searchControllerHome.text='';
                      c.changeSearchStart(false);
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SearchScreen()));
                      // NavigationManager.push(Routes.store);
                    },
                    child: CustomTextField(
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                      hintText:  getLang(context, 'hit_message'),
                      enabled: false,
                      hintColor: blackColor,
                      hintFontFamily: FontConstants.lateefFont,
                      controller: TextEditingController(),
                      prefixIcon: Icon(Icons.search_outlined, color: greyColor),
                    ),
                  ),
                ),
                CustomSliderWidget(),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Text(
                    getLang(context, 'our_services'),
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeightManager.medium,
                      fontFamily: FontConstants.lateefFont,
                    ),
                  ),
                ),
                CustomServicesTypeWidget(
                  onTap: (){
                    MenuCubit.get(context).getPackageCheck(context);
                    NavigationManager.push(Routes.checkingPackages);
                  },
                  image: ImagesManager.car1,
                  text:  getLang(context, 'check_cars'),
                  color: carCheckColor,
                ),
                CustomServicesTypeWidget(
                  onTap: (){
                    NavigationManager.push(Routes.spareParts);
                  },
                  image: ImagesManager.oil,
                  text:  getLang(context, 'spare_parts'),
                  color: carCheckColor2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
