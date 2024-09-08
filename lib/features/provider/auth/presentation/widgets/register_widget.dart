import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import 'package:shart/widgets/custom_button.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../logic/auth_provider_cubit.dart';
import 'custom_terms_widget.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProviderCubit cubit = AuthProviderCubit.get(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Form(
        key: cubit.registerFormKeyProvider,
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
              controller: cubit.registerNameControllerProvider,
              textInputType: TextInputType.name,
              prefixIcon: const Icon(
                Icons.person_2_outlined, color: highGreyColor,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
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
                controller: cubit.registerEmailControllerProvider,
                textInputType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.email_outlined, color: highGreyColor,),
              ),
            ),
            CustomTextField(
              fillColor: Colors.white,
              borderColor: Colors.white,
              validationFunc: (String? val) {
                // if (val!.length != 11) {
                //   return '${getLang(context, 'sign_in_ver')}';
                // }
                if (val!.isEmpty) {
                  return '${getLang(context, 'this_field_required')}';
                }
                return null;
              },
              hintText: '${getLang(context, 'phone')}',
              controller: cubit.registerPhoneControllerProvider,
              textInputType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone, color: highGreyColor,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
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
                cubit.registerPasswordControllerProvider,
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
              cubit.registerConfirmPasswordControllerProvider,
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
                cubit.providerRegister(context);
              },
            ),
            SizedBox(height: 10.h,),
            CustomTermsWidgetProvider(),
            SizedBox(height: 30.h,),
            BlocConsumer<AuthProviderCubit, AuthProviderState>(
              listener: (BuildContext context,AuthProviderState  state) {},
              builder: (BuildContext context,AuthProviderState state) {
                return CustomElevatedButton(
                    isLoading: state is ProviderUserRegisterLoadingState,
                    onTap: () {
                      cubit.providerRegister(context);
                    }, buttonText: getLang(context, 'create_account2'));
              },
            ),
            SizedBox(height: 100.h,),

          ],
        ),
      ),
    );
  }
}
