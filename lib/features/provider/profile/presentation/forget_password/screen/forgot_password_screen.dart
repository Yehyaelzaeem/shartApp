import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';

class ProviderForgotPasswordScreen extends StatefulWidget {
  const ProviderForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ProviderForgotPasswordScreen> createState() => _ProviderForgotPasswordScreenState();
}

class _ProviderForgotPasswordScreenState extends State<ProviderForgotPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool passwordVisibility = false;
  bool passwordConfirmVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: 'تحديث كلمة المرور',hasBackButton: true),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 30.h),
        child: Column(
          children: <Widget>[
            CustomTextField(
              hintText: 'كلمة المرور الجديدة',
              controller: passwordController,
              textInputType: TextInputType.visiblePassword,
              isPassword: passwordVisibility,
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                  icon: passwordVisibility
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      passwordVisibility = !passwordVisibility;
                    });
                  }),
            ),

            Padding(
              padding:   EdgeInsets.only(top: 20.h,bottom: 30.h),
              child: CustomTextField(
                hintText: 'تأكيد كلمة المرور الجديدة',
                controller: passwordConfirmController,
                textInputType: TextInputType.visiblePassword,
                isPassword: passwordConfirmVisibility,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: passwordConfirmVisibility
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordConfirmVisibility = !passwordConfirmVisibility;
                      });
                    }),
              ),
            ),
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomElevatedButton(onTap: (){}, buttonText: 'تأكيد'),
            )
          ],
        ),
      ),
    );
  }
}
