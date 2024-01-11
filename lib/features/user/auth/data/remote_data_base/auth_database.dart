import 'package:dio/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/shared_preference/shared_preference.dart';
import 'package:shart/features/user/auth/data/models/verify_account_model.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../logic/auth_cubit.dart';
import '../../ui/screens/verify_account_screen.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/send_otp_model.dart';


abstract class BaseAuthDataSource{
  Future<LoginModel?> userLogin(String phone,String phone_country,String password,BuildContext context);
  Future<RegisterModel?> userRegister(RegisterData registerData,String password,BuildContext context);
  Future<VerifyAccountModel?> verifyAccount(String code,BuildContext context);
  Future<SendOTPModel?> sendOTP(String phone,String phone_country_id ,BuildContext context);
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
        showToast(text: '${LoginModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        AuthCubit.get(context).loginLoadingStates(false);
        AuthCubit.get(context).token=  '${LoginModel.fromJson(res.data).data!.accessToken}';
        CacheHelper.saveDate(key: 'token', value:  LoginModel.fromJson(res.data).data!.accessToken);
        CacheHelper.saveDate(key: 'isLog', value: true);
        AuthCubit.get(context).getToken(context);
        NavigationManager.pushReplacement(Routes.home);
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
      showToast(text: '${RegisterModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else {
      if (res.statusCode == 200) {
        sendOTP(registerData.phone!.trim(), '${registerData.phoneCountryRegisterModel!.id ?? '3'}', context);
        // showToast(text: '${RegisterModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        showToast(text: 'Success registered , but you need verify your account with OTP code ', state: ToastStates.success, context: context);
        cubit.otpCode= RegisterModel.fromJson(res.data).registerData!.otp!.trim().toString();
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
        NavigationManager.pushReplacement(Routes.otpScreen);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VerifyAccountScreen(otpCode:'${SendOTPModel.fromJson(res.data).data!.otp}' ,)));
        AuthCubit.get(context).loginRegLoadingStates(false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OTP Code is  : ${SendOTPModel.fromJson(res.data).data!.otp}'),
              duration: Duration(seconds: 15),
              dismissDirection: DismissDirection.up,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom:MediaQuery.of(context).size.height-80.h,
                left: 10.w,
                right: 10.w,
              ),
            ));

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
      showToast(text: '${VerifyAccountModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else {
      if (res.statusCode == 200) {
        showToast(text: '${VerifyAccountModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        userLogin(cubit.registerPhoneController.text, '3', cubit.registerConfirmPasswordController.text, context);
        AuthCubit.get(context).changeOtpCompleted(false);
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
    AuthCubit.get(context).changeOtpCompleted(false);
    return null;
  }




}
