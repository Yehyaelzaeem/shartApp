import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../favorite/logic/favorite_cubit.dart';
import '../../../menu/data/model/product_model.dart';
import '../models/mer_address.dart';
import '../models/mer_model.dart';
import '../models/mer_works_model.dart';

class MerchantsRemoteDataSource {

  Future<MerchantsModel?> getMerchants({String? name, required BuildContext context})async{
    AuthCubit cubit =AuthCubit.get(context);
    if(name==null){
      Response<dynamic> response = await DioHelper.postData(
          url: AppApis.getMerchants,
          language: cubit.localeLanguage==Locale('en')?'en':'ar',
          token: cubit.token
      );
      if (MerchantsModel.fromJson(response.data).success == false) {

      }
      else{
        if (response.statusCode == 200) {
          return MerchantsModel.fromJson(response.data);
        }
        else {
          throw 'Error';
        }
      }
    }else{
      Response<dynamic> response = await DioHelper.postData(
          url: AppApis.getMerchants,
          language: cubit.localeLanguage==Locale('en')?'en':'ar',
          token: cubit.token,
        data: <String ,dynamic>{
            'name':name
        }
      );
      if (MerchantsModel.fromJson(response.data).success == false) {

      }
      else{
        if (response.statusCode == 200) {
          return MerchantsModel.fromJson(response.data);
        }
        else {
          throw 'Error';
        }
      }
    }
    return null;
  }

  Future<MerchantsWorksModel?> getWorksMerchants(int id ,BuildContext context)async{
    AuthCubit cubit =AuthCubit.get(context);

    Response<dynamic> response = await DioHelper.getData(
        url: AppApis.getWorksMerchant(id),
        language: cubit.localeLanguage==Locale('en')?'en':'ar',
        token: cubit.token
    );
    if (MerchantsWorksModel.fromJson(response.data).success == false) {

    }
    else{
      if (response.statusCode == 200) {
        return MerchantsWorksModel.fromJson(response.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  Future<MerchantsAddressModel?> getAddressMerchants(int id ,BuildContext context)async{
    AuthCubit cubit =AuthCubit.get(context);

    Response<dynamic> response = await DioHelper.getData(
        url: AppApis.getAddressMerchant(id),
        language: cubit.localeLanguage==Locale('en')?'en':'ar',
        token: cubit.token
    );
    if (MerchantsAddressModel.fromJson(response.data).success == false) {

    }
    else{
      if (response.statusCode == 200) {
        return MerchantsAddressModel.fromJson(response.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }
  Future<UserProductModel?> getProductsMerchants(int id ,BuildContext context)async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> response = await DioHelper.getData(
        url: AppApis.getProductsMerchant(id),
        language: cubit.localeLanguage==Locale('en')?'en':'ar',
        token: cubit.token
    );
    if (UserProductModel.fromJson(response.data).success == false) {

    }
    else{
      if (response.statusCode == 200) {
        return UserProductModel.fromJson(response.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }



  Future<dynamic> addAndRemoveFavoriteMerchants(int id ,BuildContext context)async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> response = await DioHelper.postData(
        url: AppApis.addFavoriteMerchants,
        language: cubit.localeLanguage==Locale('en')?'en':'ar',
        data: <String,dynamic>{
          'provider_id':id
        },
        token: cubit.token
    );
    if(response.data['success']==true){
      if (response.statusCode == 200) {
        FavoriteCubit.get(context).getFavoriteMerProducts(context);
        showToast(text: '${response.data['message']}', state: ToastStates.success, context: context);
      }
      else {
        showToast(text: '${response.data['message']}', state: ToastStates.error, context: context);
      }
    }else{
      showToast(text: '${response.data['message']}', state: ToastStates.error, context: context);
    }

    return null;
  }

}