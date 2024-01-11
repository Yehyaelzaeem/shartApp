import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../features/provider/auth/logic/auth_provider_cubit.dart';
import '../../../features/user/auth/logic/auth_cubit.dart';
import '../../../features/user/menu/logic/menu_cubit.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class CustomBodyLogin extends StatelessWidget {
  const CustomBodyLogin({super.key, required this.type, required this.providerCubit, required this.userCubit});
 final String type;
 final AuthProviderCubit providerCubit;
  final AuthCubit userCubit;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        SizedBox(height: 20.h),
        CustomTextField(
          hintText: 'رقم الهاتف',
          controller: type=='user'? userCubit.phoneController:providerCubit.phoneControllerProvider,
          textInputType: TextInputType.phone,

          validationFunc: (String? val) {
            if (val!.length!=11) {
              return 'رقم الهاتف لا يساوي 11 رقم يجب التاكد من رقم الهاتف';
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.phone),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
          child: CustomTextField(
            validationFunc: (String? val) {
              if (val!.isEmpty) {
                return 'كلمة المرور مطلوبة';
              }
              return null;
            },
            isPassword:type=='user'? userCubit.visibility:providerCubit.visibility ,
            prefixIcon: const Icon(Icons.lock),
            hintText: 'كلمة المرور',
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            controller: type=='user'? userCubit.passwordController:providerCubit.passwordControllerProvider,
            suffixIcon: IconButton(
              onPressed: () {
                type=='user'? userCubit.changeVisibilityIcon():providerCubit.changeVisibilityIcon();
              },
              icon: Icon((type=='user'? userCubit.visibility:providerCubit.visibility) ? Icons.visibility_off : Icons.visibility),
            ),
            onFieldSubmitted: (String value){
              MenuCubit.get(context).removeBanner(type,context);
              type=='user'?
              AuthCubit.get(context).userLogin(context):
              AuthProviderCubit.get(context).providerLogin(context);
            },
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
              onTap: () =>type=='user'?  NavigationManager.push(Routes.forgotPassword):NavigationManager.push(Routes.providerForgetPassword), child: const Text('نسيت كلمة المرور ؟')),
        ),
        (type=='user'? userCubit.isLoading:providerCubit.isLoading)==false?
        Padding(
          padding: EdgeInsets.only(bottom: 20.h, top: 64.h),
          child: CustomElevatedButton(
              onTap: () {
                MenuCubit.get(context).removeBanner(type,context);
                type=='user'?
                AuthCubit.get(context).userLogin(context):
                AuthProviderCubit.get(context).providerLogin(context);
              },
              buttonText: 'تسجيل الدخول'),
        ):Padding(
          padding:  EdgeInsets.only(top:64.h,bottom: 20.h),
          child: Center(child: CircularProgressIndicator(),),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 125.h),
          child: InkWell(
            onTap: () {
              type=='user'?
              NavigationManager.pushReplacement(Routes.register):
              NavigationManager.pushReplacement(Routes.providerRegister);
            },
            child: const Text(
              'إنشاء حساب؟',
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
