
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/features/provider/home/logic/provider_home_cubit.dart';
import 'package:shart/features/provider/profile/logic/provider_profile_cubit.dart';
import 'package:shart/widgets/show_toast_widget.dart';

import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../user/auth/logic/auth_cubit.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav.dart';
import '../model/history_packages_model.dart';
import '../model/packages_model.dart';

abstract class BaseProviderHomeRemoteDataSource{
  Future<PackagesModel?> getPackagesProvider(BuildContext context);
  Future<dynamic> subscribePackagesProvider(String id ,BuildContext context);
  Future<HistoryPackages?> getHistoryPackagesProvider(BuildContext context);
}

class ProviderHomeRemoteDataSource implements BaseProviderHomeRemoteDataSource {
  @override
  Future<PackagesModel?> getPackagesProvider(BuildContext context)async {
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> response = await DioHelper.getData(
        url: AppApis.getPackages,
        language: cubit.localeLanguage==Locale('en')?'en':'ar',
    );
    if (PackagesModel.fromJson(response.data).success == false) {
    }
    else{
      if (response.statusCode == 200) {
        return PackagesModel.fromJson(response.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;

  }

  @override
  Future<dynamic> subscribePackagesProvider(String id ,BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    AuthProviderCubit authProviderCubit =AuthProviderCubit.get(context);
    ProviderHomeCubit providerHomeCubit =ProviderHomeCubit.get(context);
    providerHomeCubit.changeLoad(true);
    try{
      Response<dynamic> response = await DioHelper.postData(
        url: AppApis.subscribePackages,
        data: <String,dynamic>{
          'subscription_id': id,
          'payment_method': 'request'
        },
        token: authProviderCubit.token,
        language: cubit.localeLanguage==Locale('en')?'en':'ar',
      );
      if(response.data['success']==false){
        showToast(text: '${response.data['message']}', state: ToastStates.error, context: context);
      }else{
        if (response.statusCode == 200) {
          providerHomeCubit.changeLoad(false);
          ProviderProfileCubit.get(context).getProviderProfile(AuthProviderCubit.get(context).token, context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProviderBottomNavScreen(checkPage: '0',)));
          showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.success, context: context);
        }
        else {
          providerHomeCubit.changeLoad(false);
          showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
        }
      }
    }catch(e){
      providerHomeCubit.changeLoad(false);
      showToast(text: 'Sorry  you already subscibed', state: ToastStates.error, context: context);
    }
    providerHomeCubit.changeLoad(false);

  }

  @override
  Future<HistoryPackages?> getHistoryPackagesProvider(BuildContext context)async {
    AuthCubit cubit =AuthCubit.get(context);
    AuthProviderCubit authProviderCubit =AuthProviderCubit.get(context);
   try{
     Response<dynamic> response = await DioHelper.getData(
       url: AppApis.historyPackages,
       token: authProviderCubit.token,
       language: cubit.localeLanguage==Locale('en')?'en':'ar',
     );

     if (HistoryPackages.fromJson(response.data).success == false) {
     }
     else{
       if (response.statusCode == 200) {
         return HistoryPackages.fromJson(response.data);
       }
       else {
         throw 'Error';
       }
     }
   }
   catch(e){
     print(e.toString());

    }

    return null;
  }


}
