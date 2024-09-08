import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../features/provider/auth/logic/auth_provider_cubit.dart';
import '../../../features/user/auth/logic/auth_cubit.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class CustomBodyRegister extends StatelessWidget {
  const CustomBodyRegister({super.key, required this.type, required this.providerCubit, required this.userCubit});
  final String type;
  final AuthProviderCubit providerCubit;
  final AuthCubit userCubit;
  @override
  Widget build(BuildContext context) {
    print(type);
    return   Column(
      children: <Widget>[
        SizedBox(height: 20.h),
        CustomTextField(
          validationFunc: (String? value){
            if(value!.isEmpty){
              return '${getLang(context, 'empty_name')}';
            }
            return null;
          },
          hintText: '${getLang(context, 'full_name')}',
          controller:  type=='user'? userCubit.registerNameController:providerCubit.registerNameControllerProvider,
          textInputType: TextInputType.name,
          prefixIcon: const Icon(Icons.person),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: CustomTextField(
            validationFunc: (String? value){
              if(value!.isEmpty){
                return '${getLang(context, 'email_empty')}';
              }
              return null;
            },
            hintText: '${getLang(context, 'email')}',
            controller:
            type=='user'? userCubit.registerEmailController:providerCubit.registerEmailControllerProvider,
            textInputType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email),
          ),
        ),
        CustomTextField(
          validationFunc: (String? val){
            if (val!.length!=11) {
              return '${getLang(context, 'sign_in_ver')}';
            }
            return null;
          },
          hintText: '${getLang(context, 'phone')}',
          controller:
          type=='user'? userCubit.registerPhoneController:providerCubit.registerPhoneControllerProvider,
          textInputType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: CustomTextField(
            validationFunc: (String? value){
              if(value!.isEmpty){
                return '${getLang(context, 'pass_empty')}';
              }
              return null;
            },
            isPassword:
            type=='user'? userCubit.regVisibility:providerCubit.regVisibility,
            prefixIcon: const Icon(Icons.lock),
            hintText: '${getLang(context, 'pass')}',
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            controller:
            type=='user'? userCubit.registerPasswordController:providerCubit.registerPasswordControllerProvider,
            suffixIcon: IconButton(
              onPressed: () {
                type=='user'? userCubit.changeRegVisibilityIcon():providerCubit.changeRegVisibilityIcon();
              },
              icon: Icon(
                  (type=='user'? userCubit.regVisibility:providerCubit.regVisibility)
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
          ),
        ),
        CustomTextField(
          validationFunc: (String? value){
            if(value!.isEmpty){
              return '${getLang(context, 'pass2_empty')}';
            }
            return null;
          },
          isPassword:
          type=='user'? userCubit.regVisibilityConfirm:providerCubit.regVisibilityConfirm,
          prefixIcon: const Icon(Icons.lock),
          hintText: '${getLang(context, 'pass_confirm')}',
          textInputType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          controller:
          type=='user'? userCubit.registerConfirmPasswordController:providerCubit.registerConfirmPasswordControllerProvider,
          suffixIcon: IconButton(
            onPressed: () {
              type=='user'? userCubit.changeRegVisibilityIconConfirm():providerCubit.changeRegVisibilityIconConfirm();
            },
            icon: Icon(
                (type=='user'? userCubit.regVisibilityConfirm:providerCubit.regVisibilityConfirm)
                ? Icons.visibility_off
                : Icons.visibility),
          ),
          onFieldSubmitted: (String value){
            type=='user'? userCubit.userRegister(context):providerCubit.providerRegister(context);
          },
        ),
        (type=='user'? userCubit.isRegLoading:providerCubit.isRegLoading)==false?
        Padding(
          padding: EdgeInsets.only(bottom: 20.h, top: 64.h),
          child: CustomElevatedButton(
              onTap: () {
                type=='user'? userCubit.userRegister(context):providerCubit.providerRegister(context);
              }, buttonText: '${getLang(context, 'create_account2')}'),
        ):
        Padding(
          padding:  EdgeInsets.only(bottom: 20.h, top: 64.h),
          child: Center(child: CircularProgressIndicator(),),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 125.h),
          child: InkWell(
            onTap: () {
              type=='user'?
              NavigationManager.pushReplacement(Routes.login):
              NavigationManager.pushReplacement(Routes.providerLogin);
            },
            child:  Text(
              '${getLang(context, 'sign_up')}',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
