import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';

import '../../../../../../core/resources/assets_menager.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../logic/user_profile_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfileCubit cubit =UserProfileCubit.get(context);
    return WillPopScope(
      onWillPop:(){
        UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token}', context);
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 80.h),
            child: CustomAppBar(title: getLang(context, 'edite_profile'), hasBackButton: true,
            onTap: (){
                UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token}', context);
                Navigator.pop(context);
            },
            )),
        body:
        BlocConsumer<UserProfileCubit,UserProfileState>(
          builder: (BuildContext context, Object? state) {
            return UserProfileCubit.get(context).isUpdateLoading==false?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, bottom: 32.h),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        cubit.userProfileModel !=null?
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child:
                          cubit.profileImageFile !=null?
                          CircleAvatar(
                              radius:60,
                              backgroundImage:
                              FileImage(cubit.profileImageFile!)
                          ):
                          CircleAvatar(
                              radius:60,
                              backgroundImage:
                              NetworkImage('${cubit.userProfileModel!.data!.image}')
                          ),
                        ) :
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                              radius:60,
                              backgroundImage:
                              NetworkImage(ImagesManager.testLogo)
                          ),),
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade200,
                          child: IconButton(
                            onPressed: () {
                              cubit.uploadImage();
                            },
                            icon: Icon(Icons.camera_alt_outlined,color: Colors.white,size: 23,),
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomTextField(
                    prefixIcon: Icon(Icons.person),
                    hintText: '${cubit.userProfileModel!.data!.name}',
                    controller: cubit.nameController,
                    textInputType: TextInputType.name,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: CustomTextField(
                      hintText: '${cubit.userProfileModel!.data!.email}',
                      prefixIcon: Icon(Icons.email),
                      controller: cubit.emailController,
                    ),
                  ),
                  CustomTextField(
                    hintText: '${cubit.userProfileModel!.data!.phone}',
                    controller: cubit.phoneController,
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
                          UserProfileCubit.get(context).updateUserProfile(
                              UserProfileCubit.get(context).userProfileModel!, AuthCubit.get(context).token, context);
                        }, buttonText: getLang(context, 'update_data')),
                  ),

                  CustomElevatedButton(
                    onTap: () {
                      NavigationManager.push(Routes.forgotPassword);
                    },
                    buttonText: getLang(context, 'update_password'),
                    backgroundColor: whiteColor,
                    borderColor: blackColor,
                  )
                ],
              ),
            ):Center(child: CircularProgressIndicator(),);
          },
          listener: (BuildContext context, Object? state) {  },
        ),
      ),
    );
  }
}
