import 'dart:convert';

import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/shared_preference/shared_preference.dart';
import 'package:shart/features/provider/auth/data/models/login_provider_model.dart';
import 'package:shart/features/provider/auth/data/models/register_provider_model.dart';
import 'package:shart/features/provider/auth/data/models/send_otp_provider_model.dart';
import 'package:shart/features/provider/auth/data/models/verify_account_provider_model.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../presentation/screens/otp_provider_screen.dart';


abstract class BaseAuthProviderDataSource{
  Future<LoginProviderModel?> providerLogin(String phone,String phone_country,String password,BuildContext context);
  Future<RegisterProviderModel?> providerRegister(ProviderRegisterData registerData,String password,BuildContext context);
  Future<VerifyAccountProviderModel?> providerVerifyAccount(String code,BuildContext context);
  Future<SendOTPProviderModel?> providerSendOTP(String pass ,String phone,String phone_country_id ,BuildContext context);
}

class AuthProviderDataSource implements BaseAuthProviderDataSource {


  @override
  Future<LoginProviderModel?> providerLogin(String phone, String phone_country,
      String password, BuildContext context) async {
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    cubit.loginLoadingStates(true);
    Response<dynamic> res = await DioHelper.postData(
      url: AppApis.loginProvider, data: <String, dynamic>{
      'phone': phone,
      'phone_country_id': phone_country,
      'password': password,
    },);

    if (LoginProviderModel.fromJson(res.data).success == false) {
      showToast(text: '${LoginProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else {
      if (res.statusCode == 200) {
        showToast(text: '${LoginProviderModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        cubit.loginLoadingStates(false);
        CacheHelper.saveDate(key: 'providerToken', value:  LoginProviderModel.fromJson(res.data).data!.accessToken);
        CacheHelper.saveDate(key: 'isLog', value: true);
        NavigationManager.pushNamedAndRemoveUntil(Routes.providerNavBar);
        cubit.phoneControllerProvider.text='';
        cubit.passwordControllerProvider.text='';
        return LoginProviderModel.fromJson(res.data);
      }
      else {
        showToast(text: '${LoginProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        cubit.loginLoadingStates(false);
        throw 'Error';
      }
    }
    cubit.loginLoadingStates(false);
    return null;
  }


  @override
  Future<RegisterProviderModel?> providerRegister(ProviderRegisterData registerData,
      String password, BuildContext context) async {
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    cubit.loginRegLoadingStates(true);
    Response<dynamic> response = await DioHelper.postData(
      url: AppApis.registerProvider, data: <String, dynamic>{
      'name': registerData.name,
      'email': registerData.email,
      'phone': registerData.phone,
      'phone_country_id': registerData.phoneCountry!.id ?? '3',
      'password': password,
    },);

    if (response.statusCode == 200) {
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.success, context: context);
      providerSendOTP(password,registerData.phone!.trim(), '${registerData.phoneCountry!.id ?? '3'}', context);
      showToast(text: 'Success registered , but you need verify your account with OTP code ', state: ToastStates.success, context: context);
    }
    else {
      cubit.loginRegLoadingStates(false);
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
    }
    // if (RegisterProviderModel.fromJson(res.data).success == false) {
    //   cubit.loginRegLoadingStates(false);
    //   showToast(text: '${RegisterProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    // }
    // else {
    //   if (res.statusCode == 200) {
    //     providerSendOTP(password,registerData.phone!.trim(), '${registerData.phoneCountry!.id ?? '3'}', context);
    //     // showToast(text: '${RegisterModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
    //     showToast(text: 'Success registered , but you need verify your account with OTP code ', state: ToastStates.success, context: context);
    //     cubit.otpCode= RegisterProviderModel.fromJson(res.data).providerRegisterData!.otp!.trim().toString();
    //     return RegisterProviderModel.fromJson(res.data);
    //   }
    //   else {
    //     showToast(text: '${RegisterProviderModel.fromJson(res.data).message}', state:  ToastStates.error, context: context);
    //     cubit.loginRegLoadingStates(false);
    //     throw 'Error';
    //   }
    // }
    cubit.loginRegLoadingStates(false);
    return null;
  }



  @override
  Future<SendOTPProviderModel?> providerSendOTP(String pass ,String phone, String phone_country_id, BuildContext context)async{
    Response<dynamic> res = await DioHelper.postData(
      url: AppApis.sendOTPProvider, data: <String, dynamic>{
      'phone': phone,
      'phone_country_id': phone_country_id,
    },);
    if (SendOTPProviderModel.fromJson(res.data).success == false) {
      showToast(text: '${SendOTPProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else {
      if (res.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OtpProviderScreen(otpCode:'${SendOTPProviderModel.fromJson(res.data).data!.otp}' ,)));
        AuthProviderCubit.get(context).loginRegLoadingStates(false);
        // NavigationManager.pushReplacement(Routes.providerOtpScreen);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OTP Code is  : ${SendOTPProviderModel.fromJson(res.data).data!.otp}'),
              duration: Duration(seconds: 15),
              dismissDirection: DismissDirection.up,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom:MediaQuery.of(context).size.height-80.h,
                left: 10.w,
                right: 10.w,
              ),
            ));
        // providerLogin(phone,'3',pass,context);
        return SendOTPProviderModel.fromJson(res.data);
      }
      else {
        showToast(text: '${SendOTPProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<VerifyAccountProviderModel?> providerVerifyAccount(String code, BuildContext context) async{
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    cubit.changeOtpCompleted(true);
    Response<dynamic> response = await DioHelper.postData(
      url: AppApis.verifyAccountProvider, data: <String, dynamic>{
      'otp': code,
    },);
    if (response.statusCode == 200) {
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.success, context: context);
      cubit.changeOtpCompleted(false);
      providerLogin(cubit.registerPhoneControllerProvider.text,
          '3', cubit.registerConfirmPasswordControllerProvider.text, context);
      cubit.otpCode='';
      cubit.registerNameControllerProvider.text='';
      cubit.registerEmailControllerProvider.text='';
      cubit.registerPhoneControllerProvider.text='';
      cubit.registerPasswordControllerProvider.text='';
      cubit.registerConfirmPasswordControllerProvider.text='';
    }
    else {
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
    }
    // if (VerifyAccountProviderModel.fromJson(res.data).success == false) {
    //   cubit.changeOtpCompleted(false);
    //   showToast(text: '${VerifyAccountProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    // }
    // else {
    //   if (res.statusCode == 200) {
    //     showToast(text: '${VerifyAccountProviderModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
    //     cubit.changeOtpCompleted(false);
    //      providerLogin(cubit.registerPhoneControllerProvider.text,
    //          '3', cubit.registerConfirmPasswordControllerProvider.text, context);
    //     // NavigationManager.pushReplacement(Routes.providerNavBar);
    //     cubit.otpCode='';
    //     cubit.registerNameControllerProvider.text='';
    //     cubit.registerEmailControllerProvider.text='';
    //     cubit.registerPhoneControllerProvider.text='';
    //     cubit.registerPasswordControllerProvider.text='';
    //     cubit.registerConfirmPasswordControllerProvider.text='';
    //     return VerifyAccountProviderModel.fromJson(res.data);
    //   }
    //   else {
    //     showToast(text: '${VerifyAccountProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    //     cubit.changeOtpCompleted(false);
    //     throw 'Error';
    //   }
    // }
    cubit.changeOtpCompleted(false);
    return null;
  }
}
