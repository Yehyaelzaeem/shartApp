import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';

import '../../logic/user_profile_cubit.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    UserProfileCubit cubit =UserProfileCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar(title: getLang(context, 'update_password'),hasBackButton: true),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 30.h),
        child: BlocConsumer<UserProfileCubit, UserProfileState>(
            listener: (BuildContext context, UserProfileState state) {
            },
            builder: (BuildContext context, UserProfileState state) {
              return Column(
                    children: <Widget>[
                      CustomTextField(
                        hintText: getLang(context, 'new_password'),
                        controller:cubit.passwordController,
                        textInputType: TextInputType.visiblePassword,
                        isPassword: cubit.passwordVisibility,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: cubit.passwordVisibility
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              cubit.changePasswordVisibility(!cubit.passwordVisibility);
                              // setState(() {
                              //   passwordVisibility = !passwordVisibility;
                              // });
                            }),
                      ),
                      Padding(
                        padding:   EdgeInsets.only(top: 20.h,bottom: 30.h),
                        child: CustomTextField(
                          hintText:getLang(context, 'sure_new_password'),
                          controller: cubit.passwordConfirmController,
                          textInputType: TextInputType.visiblePassword,
                          isPassword: cubit.passwordConfirmVisibility,
                          prefixIcon: Icon(Icons.lock),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (String val){
                            cubit.changePassword(context);
                          },
                          suffixIcon: IconButton(
                              icon:cubit.passwordConfirmVisibility
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                cubit.changePasswordConfirmVisibility(!cubit.passwordConfirmVisibility);
                              }),
                        ),
                      ),
                      Padding(
                        padding:   EdgeInsets.symmetric(horizontal: 16.w),
                        child:
                       cubit.isAddLoading==true?Center(child: CircularProgressIndicator(),):
                       CustomElevatedButton(onTap: (){
                          cubit.changePassword(context);
                        }, buttonText: getLang(context, 'sure')),
                      )
                    ],
                  );
            },
        ),
      ),
    );
  }
}
