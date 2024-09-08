import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shart/core/shared_preference/shared_preference.dart';
import 'package:shart/features/provider/auth/data/models/login_provider_model.dart';
import 'package:shart/features/provider/auth/data/models/register_provider_model.dart';
import 'package:shart/features/provider/auth/data/models/send_otp_provider_model.dart';
import 'package:shart/features/provider/auth/data/models/verify_account_provider_model.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../user/auth/data/models/reset_password_model.dart';
import '../../../../user/auth/data/models/verify_reset_password_model.dart';
import '../../../profile/logic/provider_profile_cubit.dart';
import '../../../profile/presentation/change_password/change_password_screen.dart';
import '../../presentation/screens/otp_provider_screen.dart';


abstract class BaseAuthProviderDataSource{
  Future<LoginProviderModel?> providerLogin(String phone,String phone_country,String password,BuildContext context);
  Future<RegisterProviderModel?> providerRegister(ProviderRegisterData registerData,String password,BuildContext context);
  Future<VerifyAccountProviderModel?> providerVerifyAccount(String code,BuildContext context);
  Future<SendOTPProviderModel?> providerSendOTP(String pass ,String phone,String phone_country_id ,BuildContext context);
  Future<ResetPasswordModel?> forgetPassword(String phone,String countryId, BuildContext context);
  Future<VerifyResetPasswordModel?> resetPassword(String code, BuildContext context);
}

class AuthProviderDataSource implements BaseAuthProviderDataSource {


  @override
  Future<LoginProviderModel?> providerLogin(String phone, String phone_country,
      String password, BuildContext context) async {
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    // cubit.loginLoadingStates(true);

   try{
     Response<dynamic> res = await DioHelper.postData(
       url: AppApis.loginProvider, data: <String, dynamic>{
       'phone': phone,
       'phone_country_id': phone_country,
       'password': password,
     },);
     if (LoginProviderModel.fromJson(res.data).success == false) {
       cubit.loginLoadingStates(false);
       showToast(text: '${LoginProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
     }
     else {
       if (res.statusCode == 200) {
         // showToast(text: '${LoginProviderModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
         cubit.loginLoadingStates(false);
         CacheHelper.saveDate(key: 'providerToken', value:  LoginProviderModel.fromJson(res.data).data!.accessToken);
         CacheHelper.saveDate(key: 'isLog', value: true);
         if(LoginProviderModel.fromJson(res.data).data?.isVerified! == false){
           providerSendOTP(password,phone, phone_country, context);
         }
         else{
           NavigationManager.pushNamedAndRemoveUntil(Routes.providerNavBar);
         }
         cubit.phoneControllerProvider.text='';
         cubit.passwordControllerProvider.text='';
         String? fcmToken;
         FirebaseMessaging messaging = FirebaseMessaging.instance;
         messaging.getToken().then((String? value)async {
           await CacheHelper.saveDate(key: 'FcmToken', value: value);
           fcmToken=value;
           fcmToken!=null?
           ProviderProfileCubit.get(context).sendFCMToken(LoginProviderModel.fromJson(res.data).data!.accessToken!.toString(),fcmToken!):null;
         });

         return LoginProviderModel.fromJson(res.data);
       }
       else {
         showToast(text: '${LoginProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
         cubit.loginLoadingStates(false);
         throw 'Error';
       }
     }
   } on DioError catch (e) {
     if(e.response?.statusCode==403){
       showToast(text: '${e.response?.data['message']}', state: ToastStates.error, context: context);
     }
     else{
       showToast(text: '${getLang(context, 'error')}', state: ToastStates.error, context: context);
     }
     cubit.loginLoadingStates(false);
   }
    cubit.changeOtpCompleted(false);
    return null;
  }


  @override
  Future<RegisterProviderModel?> providerRegister(ProviderRegisterData registerData,
      String password, BuildContext context) async {
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    // cubit.loginRegLoadingStates(true);
    Response<dynamic> response = await DioHelper.postData(
      url: AppApis.registerProvider, data: <String, dynamic>{
      'name': registerData.name,
      'email': registerData.email,
      'phone': registerData.phone,
      'phone_country_id': registerData.phoneCountry!.id ?? '3',
      'password': password,
      'terms_approved': registerData.terms_approved,
        },);
    if(response.data['success']==false){
      cubit.loginRegLoadingStates(false);
      showToast(text: '${response.data['message']}', state: ToastStates.error, context: context);
    }else{
      if (response.statusCode == 200) {
        // providerSendOTP(password,registerData.phone!.trim(), '${registerData.phoneCountry!.id ?? '3'}', context);
        showToast(text: '${getLang(context, 'account_approval')}', state: ToastStates.success, context: context);
        cubit.registerNameControllerProvider.text='';
        cubit.registerEmailControllerProvider.text='';
        cubit.registerPhoneControllerProvider.text='';
        cubit.registerPasswordControllerProvider.text='';
        cubit.registerConfirmPasswordControllerProvider.text='';
        Navigator.pop(context);
      }
      else {
        cubit.loginRegLoadingStates(false);
        showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
      }
    }
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
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('OTP Code is  : ${SendOTPProviderModel.fromJson(res.data).data!.otp}'),
        //       duration: Duration(seconds: 15),
        //       dismissDirection: DismissDirection.up,
        //       behavior: SnackBarBehavior.floating,
        //       margin: EdgeInsets.only(
        //         bottom:MediaQuery.of(context).size.height-80.h,
        //         left: 10.w,
        //         right: 10.w,
        //       ),
        //     ));
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
    if(response.data['success']==false){
      cubit.changeOtpCompleted(false);
      showToast(text: '${response.data['message']}', state: ToastStates.error, context: context);
    }else{
      if (response.statusCode == 200) {
        showToast(text: '${response.data['message']}', state: ToastStates.success, context: context);
        NavigationManager.pushNamedAndRemoveUntil(Routes.providerNavBar);

        cubit.otpCode='';
        cubit.registerNameControllerProvider.text='';
        cubit.registerEmailControllerProvider.text='';
        cubit.registerPhoneControllerProvider.text='';
        cubit.registerPasswordControllerProvider.text='';
        cubit.registerConfirmPasswordControllerProvider.text='';
      }
      else {
        cubit.changeOtpCompleted(false);
        showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
      }
    }
    return null;
  }
  @override
  Future<ResetPasswordModel?> forgetPassword(String phone,String countryId, BuildContext context) async{
    AuthProviderCubit cubit= AuthProviderCubit.get(context);
    cubit.loginLoadingStates(true);
    Response<dynamic> response = await DioHelper.postData(url: AppApis.forgetPasswordProvider,
      data: <String,dynamic>{
        'type':'phone',
        'phone':phone.trim(),
        'phone_country_id':countryId,
      },);

    if(ResetPasswordModel.fromJson(response.data).success==true){
      if (response.statusCode == 200) {
        cubit.loginLoadingStates(false);
        showToast(text: response.data['message'], state: ToastStates.success, context: context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>OtpProviderScreen(type: 'pass',otpCode: ResetPasswordModel.fromJson(response.data).data!.passwordOtp!.toString(),)));
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
    AuthProviderCubit cubit= AuthProviderCubit.get(context);
    cubit.loginLoadingStates(true);
    Response<dynamic> response = await DioHelper.postData(url: AppApis.resetPasswordProvider,
      data: <String,dynamic>{
        'otp':code.trim(),
      },);
    if(VerifyResetPasswordModel.fromJson(response.data).success==true){
      if (response.statusCode == 200) {
        showToast(text: response.data['message'], state: ToastStates.success, context: context);
        CacheHelper.saveDate(key: 'providerToken', value:  VerifyResetPasswordModel.fromJson(response.data).data!.accessToken);
        AuthProviderCubit.get(context).getToken(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ChangePasswordProviderScreen()));
        cubit.phoneController2.text='';
        cubit.loginLoadingStates(false);
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
