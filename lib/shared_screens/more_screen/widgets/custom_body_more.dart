import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/provider/home/logic/provider_home_cubit.dart';
import 'package:shart/features/user/profile/presentation/address/screens/user_addresses.dart';
import '../../../core/localization/appLocale.dart';
import '../../../core/resources/assets_menager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../core/shared_preference/shared_preference.dart';
import '../../../features/provider/auth/logic/auth_provider_cubit.dart';
import '../../../features/provider/home/presentation/screens/packages/packages_screen.dart';
import '../../../features/provider/profile/data/model/user_profile_model.dart';
import '../../../features/provider/profile/logic/provider_profile_cubit.dart';
import '../../../features/provider/work_and_products/logic/work_products_cubit.dart';
import '../../../features/user/auth/logic/auth_cubit.dart';
import '../../../features/user/book_package_service/logic/book_package_cubit.dart';
import '../../../features/user/menu/logic/menu_cubit.dart';
import '../../../features/user/profile/presentation/about_company/about_company_screen.dart';
import '../../../features/user/profile/presentation/complains/complains_screen.dart';
import '../../../features/user/profile/presentation/conditions_terms/conditions_screen.dart';
import '../../../features/user/profile/data/model/user_profile_model.dart';
import '../../../features/user/profile/logic/user_profile_cubit.dart';
import '../../../features/user/profile/presentation/widgets/profile_item_widget.dart';
import '../../../widgets/custom_alert_dialog.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CustomBodyMore extends StatelessWidget {
  const CustomBodyMore({super.key,  this.userProfileModel,  this.providerGetProfileModel, required this.type});
  final UserProfileModel? userProfileModel;
  final String type;
  final ProviderGetProfileModel? providerGetProfileModel;
  @override
  Widget build(BuildContext context) {
    UserProfileCubit cubit =UserProfileCubit.get(context);

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 25.h),
        type=='user'?
        Container(
          height: 100,
          width: 100,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Image.network('${userProfileModel!.data!.image}',
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return  Image.asset('assets/images/person.jpg');
                },
              )),
        ):
        Container(
          height: 100,
          width: 100,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Image.network('${providerGetProfileModel!.data!.image}',
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Image.asset('assets/images/person.jpg');
                },
              )),
        ),
        // CircleAvatar(
        //   radius: 55,
        //   backgroundColor: Colors.white,
        //   child: CircleAvatar(
        //       backgroundColor: Colors.white,
        //       radius:50,
        //       backgroundImage:
        //       NetworkImage('${providerGetProfileModel!.data!.image}')
        //   ),),
        type=='user'?
        Text(
          '${userProfileModel!.data!.name}',
          style: TextStyle(
            fontFamily: FontConstants.lateefFont,
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeightManager.regular,
          ),
        ):
        Text(
          '${providerGetProfileModel!.data!.name}',
          style: TextStyle(
            fontFamily: FontConstants.lateefFont,
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        SizedBox(height: 42.h),
        buildProfileItemWidget(
          iconPath: IconsManager.person,
          function: () {
            type=='user'?
            NavigationManager.push(Routes.editProfile):
            NavigationManager.push(Routes.providerEditProfile);
          },
          text: getLang(context,'edite_profile'),),


        type!='user'?buildProfileItemWidget(
            iconPath: IconsManager.myAddress,
            function: () {
              if( type=='user'){

                // UserProfileCubit.get(context).getAddressListUser(AuthCubit.get(context).token, context);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>UserAddressesScreen()));

              }else{
                ProviderProfileCubit.get(context).getAddressListProvider(AuthProviderCubit.get(context).token, context);
                NavigationManager.push(Routes.providerAddresses);
              }
            },
            text: getLang(context,'my_addresses')):SizedBox.shrink(),

        type!='user'?
        buildProfileItemWidget(
          iconPath: IconsManager.myWork,
          function: () {
            WorkProductsCubit.get(context).getWorks(context);
            WorkProductsCubit.get(context).getAllProducts(context);
            NavigationManager.push(Routes.providerWorkScreen);
          },
          text: getLang(context,'business_products'),
        ):SizedBox.shrink(),

        buildProfileItemWidget(
            iconPath: IconsManager.package,
            function: () {


             if(type=='user'){
               NavigationManager.push(Routes.checkingPackages);
             }else{
              ProviderHomeCubit.get(context).getHistoryPackages(context);
              Navigator.push(context, MaterialPageRoute(builder:
              (BuildContext context)=>ProviderPackagesScreen(
              isHistory: true,
              )));
              }

            },
            text:  getLang(context,'packages')),

        buildProfileItemWidget(
            iconPath: IconsManager.info,
            function: () {
              if(type=='user'){
                UserProfileCubit.get(context).aboutCompanyModel !=null?
                Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>AboutCompanyScreen(text:'${UserProfileCubit.get(context).aboutCompanyModel!.data!.content}'))):null;
              }
              else{
                ProviderProfileCubit.get(context).aboutCompanyModel !=null?
                Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>AboutCompanyScreen(text: '${ProviderProfileCubit.get(context).aboutCompanyModel!.data!.content}',))):null;
              }
               },
            text: getLang(context,'about_company')),
        buildProfileItemWidget(
            iconPath: IconsManager.condition,
            function: () {
              if(type=='user'){
                UserProfileCubit.get(context).termsAndConditionsUser !=null?
                Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>ConditionsScreen(text: UserProfileCubit.get(context).termsAndConditionsUser!.data!.content))):null;

              }else{
                ProviderProfileCubit.get(context).termsAndConditionsProvider !=null?
                Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>ConditionsScreen(text: '${ProviderProfileCubit.get(context).termsAndConditionsProvider!.data!.content}',))): null;
              }
            },
            text:  getLang(context,'terms_conditions')),

        buildProfileItemWidget(
            function: () {
              if(type=='user'){
                UserProfileCubit.get(context).privacyUser !=null?
                Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>AboutCompanyScreen(text: UserProfileCubit.get(context).privacyUser!.data!.content))):null;
              }
              else{
                ProviderProfileCubit.get(context).privacyProvider !=null?
                Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context)=>AboutCompanyScreen(text: ProviderProfileCubit.get(context).privacyProvider!.data!.content))):null;
              }
              // NavigationManager.push(Routes.conditions);
            },
            text:  getLang(context,'privacy_policy')),
        buildProfileItemWidget(
            iconPath: IconsManager.complain,
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ComplainsScreen(type: type,)));
              // NavigationManager.push(Routes.complains);
            },
            text:  getLang(context,'complaints_suggestions')),
        buildProfileItemWidget(
            lang:true,
            iconPath: IconsManager.language,
            function: () {
              if(type =='user'){
                if(AuthCubit.get(context).localeLanguage==Locale('en')){
                  AuthCubit.get(context).changeLanguageApp('ar',context,true);
                }else{
                  AuthCubit.get(context).changeLanguageApp('en',context,true);
                }
              }else{
                if(AuthCubit.get(context).localeLanguage==Locale('en')){
                  AuthCubit.get(context).changeLanguageApp('ar',context,false);
                  ProviderProfileCubit.get(context).afterChangeLanguage(context);
                }else{
                  AuthCubit.get(context).changeLanguageApp('en',context,false);
                  ProviderProfileCubit.get(context).afterChangeLanguage(context);
                }
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
                  if(type=='user'){
                    CacheHelper.removeData(key: 'isLog');
                    NavigationManager.pushReplacement(Routes.chooseUserScreen);
                  }
                  else{
                    CacheHelper.removeData(key: 'isLog');
                    NavigationManager.pushReplacement(Routes.chooseUserScreen);
                    cubit.nameController.text='';
                    cubit.emailController.text='';
                    cubit.phoneController.text='';
                  }
                },
                ctx: context,
                btnCancelOnPress: () {},
                title: getLang(context,'exit'),
                desc: getLang(context, 'sure_exit'),
                btnOkText: getLang(context, 'yes'),
                btnCancelText:getLang(context, 'no'),
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
                  if(type=='user'){
                    CacheHelper.removeData(key: 'isLog');
                    cubit.deleteAccount(AuthCubit.get(context).token, context);
                  }else{
                    CacheHelper.removeData(key: 'isLog');
                    ProviderProfileCubit.get(context).deleteAccountProvider(AuthProviderCubit.get(context).token2, context);
                  }

                },
                btnCancelOnPress: () {
                },
                title: getLang(context,'delete_account'),
                desc: getLang(context, 'sure_delete'),
                btnOkText: getLang(context, 'yes'),
                btnCancelText: getLang(context, 'no'),
              );
            },
            text:getLang(context,'delete_account'),
            hasArrowButton: false),
        SizedBox(height: 45.h,)
      ],
    );
  }
}
