import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';

import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../model/check_car_model.dart';
import '../model/myorder_model.dart';

abstract class BaseMyOrderRemoteDataSource {
  Future<MyOrdersModel?> getMyOrder(String token ,BuildContext context);
  Future<GetCheckCarsModel?> getMyCheckCars(BuildContext context);

}
class MyOrderRemoteDataSource implements BaseMyOrderRemoteDataSource{
  @override
  Future<MyOrdersModel?> getMyOrder(String token, BuildContext context) async{
    Response<dynamic> response = await DioHelper.getData(
        url: AppApis.getMyOrder, token: token,);

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }
    if (MyOrdersModel.fromJson(response.data).success == false) {
     // showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (response.statusCode == 200) {
        // showToast(text: '${AddressListModel.fromJson(res.data).data}', state: ToastStates.success, context: context);
        return MyOrdersModel.fromJson(response.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<GetCheckCarsModel?> getMyCheckCars(BuildContext context)async {
    AuthCubit cubit =    AuthCubit.get(context);
    Response<dynamic> response = await DioHelper.getData(
      language: cubit.localeLanguage==Locale('en')?'en':'ar',
      url: AppApis.getCheckCars, token: cubit.token,);
    if (GetCheckCarsModel.fromJson(response.data).success == false) {
      // showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (response.statusCode == 200) {
        // showToast(text: '${AddressListModel.fromJson(res.data).data}', state: ToastStates.success, context: context);
        return GetCheckCarsModel.fromJson(response.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
    }
  }