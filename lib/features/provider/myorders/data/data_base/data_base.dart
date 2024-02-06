import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/shared_preference/shared_preference.dart';
import '../models/provider_order_model.dart';

class ProviderMyOrdersRemoteDataSource {

  Future<ProviderOrderModel?> getProviderOrders(int limit ,String status,String token, BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    Response<dynamic> res = await DioHelper.getData(url: AppApis.getMyOrdersProvider(limit,status),
        token: token.isNotEmpty?token:t);

    if (ProviderOrderModel.fromJson(res.data).success == false) {
      // showToast(text: '${ProviderOrderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        return ProviderOrderModel.fromJson(res.data);
      }
      else {
        // showToast(text: '${ProviderOrderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }
}