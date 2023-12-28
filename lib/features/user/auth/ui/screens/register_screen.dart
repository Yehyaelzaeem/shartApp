import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/widgets/custom_button.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../widgets/custom_text_field.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('RegisterScreen building ===================');
    AuthCubit cubit =AuthCubit.get(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        NavigationManager.pushReplacement(Routes.login);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body:
        SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 54.h, bottom: 24.h),
                child: Image.asset(
                  ImagesManager.introduction3,
                  width: 220.sp,
                  height: 220.sp,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Text(
                    'إنشاء حساب',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontFamily: FontConstants.lateefFont,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  border: Border.all(color: greyColor),
                ),
                padding: EdgeInsets.all(16.sp),
                child:BlocConsumer<AuthCubit,AuthState>(
                  builder: (BuildContext context,AuthState state){
                    return Form(
                      key: cubit.registerFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.h),
                          CustomTextField(
                            validationFunc: (String? value){
                              if(value!.isEmpty){
                                return 'الاسم فارغ';
                              }
                              return null;
                            },
                            hintText: 'الاسم كامل',
                            controller: cubit.registerNameController,
                            textInputType: TextInputType.name,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h),
                            child: CustomTextField(
                              validationFunc: (String? value){
                                if(value!.isEmpty){
                                  return 'البريد الإلكتروني فارغ';
                                }
                                return null;
                              },
                              hintText: 'البريد الإلكتروني',
                              controller: cubit.registerEmailController,
                              textInputType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Icons.email),
                            ),
                          ),
                          CustomTextField(
                            validationFunc: (String? val){
                              if (val!.length!=11) {
                                return 'رقم الهاتف لا يساوي 11 رقم يجب التاكد من رقم الهاتف';
                              }
                              return null;
                            },
                            hintText: 'رقم الجوال',
                            controller: cubit.registerPhoneController,
                            textInputType: TextInputType.phone,
                            prefixIcon: const Icon(Icons.phone),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h),
                            child: CustomTextField(
                              validationFunc: (String? value){
                                if(value!.isEmpty){
                                  return 'كلمة المرور فارغة';
                                }
                                return null;
                              },
                              isPassword: cubit.regVisibility,
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'كلمة المرور',
                              textInputType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              controller: cubit.registerPasswordController,
                              suffixIcon: IconButton(
                                onPressed: () {
                                 cubit.changeRegVisibilityIcon();
                                },
                                icon: Icon(cubit.regVisibility
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          CustomTextField(
                            validationFunc: (String? value){
                              if(value!.isEmpty){

                                return 'كلمة المرور والتاكد من كلمة المرور ليس متطابقان';
                              }
                              return null;
                            },
                            isPassword: cubit.regVisibilityConfirm,
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'تأكيد كلمة المرور',
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            controller: cubit.registerConfirmPasswordController,
                            suffixIcon: IconButton(
                              onPressed: () {
                               cubit.changeRegVisibilityIconConfirm();
                              },
                              icon: Icon(cubit.regVisibilityConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            onFieldSubmitted: (String value){
                              cubit.userRegister(context);
                            },
                          ),
                          cubit.isRegLoading==false?
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h, top: 64.h),
                            child: CustomElevatedButton(
                                onTap: () {
                                  cubit.userRegister(context);
                                }, buttonText: 'إنشاء حساب'),
                          ):
                          Padding(
                            padding:  EdgeInsets.only(bottom: 20.h, top: 64.h),
                            child: Center(child: CircularProgressIndicator(),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 125.h),
                            child: InkWell(
                              onTap: () {
                                NavigationManager.pushReplacement(Routes.login);
                              },
                              child: const Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                    listener: (BuildContext context,AuthState state){},
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
