import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import '../../../../core/resources/assets_menager.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../core/routing/routes.dart';
import '../../../../features/provider/auth/logic/auth_provider_cubit.dart';
import '../../../../features/provider/profile/logic/provider_profile_cubit.dart';
import '../../../../features/user/auth/logic/auth_cubit.dart';
import '../../../../features/user/profile/logic/user_profile_cubit.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';

class CustomEditProfileBodyWidget extends StatelessWidget {
  const CustomEditProfileBodyWidget({super.key, required this.type, required this.userCubit, required this.providerCubit});
 final String type;
 final UserProfileCubit userCubit;
 final ProviderProfileCubit providerCubit;
  @override
  Widget build(BuildContext context) {
    return
      (type=='user'?userCubit.isUpdateLoading:providerCubit.isUpdateLoading)
          ==false?
      SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
                children: <Widget>[Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 32.h),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[

          (type=='user'?userCubit.userProfileModel:providerCubit.providerProfileModel) !=null?
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white,
            child:
            (type=='user'?userCubit.profileImageFile:providerCubit.profileImageProviderFile) !=null?
            CircleAvatar(
                radius:50,
                backgroundImage:
                FileImage(
                    type=='user'?
                    userCubit.profileImageFile!:providerCubit.profileImageProviderFile!
                )
            ):
            type=='user'?
            Container(
              height: 100,
              width: 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Image.network('${userCubit.userProfileModel!.data!.image}',
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
                  child: Image.network('${providerCubit.providerProfileModel!.data!.image}',
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Image.asset('assets/images/person.jpg');
                    },
                  )),
            ),
          ):
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white,
            child: CircleAvatar(
                radius:50,
                backgroundImage:
                NetworkImage(ImagesManager.testLogo)
            ),),
          CircleAvatar(
            backgroundColor: greyColor,
            child: IconButton(
              onPressed: () {
                type=='user'?
                userCubit.uploadImage():providerCubit.uploadImage();
              },
              icon: Icon(Icons.camera_alt_outlined,color:Colors.white,size: 23,),
            ),
          )
        ],
      ),
                  ),
                  CustomTextField(
      prefixIcon: Icon(Icons.person),
      hintText: '${
          type=='user'?
          userCubit.userProfileModel!.data!.name:providerCubit.providerProfileModel!.data!.name}',
      controller:
      type=='user'?
      userCubit.nameController:providerCubit.nameControllerProvider,
      textInputType: TextInputType.name,
                  ),
                  Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: CustomTextField(
        hintText: '${
            type=='user'?
            userCubit.userProfileModel!.data!.email:providerCubit.providerProfileModel!.data!.email}',
        prefixIcon: Icon(Icons.email),
        controller:
        type=='user'?
        userCubit.emailController:providerCubit.emailControllerProvider,
      ),
                  ),
                  CustomTextField(
      hintText: '${
          type=='user'?
          userCubit.userProfileModel!.data!.phone:providerCubit.providerProfileModel!.data!.phone}',
      controller:
      type=='user'?
      userCubit.phoneController:providerCubit.phoneControllerProvider,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.phone,
      prefixIcon: Icon(
        Icons.phone,
      ),
                  ),
                  Padding(
      padding: EdgeInsets.only(top: 110.h, bottom: 15.h),
      child: CustomElevatedButton(
          onTap: () {
            type=='user'?
            userCubit.updateUserProfile(UserProfileCubit.get(context).userProfileModel!, AuthCubit.get(context).token, context) :
            ProviderProfileCubit.get(context).updateProviderProfile(ProviderProfileCubit.get(context).providerProfileModel!, AuthProviderCubit.get(context).token, context);
          }, buttonText: getLang(context, 'update_data')),
                  ),
                  CustomElevatedButton(
      onTap: () {
        type=='user'?
        NavigationManager.push(Routes.forgotPassword):
        NavigationManager.push(Routes.providerForgetPassword);
      },
      buttonText:  getLang(context, 'update_password'),
      backgroundColor: whiteColor,
      borderColor: blackColor,
                  ),
                ],
              ),
    ):
      Center(child: CircularProgressIndicator(),);
  }
}
