import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../model/myorder_model.dart';

abstract class BaseMyOrderRemoteDataSource {
  Future<MyOrdersModel?> getMyOrder(String token ,BuildContext context);

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

}