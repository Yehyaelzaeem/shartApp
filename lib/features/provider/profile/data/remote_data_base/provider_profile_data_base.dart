import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/core/routing/routes.dart';
import 'package:shart/core/shared_preference/shared_preference.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../../user/auth/logic/auth_cubit.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav.dart';
import '../../logic/provider_profile_cubit.dart';
import '../model/about_compay_model.dart';
import '../model/address_list_model.dart';
import '../model/address_model.dart';
import '../model/complete_model.dart';
import '../model/delete_account_model.dart';
import '../model/user_profile_model.dart';

abstract class BaseProviderProfileRemoteDataSource{
  Future<ProviderGetProfileModel?> getProviderProfile(String token ,BuildContext context);
  Future<ProviderGetProfileModel?> updateProviderProfile(ProviderGetProfileModel providerGetProfileModel ,String token ,BuildContext context);
  Future<DeleteAccountProviderModel?> deleteAccountProvider(String token ,BuildContext context);
  Future<AddressListModel?> getAddressListProvider(String token ,BuildContext context);
  Future<AddressModel?> addAddressProvider(AddressModelData addressModelData,String token ,BuildContext context);
  Future<AddressModel?> editAddressProvider(AddressModelData addressModelData ,String token ,BuildContext context);
  Future<AddressListModel?> deleteAddressProvider(int id ,String token ,BuildContext context);
  Future<AboutCompanyModel?> getABoutCompanyProvider(BuildContext context);
  Future<AboutCompanyModel?> getTermsAndConditionsProvider(BuildContext context);
  Future<dynamic> changePassword(String password,String confirmPassword, String token, BuildContext context);
  Future<AboutCompanyModel?> getPrivacyProvider(BuildContext context);
  Future<dynamic>  sendCompleteProfile(bool? isUpdate,String token ,CompleteProfileModel completeProfileModel ,BuildContext context);
  Future<dynamic> sendFCMToken(String token, String fcmToken);
}

class ProviderProfileRemoteDataSource implements BaseProviderProfileRemoteDataSource {


  @override
  Future<ProviderGetProfileModel?> getProviderProfile(String token, BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    Response<dynamic> res = await DioHelper.getData(url: AppApis.getProviderProfileUser,
        token: token.isNotEmpty?token:t);

    if (ProviderGetProfileModel.fromJson(res.data).success == false) {
      showToast(text: '${ProviderGetProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        return ProviderGetProfileModel.fromJson(res.data);
      }
      else {
        showToast(text: '${ProviderGetProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }


  @override
  Future<dynamic> sendFCMToken(String token, String fcmToken)async{

    Response<dynamic> res = await DioHelper.postData(
      token: token,
      url: AppApis.sendFCMTokenProvider, data: <String, dynamic>{
      'fcm_token': fcmToken,
    },);

    if (res.statusCode == 200) {
      print(json.encode(res.data));
    }
    else {
      print(res.statusMessage);
    }
  }

  @override
  Future<ProviderGetProfileModel?> updateProviderProfile(ProviderGetProfileModel providerGetProfileModel ,String token, BuildContext context) async{

    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
    FormData? data;
    if(providerGetProfileModel.data!.image!=null){
      data = FormData.fromMap({
        'image':
        <MultipartFile>[
          await MultipartFile.fromFile('${cubit.profileImageProviderFile!.path}', filename: 'upload')
        ],
        'name':providerGetProfileModel.data!.name,
        'email':providerGetProfileModel.data!.email,
        'phone':providerGetProfileModel.data!.phone,
        'phone_country_id':'3',
        'country_id':'1',
        'city_id':'1',
        'gender':'male',
        'birth_date':'1990-01-01',
      });

    }else{
      data = FormData.fromMap({
        'name':providerGetProfileModel.data!.name,
        'email':providerGetProfileModel.data!.email,
        'phone':providerGetProfileModel.data!.phone,
        'phone_country_id':'3',
        'country_id':'1',
        'city_id':'1',
        'gender':'male',
        'birth_date':'1990-01-01',
      });
    }

    cubit.changeUpdateLoading(true);
    Response<dynamic> res = await DioHelper.postData(url: AppApis.updateProviderProfileUser,
        token: token,
        dataOption: data,
    );

    if (ProviderGetProfileModel.fromJson(res.data).success == false) {
      cubit.changeUpdateLoading(false);
      showToast(text: '${ProviderGetProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        cubit.changeUpdateLoading(false);
        cubit.getProviderProfile('${AuthProviderCubit.get(context).token}', context);
        Navigator.of(context).pop();
        cubit.changeUpdateLoading(false);
        showToast(text: '${ProviderGetProfileModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        cubit.nameControllerProvider.text='';
        cubit.emailControllerProvider.text='';
        cubit.phoneControllerProvider.text='';
        return ProviderGetProfileModel.fromJson(res.data);
      }
      else {
        cubit.changeUpdateLoading(false);
        showToast(text: '${ProviderGetProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<DeleteAccountProviderModel?> deleteAccountProvider(String token, BuildContext context) async{
    Response<dynamic> res = await DioHelper.postData(url: AppApis.deleteAccountProvider,
      token: token,);
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);

    if (DeleteAccountProviderModel.fromJson(res.data).success == false) {
      showToast(text: '${DeleteAccountProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        showToast(text: '${DeleteAccountProviderModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
         NavigationManager.pushReplacement(Routes.chooseUserScreen);
        cubit.nameControllerProvider.text='';
        cubit.emailControllerProvider.text='';
        cubit.phoneControllerProvider.text='';
        return DeleteAccountProviderModel.fromJson(res.data);
      }
      else {
        showToast(text: '${DeleteAccountProviderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<AddressModel?> addAddressProvider(AddressModelData addressModelData, String token, BuildContext context) async{
    ProviderProfileCubit cubit =   ProviderProfileCubit.get(context);
    cubit.changeAddLoading(true);
    Response<dynamic> res = await DioHelper.postData(url: AppApis.addAddressProvider, token: token,
    data: <String,dynamic>{
      'name':'${addressModelData.name}',
      'address':'${addressModelData.address}',
      'lat':'${addressModelData.lat}',
      'lng':'${addressModelData.lng}',
      'phone':'${addressModelData.phone}',
      'note':addressModelData.note,
    }
    );
    if (AddressModel.fromJson(res.data).success == false) {
      cubit.changeAddLoading(false);
      showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        cubit.getAddressListProvider(token, context);
        showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        Navigator.of(context).pop();
        cubit.changeAddLoading(false);
        cubit.addressAddNameController.text='';
        cubit.addressAddController.text='';
        cubit.addressLocationModel=null;
        cubit.addressAddPhoneController.text='';
        return AddressModel.fromJson(res.data);
      }
      else {
        cubit.changeAddLoading(false);
        showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<AddressListModel?> deleteAddressProvider(int id, String token, BuildContext context)async {
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
    cubit.changeAddLoading(true);
    Response<dynamic> res = await DioHelper.postData(url: AppApis.deleteAddressProvider(id), token: token,);
    if (AddressListModel.fromJson(res.data).success == false) {
      showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
      cubit.changeAddLoading(false);

    }
    else{
      if (res.statusCode == 200) {
        cubit.getAddressListProvider(token, context);
        cubit.changeAddLoading(false);
        showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        // Navigator.pop(context);
        return AddressListModel.fromJson(res.data);
      }
      else {
        cubit.changeAddLoading(false);
        showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    cubit.changeAddLoading(false);

    return null;
  }

  @override
  Future<AddressModel?> editAddressProvider(AddressModelData addressModelData, String token, BuildContext context) async{
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
    cubit.changeUpdateLoading(true);
    Response<dynamic> res = await DioHelper.postData(url: AppApis.editAddressProvider(addressModelData.id!), token: token,
        data: <String,dynamic>{
          'name':'${addressModelData.name}',
          'address':'${addressModelData.address}',
          'lat':'${addressModelData.lat}',
          'lng':'${addressModelData.lng}',
          'phone':'${addressModelData.phone}',
           'note':addressModelData.note,
        }
    );
    if (AddressModel.fromJson(res.data).success == false) {
      cubit.changeUpdateLoading(false);
      showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.error, context: context);

    }
    else{
      if (res.statusCode == 200) {
        cubit.changeUpdateLoading(false);
        cubit.getAddressListProvider(token, context);
        // Navigator.pop(context);
        showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        cubit.addressNameController.text='';
        cubit.addressController.text='';
        cubit.addressPhoneController.text='';
        cubit.lat=null;
        cubit.long=null;
        return AddressModel.fromJson(res.data);
      }
      else {
        cubit.changeUpdateLoading(false);

        showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    cubit.changeUpdateLoading(false);
    return null;
  }

  @override
  Future<AddressListModel?> getAddressListProvider(String token, BuildContext context) async{
    Response<dynamic> res = await DioHelper.getData(url: AppApis.getAddressProvider, token: token);
    if (AddressListModel.fromJson(res.data).success == false) {
      // showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        return AddressListModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<AboutCompanyModel?> getABoutCompanyProvider(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(
        language:  cubit.localeLanguage==Locale('en')?'en':'ar',
        url: AppApis.aboutCompany);
    if (AboutCompanyModel.fromJson(res.data).success == false) {
      // showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        return AboutCompanyModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<AboutCompanyModel?> getPrivacyProvider(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(url: AppApis.privacyAndPolicyProvider, language:  cubit.localeLanguage==Locale('en')?'en':'ar',);
    if (AboutCompanyModel.fromJson(res.data).success == false) {
      // showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        print('${AboutCompanyModel.fromJson(res.data).data!.content}');
        return AboutCompanyModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<AboutCompanyModel?> getTermsAndConditionsProvider(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(url: AppApis.termsAndConditionProvider,
      language:  cubit.localeLanguage==Locale('en')?'en':'ar',);
    if (AboutCompanyModel.fromJson(res.data).success == false) {
      // showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        return AboutCompanyModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<dynamic> sendCompleteProfile(bool? isUpdate,String token ,CompleteProfileModel completeProfileModel ,BuildContext context) async{
    ProviderProfileCubit cubitProvider =ProviderProfileCubit.get(context);
    cubitProvider.changeUpdateLoading(true);
    FormData data = FormData.fromMap({
      'store_name': completeProfileModel.storeName,
      'commercial_registration_no': completeProfileModel.commercialRegistrationNo,
      'ipan': completeProfileModel.iPan,
      'commercial_end_date': completeProfileModel.commercialEndDate,
      'main_address': completeProfileModel.mainAddress
    });

    if (cubitProvider.pdfCompleteFile != null) {
      data.files.add(MapEntry(
        'commercial_registration_file',
        await MultipartFile.fromFile(cubitProvider.pdfCompleteFile!.path, filename: cubitProvider.pdfCompleteFile!.path),
      ));
    }
    if (cubitProvider.logoCompleteFile != null) {
      data.files.add(MapEntry(
        'logo',
        await MultipartFile.fromFile(cubitProvider.logoCompleteFile!.path, filename: cubitProvider.logoCompleteFile!.path),
      ));
    }
    if (cubitProvider.idCompleteFile != null) {
      data.files.add(MapEntry(
        'national_id_image',
        await MultipartFile.fromFile(cubitProvider.idCompleteFile!.path, filename: cubitProvider.idCompleteFile!.path),
      ));
    }
   try{
     AuthCubit cubit =AuthCubit.get(context);
     Response<dynamic> response = await DioHelper.postData(
       token: token,
       dataOption: data,
       url: AppApis.completeProfile,
       language:  cubit.localeLanguage==Locale('en')?'en':'ar',);

     if (response.statusCode == 200) {
       ProviderProfileCubit.get(context).getProviderProfile(token, context);
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProviderBottomNavScreen(checkPage: '0',)));
       showToast(text: 'successfully', state: ToastStates.success, context: context);
       ProviderProfileCubit.get(context).changeUpdateEditingLoading(false);
       cubitProvider.titleCompleteProfileController.text='';
       cubitProvider.numberCommercialCompleteProfileController.text='';
       cubitProvider.addressCompleteProfileController.text='';
       cubitProvider.iPanCompleteProfileController.text='';
       cubitProvider.dateCompleteProfileController.text='';
       cubitProvider.logoCompleteFile=null;
       cubitProvider.idCompleteFile=null;
       cubitProvider.pdfCompleteFile=null;
       cubitProvider.changeUpdateLoading(false);
     }
     else {
       cubitProvider.changeUpdateLoading(false);
       showToast(text: "sorry you can't complete profile now ,please call It", state: ToastStates.error, context: context);
     }
   }catch(e){
     cubitProvider.changeUpdateLoading(false);
     showToast(text: '$e', state: ToastStates.error, context: context);
   }

  }

  @override
  Future<dynamic> changePassword(String password, String confirmPassword, String token, BuildContext context) async{
    ProviderProfileCubit cubit= ProviderProfileCubit.get(context);
    cubit.changeAddLoading(true);
    Response<dynamic> response = await DioHelper.postData(url: AppApis.changePasswordProvider,
        data: <String,dynamic>{
          'password':password,
          'password_confirmation':confirmPassword,
        },
        token: token);

    if(response.data['success']==true){
      cubit.changeAddLoading(false);

      if (response.statusCode == 200) {
        showToast(text: response.data['message'], state: ToastStates.success, context: context);
        Navigator.of(context).pop();
        cubit.passwordController.text='';
        cubit.passwordConfirmController.text='';
      }
      else {
        showToast(text: response.data['message'], state: ToastStates.error, context: context);
      }
    }else{
      cubit.changeAddLoading(false);
      showToast(text: response.data['message'], state: ToastStates.error, context: context);
    }
    cubit.changeAddLoading(false);
  }

}
