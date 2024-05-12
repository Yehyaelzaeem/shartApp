import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import 'package:shart/widgets/custom_button.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../menu/logic/menu_cubit.dart';
import '../../logic/auth_cubit.dart';
import 'custom_terms_widget.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Form(
        key: cubit.registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.h,),
            Text(getLang(context, 'welcome'),
              style: TextStyles.font16BlackColor500WeightTajawal.copyWith(
                  fontFamily: FontConstants.lateefFont,
                  fontSize: 25,
                  fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 10.h,),
            CustomTextField(
              fillColor: Colors.white,
              borderColor: Colors.white,
              validationFunc: (String? value) {
                if (value!.isEmpty) {
                  return '${getLang(context, 'empty_name')}';
                }
                return null;
              },
              hintText: '${getLang(context, 'full_name')}',
              controller: cubit.registerNameController,
              textInputType: TextInputType.name,
              prefixIcon: const Icon(
                Icons.person_2_outlined, color: highGreyColor,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: CustomTextField(
                fillColor: Colors.white,
                borderColor: Colors.white,
                validationFunc: (String? value) {
                  if (value!.isEmpty) {
                    return '${getLang(context, 'email_empty')}';
                  }
                  return null;
                },
                hintText: '${getLang(context, 'email')}',
                controller: cubit.registerEmailController,
                textInputType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.email_outlined, color: highGreyColor,),
              ),
            ),
            CustomTextField(
              fillColor: Colors.white,
              borderColor: Colors.white,
              validationFunc: (String? val) {
                if (val!.length != 11) {
                  return '${getLang(context, 'sign_in_ver')}';
                }
                return null;
              },
              hintText: '${getLang(context, 'phone')}',
              controller: cubit.registerPhoneController,
              textInputType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone, color: highGreyColor,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: CustomTextField(
                fillColor: Colors.white,
                borderColor: Colors.white,
                validationFunc: (String? value) {
                  if (value!.isEmpty) {
                    return '${getLang(context, 'pass_empty')}';
                  }
                  return null;
                },
                isPassword: cubit.regVisibility,
                prefixIcon: const Icon(Icons.lock_open, color: highGreyColor,),
                hintText: '${getLang(context, 'pass')}',
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                controller:
                cubit.registerPasswordController,
                suffixIcon: IconButton(
                  onPressed: () {
                    cubit.changeRegVisibilityIcon();
                  },
                  icon: Icon(
                    (cubit.regVisibility)
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined, color: highGreyColor,),
                ),
              ),
            ),
            CustomTextField(
              fillColor: Colors.white,
              borderColor: Colors.white,
              validationFunc: (String? value) {
                if (value!.isEmpty) {
                  return '${getLang(context, 'pass2_empty')}';
                }
                return null;
              },
              isPassword:
              cubit.regVisibilityConfirm,
              prefixIcon: const Icon(Icons.lock_open, color: highGreyColor,),
              hintText: '${getLang(context, 'pass_confirm')}',
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              controller:
              cubit.registerConfirmPasswordController,
              suffixIcon: IconButton(
                onPressed: () {
                  cubit.changeRegVisibilityIconConfirm();
                },
                icon: Icon(
                  (cubit.regVisibilityConfirm)
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined, color: highGreyColor,),
              ),
              onFieldSubmitted: (String value) {
                cubit.userRegister(context);
              },
            ),
            SizedBox(height: 10.h,),
            CustomTermsWidget(),
            SizedBox(height: 40.h,),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (BuildContext context,AuthState  state) {},
              builder: (BuildContext context,AuthState state) {
                return CustomElevatedButton(
                    isLoading: state is UserRegisterLoadingState,
                    onTap: () {
                       cubit.userRegister(context);
                    }, buttonText: getLang(context, 'create_account2'));
              },
            ),
            SizedBox(height: 120.h,),

          ],
        ),
      ),
    );
  }
}
