import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/features/user/more/presentation/widgets/profile_item_widget.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../../user/auth/logic/auth_cubit.dart';
import '../../../../user/more/presentation/screens/about_company_screen.dart';
import '../../../../user/more/presentation/screens/conditions_screen.dart';
import '../../../../user/profile/logic/user_profile_cubit.dart';
import '../../../profile/logic/provider_profile_cubit.dart';

class ProviderMoreScreen extends StatefulWidget {
  const ProviderMoreScreen({Key? key}) : super(key: key);

  @override
  State<ProviderMoreScreen> createState() => _ProviderMoreScreenState();
}

class _ProviderMoreScreenState extends State<ProviderMoreScreen> {
  @override
  void initState() {
    // print('start : ${AuthProviderCubit.get(context).token}');
    //  ProviderProfileCubit.get(context).getProviderProfile('${AuthProviderCubit.get(context).token}', context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'المزيد'),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body:
        BlocConsumer<ProviderProfileCubit,ProviderProfileState>(
          builder: (BuildContext context ,ProviderProfileState state){
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 25.h),
                  cubit.providerProfileModel !=null?
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius:60,
                        backgroundImage:
                        NetworkImage('${cubit.providerProfileModel!.data!.image}')
                    ),):
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius:60,
                        backgroundImage:
                        NetworkImage(ImagesManager.testLogo)
                    ),),
                  // CircleAvatar(
                  //   radius: 55.sp,
                  //   backgroundImage: AssetImage(ImagesManager.introduction2),
                  // ),
                  cubit.providerProfileModel !=null?
                  Text(
                    '${cubit.providerProfileModel!.data!.name}',
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
                        NavigationManager.push(Routes.providerEditProfile);
                      },
                      text: getLang(context,'edite_profile'),),
                  buildProfileItemWidget(
                      iconPath: IconsManager.myAddress,
                      function: () {
                        ProviderProfileCubit.get(context).getAddressListProvider(AuthProviderCubit.get(context).token, context);
                        NavigationManager.push(Routes.providerAddresses);
                      },
                      text: getLang(context,'my_addresses')),
                  buildProfileItemWidget(
                    iconPath: IconsManager.myWork,
                    function: () {

                      NavigationManager.push(Routes.providerWorkScreen);
                    },
                    text: getLang(context,'business_products'),
                  ),
                  buildProfileItemWidget(
                      iconPath: IconsManager.package,
                      function: () {
                        NavigationManager.push(Routes.providerPackages);
                      },
                      text:getLang(context,'packages')),
                  buildProfileItemWidget(
                      iconPath: IconsManager.info,
                      function: () {
                        ProviderProfileCubit.get(context).aboutCompanyModel !=null?
                        Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>AboutCompanyScreen(text: '${ProviderProfileCubit.get(context).aboutCompanyModel!.data!.content}',))):null;
                        // NavigationManager.push(Routes.aboutCompany);
                      },
                      text:  getLang(context,'about_company')),
                  buildProfileItemWidget(
                      iconPath: IconsManager.condition,
                      function: () {
                        ProviderProfileCubit.get(context).termsAndConditionsProvider !=null?
                        Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>ConditionsScreen(text: '${ProviderProfileCubit.get(context).termsAndConditionsProvider!.data!.content}',))):
                            null;
                      },
                      text:getLang(context,'terms_conditions')),
                  buildProfileItemWidget(
                      iconPath: IconsManager.condition,
                      function: () {
                        ProviderProfileCubit.get(context).privacyProvider !=null?
                        Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>AboutCompanyScreen(text: ProviderProfileCubit.get(context).privacyProvider!.data!.content))):null;
                        // NavigationManager.push(Routes.conditions);
                      },
                      text:  getLang(context,'privacy_policy')),
                  buildProfileItemWidget(
                      iconPath: IconsManager.complain,
                      function: () {
                        NavigationManager.push(Routes.complains);
                      },
                      text: getLang(context,'complaints_suggestions')),
                  buildProfileItemWidget(
                      lang:true,
                      iconPath: IconsManager.language,
                      function: () {
                        if(AuthCubit.get(context).localeLanguage==Locale('en')){
                          AuthCubit.get(context).changeLanguageApp('ar',context);
                          ProviderProfileCubit.get(context).afterChangeLanguage(context);
                        }else{
                          AuthCubit.get(context).changeLanguageApp('en',context);
                          ProviderProfileCubit.get(context).afterChangeLanguage(context);
                        }


                      },
                      text:  getLang(context,'change_language'),
                      hasArrowButton: false),
                  buildProfileItemWidget(
                      iconPath: IconsManager.logout,
                      function: () {
                        CustomDialogs.showAlertDialog(
                          type: DialogType.info,
                          btnOkOnPress: () {
                            NavigationManager.pushReplacement(Routes.chooseUserScreen);
                            cubit.nameController.text='';
                            cubit.emailController.text='';
                            cubit.phoneController.text='';
                          },
                          ctx: context,
                          btnCancelOnPress: () {},
                          title: 'تسجيل الخروج',
                          desc: 'هل أنت متأكد من أنك تريد تسجيل الخروج ؟',
                          btnOkText: 'نعم',
                          btnCancelText: 'لا',
                        );
                      },
                      text:getLang(context,'sign_out'),
                      hasArrowButton: false),
                  buildProfileItemWidget(
                      iconPath: IconsManager.removeAcc,
                      function: () {
                        CustomDialogs.showAlertDialog(
                          ctx: context,
                          type: DialogType.error,
                          btnOkOnPress: () {
                            cubit.deleteAccountProvider(AuthProviderCubit.get(context).token2, context);
                          },
                          btnCancelOnPress: () {},
                          title: 'حذف الحساب',
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
            );
          },
          listener: (BuildContext context ,ProviderProfileState state){},
        )
    );
  }
}
