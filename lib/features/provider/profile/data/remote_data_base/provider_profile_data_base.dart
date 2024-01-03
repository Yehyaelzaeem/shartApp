import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/core/routing/routes.dart';
import 'package:shart/core/shared_preference/shared_preference.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../../user/auth/logic/auth_cubit.dart';
import '../../logic/provider_profile_cubit.dart';
import '../model/about_compay_model.dart';
import '../model/address_list_model.dart';
import '../model/address_model.dart';
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
  Future<AboutCompanyModel?> getPrivacyProvider(BuildContext context);

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
  Future<ProviderGetProfileModel?> updateProviderProfile(ProviderGetProfileModel providerGetProfileModel ,String token, BuildContext context) async{

    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
    FormData data = FormData.fromMap({
      'image':cubit.profileImageProviderFile !=null?
              <MultipartFile>[
                await MultipartFile.fromFile('${cubit.profileImageProviderFile!.path}', filename: 'upload')
              ]
          :null,
      'name':providerGetProfileModel.data!.name,
      'email':providerGetProfileModel.data!.email,
      'phone':providerGetProfileModel.data!.phone,
      'phone_country_id':'3',
      'country_id':'1',
      'city_id':'1',
      'gender':'male',
      'birth_date':'1990-01-01',
    });
    cubit.changeUpdateLoading(true);
    Response<dynamic> res = await DioHelper.postData(url: AppApis.updateProviderProfileUser,
        token: token,
        dataOption: data,
    );

    if (ProviderGetProfileModel.fromJson(res.data).success == false) {
      print('action');

      cubit.changeUpdateLoading(false);
      showToast(text: '${ProviderGetProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        print('don');

        cubit.changeUpdateLoading(false);
        cubit.getProviderProfile('${AuthProviderCubit.get(context).token}', context);
        cubit.changeUpdateLoading(false);
        showToast(text: '${ProviderGetProfileModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        return ProviderGetProfileModel.fromJson(res.data);
      }
      else {
        print('e=nd');

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
         NavigationManager.pushReplacement(Routes.providerLogin);
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
    Response<dynamic> res = await DioHelper.postData(url: AppApis.addAddressProvider, token: token,
    data: <String,dynamic>{
      'name':'${addressModelData.name}',
      'address':'${addressModelData.address}',
      'lat':'123456',
      'lng':'123',
      'phone':'${addressModelData.phone}',
      'note':'',
    }
    );
    if (AddressModel.fromJson(res.data).success == false) {
       showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        getAddressListProvider(token, context);
        showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        return AddressModel.fromJson(res.data);
      }
      else {
        showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<AddressListModel?> deleteAddressProvider(int id, String token, BuildContext context)async {
    Response<dynamic> res = await DioHelper.postData(url: AppApis.deleteAddressProvider(id), token: token,);
    if (AddressListModel.fromJson(res.data).success == false) {
      showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);

    }
    else{
      if (res.statusCode == 200) {
        showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        Navigator.pop(context);
        return AddressListModel.fromJson(res.data);
      }
      else {
        showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<AddressModel?> editAddressProvider(AddressModelData addressModelData, String token, BuildContext context) async{
    Response<dynamic> res = await DioHelper.postData(url: AppApis.editAddressProvider(addressModelData.id!), token: token,
        data: <String,dynamic>{
          'name':'${addressModelData.name}',
          'address':'${addressModelData.address}',
          'lat':'${addressModelData.lat}',
          'lng':'${addressModelData.lng}',
          'phone':'${addressModelData.phone}',
           'note':'',
        }
    );
    if (AddressModel.fromJson(res.data).success == false) {
      showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        Navigator.pop(context);
        showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        return AddressModel.fromJson(res.data);
      }
      else {
        showToast(text: '${AddressModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
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


}
