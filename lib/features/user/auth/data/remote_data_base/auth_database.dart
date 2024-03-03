import 'dart:convert';

import 'package:dio/src/response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shart/core/shared_preference/shared_preference.dart';
import 'package:shart/features/user/auth/data/models/verify_account_model.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../profile/presentation/change_password/change_password_screen.dart';
import '../../logic/auth_cubit.dart';
import '../../ui/screens/verify_account_screen.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/reset_password_model.dart';
import '../models/send_otp_model.dart';
import '../models/verify_reset_password_model.dart';


abstract class BaseAuthDataSource{
  Future<LoginModel?> userLogin(String phone,String phone_country,String password,BuildContext context);
  Future<RegisterModel?> userRegister(RegisterData registerData,String password,BuildContext context);
  Future<VerifyAccountModel?> verifyAccount(String code,BuildContext context);
  Future<SendOTPModel?> sendOTP(String phone,String phone_country_id ,BuildContext context);
  Future<dynamic> sendFCMToken(String token, String fcmToken);
  Future<ResetPasswordModel?> forgetPassword(String phone,String countryId, BuildContext context);
  Future<VerifyResetPasswordModel?> resetPassword(String code, BuildContext context);

}

class AuthDataSource implements BaseAuthDataSource {


  @override
  Future<LoginModel?> userLogin(String phone, String phone_country,
      String password, BuildContext context) async {
    AuthCubit.get(context).loginLoadingStates(true);
    Response<dynamic> res = await DioHelper.postData(
      url: AppApis.loginUser, data: <String, dynamic>{
      'phone': phone,
      'phone_country_id': phone_country,
      'password': password,
    },);
    if (LoginModel
        .fromJson(res.data)
        .success == false) {
      showToast(text: '${LoginModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else {
      if (res.statusCode == 200) {
        AuthCubit.get(context).loginLoadingStates(false);
        AuthCubit.get(context).token=  '${LoginModel.fromJson(res.data).data!.accessToken}';
        CacheHelper.saveDate(key: 'token', value:  LoginModel.fromJson(res.data).data!.accessToken);
        CacheHelper.saveDate(key: 'isLog', value: true);
        AuthCubit.get(context).getToken(context);
        NavigationManager.pushNamedAndRemoveUntil(Routes.home);
        String? fcmToken;
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        messaging.getToken().then((String? value)async {
          await CacheHelper.saveDate(key: 'FcmToken', value: value);
          fcmToken=value;
          fcmToken!=null?
          AuthCubit.get(context).sendFCMToken(LoginModel.fromJson(res.data).data!.accessToken!,fcmToken!):null;
        });
        AuthCubit.get(context).phoneController.text='';
        AuthCubit.get(context).passwordController.text='';
        return LoginModel.fromJson(res.data);
      }
      else {
        showToast(text: '${LoginModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        AuthCubit.get(context).loginLoadingStates(false);
        throw 'Error';
      }
    }
    AuthCubit.get(context).loginLoadingStates(false);
    AuthCubit.get(context).changeOtpCompleted(false);
    return null;
  }


  @override
  Future<RegisterModel?> userRegister(RegisterData registerData,
      String password, BuildContext context) async {
    AuthCubit cubit = AuthCubit.get(context);
    AuthCubit.get(context).loginRegLoadingStates(true);
    Response<dynamic> res = await DioHelper.postData(
      url: AppApis.registerUser, data: <String, dynamic>{
      'name': registerData.name,
      'email': registerData.email,
      'phone': registerData.phone,
      'phone_country_id': registerData.phoneCountryRegisterModel!.id ?? '3',
      'country_id': registerData.countryDataRegisterModel!.id ?? '1',
      'city_id': registerData.cityDataRegisterModel!.id ?? '1',
      'password': password,
      'gender': registerData.gender,
      'birth_date': registerData.birth_date,
    },);

    if (RegisterModel.fromJson(res.data).success == false) {
      AuthCubit.get(context).loginRegLoadingStates(false);
      showToast(text: '${RegisterModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else {
      if (res.statusCode == 200) {
        showToast(text: 'Success registered , but you need verify your account with OTP code ', state: ToastStates.success, context: context);
        sendOTP(registerData.phone!.trim(), '${registerData.phoneCountryRegisterModel!.id ?? '3'}', context);
        // cubit.otpCode= RegisterModel.fromJson(res.data).registerData!.otp!.trim().toString();
        return RegisterModel.fromJson(res.data);
      }
      else {
        showToast(text: '${RegisterModel.fromJson(res.data).message}', state:  ToastStates.error, context: context);
        cubit.loginRegLoadingStates(false);
        throw 'Error';
      }
    }
     cubit.loginRegLoadingStates(false);
    return null;
  }



  @override
  Future<SendOTPModel?> sendOTP(String phone, String phone_country_id, BuildContext context)async{
    Response<dynamic> res = await DioHelper.postData(
      url: AppApis.sendOTPUser, data: <String, dynamic>{
      'phone': phone,
      'phone_country_id': phone_country_id,
    },);

    if (SendOTPModel.fromJson(res.data).success == false) {
      showToast(text: '${SendOTPModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else {
      if (res.statusCode == 200) {
        // NavigationManager.pushReplacement(Routes.otpScreen);

        Navigator.pushReplacement(context, MaterialPageRoute(builder:
            (BuildContext context)=>VerifyAccountScreen(otpCode:'${SendOTPModel.fromJson(res.data).data!.otp}' ,)));
        AuthCubit.get(context).loginRegLoadingStates(false);
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('OTP Code is  : ${SendOTPModel.fromJson(res.data).data!.otp}'),
        //       duration: Duration(seconds: 15),
        //       dismissDirection: DismissDirection.up,
        //       behavior: SnackBarBehavior.floating,
        //       margin: EdgeInsets.only(
        //         bottom:MediaQuery.of(context).size.height-80.h,
        //         left: 10.w,
        //         right: 10.w,
        //       ),
        //     ));

        return SendOTPModel.fromJson(res.data);
      }
      else {
        showToast(text: '${SendOTPModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }


  @override
  Future<VerifyAccountModel?> verifyAccount(String code, BuildContext context) async{
    AuthCubit.get(context).changeOtpCompleted(true);
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.postData(
      url: AppApis.verifyAccountUser, data: <String, dynamic>{
      'otp': code,
    },);
    if (VerifyAccountModel.fromJson(res.data).success == false) {
      AuthCubit.get(context).changeOtpCompleted(false);
      showToast(text: '${VerifyAccountModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else {
      if (res.statusCode == 200) {
        showToast(text: 'successfully verification', state: ToastStates.success, context: context);
         userLogin(cubit.registerPhoneController.text.trim(), '3', cubit.registerConfirmPasswordController.text.trim(), context);
        // NavigationManager.pushReplacement(Routes.home);
        cubit.registerNameController.text='';
        cubit.registerEmailController.text='';
        cubit.registerPhoneController.text='';
        cubit.registerPasswordController.text='';
        cubit.registerConfirmPasswordController.text='';
        AuthCubit.get(context).otpCode='';
        return VerifyAccountModel.fromJson(res.data);
      }
      else {
        showToast(text: '${VerifyAccountModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        AuthCubit.get(context).changeOtpCompleted(false);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<dynamic> sendFCMToken(String token, String fcmToken)async{
    Response<dynamic> res = await DioHelper.postData(
      token: token,
      url: AppApis.sendFCMToken, data: <String, dynamic>{
      'fcm_token': fcmToken,
    },);
    if (res.statusCode == 200) {
    }
    else {
    }
  }

  @override
  Future<ResetPasswordModel?> forgetPassword(String phone,String countryId, BuildContext context) async{
    AuthCubit cubit= AuthCubit.get(context);
    cubit.loginLoadingStates(true);
    Response<dynamic> response = await DioHelper.postData(url: AppApis.forgetPassword,
        data: <String,dynamic>{
          'type':'phone',
          'phone':phone.trim(),
          'phone_country_id':countryId,
        },);

    if(ResetPasswordModel.fromJson(response.data).success==true){
      if (response.statusCode == 200) {
        cubit.loginLoadingStates(false);
        showToast(text: response.data['message'], state: ToastStates.success, context: context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>VerifyAccountScreen(type: 'pass',otpCode: ResetPasswordModel.fromJson(response.data).data!.passwordOtp!.toString(),)));
        return ResetPasswordModel.fromJson(response.data);
      }
      else {
        showToast(text: response.data['message'], state: ToastStates.error, context: context);
      }

    }else{
      cubit.loginLoadingStates(false);
      showToast(text: response.data['message'], state: ToastStates.error, context: context);
    }
    cubit.loginLoadingStates(false);
    return null;
  }

  @override
  Future<VerifyResetPasswordModel?> resetPassword(String code, BuildContext context) async{
    AuthCubit cubit= AuthCubit.get(context);
    cubit.loginLoadingStates(true);
    Response<dynamic> response = await DioHelper.postData(url: AppApis.resetPassword,
      data: <String,dynamic>{
        'otp':code.trim(),
      },);
    if(VerifyResetPasswordModel.fromJson(response.data).success==true){
      if (response.statusCode == 200) {
        cubit.loginLoadingStates(false);
        showToast(text: response.data['message'], state: ToastStates.success, context: context);

        AuthCubit.get(context).token=  '${VerifyResetPasswordModel.fromJson(response.data).data!.accessToken}';
        CacheHelper.saveDate(key: 'token', value:  VerifyResetPasswordModel.fromJson(response.data).data!.accessToken);
        AuthCubit.get(context).getToken(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ChangePasswordScreen()));
        cubit.phoneController2.text='';
        return VerifyResetPasswordModel.fromJson(response.data);
      }
      else {
        showToast(text: response.data['message'], state: ToastStates.error, context: context);
      }

    }else{
      cubit.loginLoadingStates(false);
      showToast(text: response.data['message'], state: ToastStates.error, context: context);
    }
    cubit.loginLoadingStates(false);
    return null;
  }
  }


