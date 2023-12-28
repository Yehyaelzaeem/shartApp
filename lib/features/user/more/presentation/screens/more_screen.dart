import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/features/user/more/presentation/screens/about_company_screen.dart';
import 'package:shart/features/user/more/presentation/widgets/profile_item_widget.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/shared_preference/shared_preference.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../profile/logic/user_profile_cubit.dart';
import '../../../profile/presentation/test.dart';
import 'conditions_screen.dart';

class UserMoreScreen extends StatelessWidget {
  const UserMoreScreen({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    UserProfileCubit cubit =UserProfileCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title:
           getLang(context,'the_more'),
        ),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body:
      BlocConsumer<UserProfileCubit,UserProfileState>(
        builder: (BuildContext context, UserProfileState state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 25.h),
                  cubit.userProfileModel !=null?
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius:60,
                        backgroundImage:
                        NetworkImage('${cubit.userProfileModel!.data!.image}')
                      // FileImage( cubit.profileImageFile!)
                    ),):
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius:60,
                        backgroundImage:
                        NetworkImage(ImagesManager.testLogo)
                    ),),
                  UserProfileCubit.get(context).userProfileModel !=null?
                  Text(
                    '${cubit.userProfileModel!.data!.name}',
                    style: TextStyle(
                      fontFamily: FontConstants.lateefFont,
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ):SizedBox.shrink(),
                  SizedBox(height: 42.h),
                  buildProfileItemWidget(
                      iconPath: IconsManager.person,
                      function: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TestHome()));
                        // NavigationManager.push(Routes.editProfile);
                      },
                      text: getLang(context,'edite_profile'),),
                  buildProfileItemWidget(
                      iconPath: IconsManager.package,
                      function: () {
                        NavigationManager.push(Routes.packagesHistory);
                      },
                      text:  getLang(context,'packages')),
                  buildProfileItemWidget(
                      iconPath: IconsManager.info,
                      function: () {
                        UserProfileCubit.get(context).aboutCompanyModel !=null?
                        Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>AboutCompanyScreen(text:'${UserProfileCubit.get(context).aboutCompanyModel!.data!.content}'))):null;
                      },
                      text: getLang(context,'about_company')),
                  buildProfileItemWidget(
                      iconPath: IconsManager.condition,
                      function: () {
                        UserProfileCubit.get(context).termsAndConditionsUser !=null?
                        Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>ConditionsScreen(text: UserProfileCubit.get(context).termsAndConditionsUser!.data!.content))):null;
                        // NavigationManager.push(Routes.conditions);
                      },
                      text:  getLang(context,'terms_conditions')),
                  buildProfileItemWidget(
                      function: () {
                        UserProfileCubit.get(context).privacyUser !=null?
                        Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>AboutCompanyScreen(text: UserProfileCubit.get(context).privacyUser!.data!.content))):null;
                        // NavigationManager.push(Routes.conditions);
                      },
                      text:  getLang(context,'privacy_policy')),
                  buildProfileItemWidget(
                      iconPath: IconsManager.complain,
                      function: () {
                        NavigationManager.push(Routes.complains);
                      },
                      text:  getLang(context,'complaints_suggestions')),
                  buildProfileItemWidget(
                      lang:true,
                      iconPath: IconsManager.language,
                      function: () {
                        if(AuthCubit.get(context).localeLanguage==Locale('en')){
                          AuthCubit.get(context).changeLanguageApp('ar',context);
                        }else{
                          AuthCubit.get(context).changeLanguageApp('en',context);
                        }
                      },
                      text: getLang(context,'change_language'),
                      hasArrowButton: false),
                  buildProfileItemWidget(
                      iconPath: IconsManager.logout,
                      function: () {
                        CustomDialogs.showAlertDialog(
                          type: DialogType.info,
                          btnOkOnPress: () {
                            CacheHelper.removeData(key: 'isLog');
                            NavigationManager.pushReplacement(Routes.chooseUserScreen);
                          },
                          ctx: context,
                          btnCancelOnPress: () {},
                          title: getLang(context,'sign_out'),
                          desc: 'هل أنت متأكد من أنك تريد تسجيل الخروج ؟',
                          btnOkText: 'نعم',
                          btnCancelText: 'لا',
                        );
                      },
                      text: getLang(context,'sign_out'),
                      hasArrowButton: false),
                  buildProfileItemWidget(
                      iconPath: IconsManager.removeAcc,
                      function: () {
                        CustomDialogs.showAlertDialog(
                          ctx: context,
                          type: DialogType.error,
                          btnOkOnPress: () {
                            // print(AuthCubit.get(context).token2);
                            CacheHelper.removeData(key: 'isLog');
                            cubit.deleteAccount(AuthCubit.get(context).token, context);
                          },
                          btnCancelOnPress: () {
                          },
                          title: getLang(context,'delete_account'),
                          desc: 'هل أنت متأكد من أنك تريد حذف الحساب ؟',
                          btnOkText: 'نعم',
                          btnCancelText: 'لا',
                        );
                      },
                      text:getLang(context,'delete_account'),
                      hasArrowButton: false),
                  SizedBox(height: 45.h,)
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {  },

      )

    );
  }
}
