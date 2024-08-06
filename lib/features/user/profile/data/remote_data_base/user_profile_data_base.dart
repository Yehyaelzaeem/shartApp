import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/core/routing/routes.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/shared_preference/shared_preference.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../../provider/profile/data/model/about_compay_model.dart';
import '../../../../provider/profile/data/model/address_list_model.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../logic/user_profile_cubit.dart';
import '../model/compaints_message_model.dart';
import '../model/delete_account_model.dart';
import '../model/message_model.dart';
import '../model/user_profile_model.dart';

abstract class BaseUserProfileRemoteDataSource{
  Future<UserProfileModel?> getUserProfile(String token ,BuildContext context);
  Future<UserProfileModel?> updateProfile(UserProfileModel userProfileModel ,String token ,BuildContext context);
  Future<DeleteAccountModel?> deleteAccount(String token ,BuildContext context);
  Future<AboutCompanyModel?> getABoutCompanyUser(BuildContext context);
  Future<AboutCompanyModel?> getTermsAndConditionsUser(BuildContext context);
  Future<AboutCompanyModel?> getPrivacyUser(BuildContext context);
  Future<ComplaintMessageModel?> sendComplaintMessage(MessageModel messageModel ,BuildContext context);
  Future<dynamic> addAddressUser(AddressModelData addressModelData, String token, BuildContext context);
  Future<dynamic> deleteAddressUser(int id, String token, BuildContext context);
  Future<dynamic> editAddressUser(AddressModelData addressModelData, String token, BuildContext context);
  Future<dynamic> changePassword(String password,String confirmPassword, String token, BuildContext context);
  Future<AddressListModel?> getAddressListUser(String token, BuildContext context);
}

class UserProfileRemoteDataSource implements BaseUserProfileRemoteDataSource {
  @override
  Future<dynamic> addAddressUser(AddressModelData addressModelData, String token, BuildContext context) async{
    UserProfileCubit cubit =   UserProfileCubit.get(context);
    cubit.changeAddLoading(true);
    Response<dynamic> response = await DioHelper.postData(url: AppApis.addAddressUser, token: token,
        data: <String,dynamic>{
          'name':'${addressModelData.name}',
          'address':'${addressModelData.address}',
          'lat':'${addressModelData.lat}',
          'lng':'${addressModelData.lng}',
          'phone':'${addressModelData.phone}',
          'note':'${addressModelData.note}',
        }
    );
    if (response.statusCode == 200) {


      cubit.changeAddLoading(false);
      cubit.addressAddNameController.text='';
      cubit.addressAddController.text='';
      cubit.addressAddPhoneController.text='';
      cubit.addressNoteController.text='';
      cubit.long =0.0;
      cubit.lat =0.0;
      cubit.addressLocationModel=null;
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.success, context: context);
       cubit.getAddressListUser(token, context);
    }
    else {
      cubit.changeAddLoading(false);
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
    }
    cubit.changeAddLoading(false);
    return null;
  }

  @override
  Future<dynamic> deleteAddressUser(int id, String token, BuildContext context)async {
    UserProfileCubit cubit =UserProfileCubit.get(context);
    cubit.changeAddLoading(true);
    Response<dynamic> response = await DioHelper.postData(url: AppApis.deleteAddressUser(id), token: token,);
    if (response.statusCode == 200) {
      cubit.changeAddLoading(false);
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.success, context: context);
      cubit.getAddressListUser(token, context);
    }
    else {
      cubit.changeAddLoading(false);
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
    }
    cubit.changeAddLoading(false);
    return null;
  }

  @override
  Future<dynamic> editAddressUser(AddressModelData addressModelData, String token, BuildContext context) async{
    UserProfileCubit cubit =UserProfileCubit.get(context);
    cubit.changeUpdateLoading(true);
    Response<dynamic> response = await DioHelper.postData(url: AppApis.editAddressUser(addressModelData.id!), token: token,
        data: <String,dynamic>{
          'name':'${addressModelData.name}',
          'address':'${addressModelData.address}',
          'lat':'${addressModelData.lat}',
          'lng':'${addressModelData.lng}',
          'phone':'${addressModelData.phone}',
          'note':'',
        }
    );
    if (response.statusCode == 200) {
      cubit.changeUpdateLoading(false);
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.success, context: context);
      cubit.getAddressListUser(token, context);
    }
    else {
      cubit.changeUpdateLoading(false);
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
    }
    cubit.changeUpdateLoading(false);
    return null;
  }

  @override
  Future<AddressListModel?> getAddressListUser(String token, BuildContext context) async{
    Response<dynamic> res = await DioHelper.getData(url: AppApis.getAddressUser, token: token);
    if (AddressListModel.fromJson(res.data).success == false) {
       showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        // showToast(text: '${AddressListModel.fromJson(res.data).data}', state: ToastStates.success, context: context);

        return AddressListModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }



  @override
  Future<UserProfileModel?> getUserProfile(String token, BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    Response<dynamic> res = await DioHelper.getData(url: AppApis.getProfileUser, token: token.isNotEmpty?token:t);

    if (UserProfileModel.fromJson(res.data).success == false) {
      showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        // if(UserProfileModel.fromJson(res.data).data!.fcmToken ==null){
        //   String? fcmToken;
        //   FirebaseMessaging messaging = FirebaseMessaging.instance;
        //   messaging.getToken().then((String? value)async {
        //     await CacheHelper.saveDate(key: 'FcmToken', value: value);
        //     fcmToken=value;
        //     fcmToken!=null?
        //     AuthCubit.get(context).sendFCMToken(token,fcmToken!):null;
        //   });
        // }
        return UserProfileModel.fromJson(res.data);
      }
      else {
        showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }



  @override
  Future<UserProfileModel?> updateProfile(UserProfileModel userProfileModel ,String token, BuildContext context) async{
    UserProfileCubit cubit =UserProfileCubit.get(context);
    FormData? data;
    if(userProfileModel.data!.image!=null){
      data = FormData.fromMap({
        'image':
        <MultipartFile>[
          await MultipartFile.fromFile('${cubit.profileImageFile!.path}', filename: 'upload')
        ],
        'name':userProfileModel.data!.name,
        'email':userProfileModel.data!.email,
        'phone':userProfileModel.data!.phone,
        'phone_country_id':'3',
        'country_id':'1',
        'city_id':'1',
        'gender':'male',
        'birth_date':'1990-01-01',
      });

    }else{
      data = FormData.fromMap({
        // 'image':
        // <MultipartFile>[
        //   await MultipartFile.fromFile('${userProfileModel.data!.image}', filename: 'upload')
        // ],
        'name':userProfileModel.data!.name,
        'email':userProfileModel.data!.email,
        'phone':userProfileModel.data!.phone,
        'phone_country_id':'3',
        'country_id':'1',
        'city_id':'1',
        'gender':'male',
        'birth_date':'1990-01-01',
      });
    }

    cubit.changeUpdateLoading(true);
    Response<dynamic> res = await DioHelper.postData(url: AppApis.updateProfileUser,
        token: token,
       dataOption: data,
    );

    if (UserProfileModel.fromJson(res.data).success == false) {
      cubit.changeUpdateLoading(false);
      showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        cubit.getUserProfile('${AuthCubit.get(context).token}', context);
        cubit.changeUpdateLoading(false);
        showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        return UserProfileModel.fromJson(res.data);
      }
      else {

        cubit.changeUpdateLoading(false);
        showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<DeleteAccountModel?> deleteAccount(String token, BuildContext context) async{
    Response<dynamic> res = await DioHelper.postData(url: AppApis.deleteAccount,
      token: token,);

    if (DeleteAccountModel.fromJson(res.data).success == false) {
      showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        showToast(text: '${DeleteAccountModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
         NavigationManager.pushReplacement(Routes.chooseUserScreen);
        return DeleteAccountModel.fromJson(res.data);
      }
      else {
        showToast(text: '${DeleteAccountModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }


  @override
  Future<AboutCompanyModel?> getABoutCompanyUser(BuildContext context) async{
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
  Future<AboutCompanyModel?> getPrivacyUser(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(url: AppApis.privacyAndPolicyUser, language:  cubit.localeLanguage==Locale('en')?'en':'ar',);
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
  Future<AboutCompanyModel?> getTermsAndConditionsUser(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(url: AppApis.termsAndConditionUser,
      language:  cubit.localeLanguage==Locale('en')?'en':'ar',);
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
  Future<ComplaintMessageModel?> sendComplaintMessage(MessageModel messageModel, BuildContext context) async{
    UserProfileCubit.get(context).changeUpdateLoading(true);
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.postData(url: AppApis.complaintMessage,
      data: <String,dynamic>{
         'name':messageModel.name,
         'phone':messageModel.phone,
         'email':messageModel.email,
         'message':messageModel.message,
         'type':messageModel.type,
         'message_type':messageModel.message_type,
      },
      language:  cubit.localeLanguage==Locale('en')?'en':'ar',);
    if (ComplaintMessageModel.fromJson(res.data).success == false) {
      UserProfileCubit.get(context).changeUpdateLoading(false);
      showToast(text: '${ComplaintMessageModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {

        UserProfileCubit.get(context).changeUpdateLoading(false);
        UserProfileCubit.get(context).complainController.text='';
        showToast(text: '${ComplaintMessageModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        return ComplaintMessageModel.fromJson(res.data);
      }
      else {
        UserProfileCubit.get(context).changeUpdateLoading(false);
        showToast(text: '${ComplaintMessageModel.fromJson(res.data).message}', state: ToastStates.error, context: context);

        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<dynamic> changePassword(String password, String confirmPassword, String token, BuildContext context) async{
    UserProfileCubit cubit= UserProfileCubit.get(context);
   cubit.changeAddLoading(true);
    Response<dynamic> response = await DioHelper.postData(url: AppApis.changePasswordUser,
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
