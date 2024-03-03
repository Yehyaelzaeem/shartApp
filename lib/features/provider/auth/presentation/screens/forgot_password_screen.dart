import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../logic/auth_provider_cubit.dart';
import 'login_provider_screen.dart';

class ForgotPasswordProviderScreen extends StatelessWidget {
  const ForgotPasswordProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar(
            title: getLang(context, 'reset_password'), hasBackButton: true),
      ),
      body: BlocConsumer<AuthProviderCubit, AuthProviderState>(
        listener: (BuildContext context, AuthProviderState state) {},
        builder: (BuildContext context, AuthProviderState state) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30.h,),
                Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    child: SvgPicture.asset(IconsManager.otp2)),
                SizedBox(height: 45.h,),
                Text('${getLang(context, 'number_phone')}',
                style: TextStyle(
                  fontWeight: FontWeightManager.bold,
                  fontSize: 22.sp,
                  fontFamily: FontConstants.lateefFont,
                  color: blackColor,
                ),
                ),
                SizedBox(height: 10.h,),
                CustomTextField(
                  hintText: getLang(context, 'phone'),
                  controller: cubit.phoneController2,
                  textInputType: TextInputType.number,
                  prefixIcon: Icon(Icons.phone),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (String val){
                    AuthProviderCubit.get(context).forgetPassword(context);
                  },
                ),
                SizedBox(height: 40.h,),
                cubit.isLoading==true?Center(child: CircularProgressIndicator(),):
                CustomElevatedButton(
                    onTap: () {
                      AuthProviderCubit.get(context).forgetPassword(context);
                    }, buttonText: getLang(context, 'send'))
              ],
            ),
          );
        },
      ),
    );
  }
}
