import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/shared_preference/shared_preference.dart';
import '../../logic/provider_orders_cubit.dart';
import '../models/provider_order_model.dart';

class ProviderMyOrdersRemoteDataSource {

  Future<ProviderOrderModel?> getProviderOrders(int limit ,String status,String token, BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    print('uuuuuuuuuuuuu${limit}');
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

  Future<dynamic> acceptOrder(int id , BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    Response<dynamic> res = await DioHelper.postData(
        url: AppApis.acceptOrder(id),
        token:cubit.token.isNotEmpty?cubit.token:t);
       if(res.data['success']==false){
       showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
       }else{
         if (res.statusCode == 200) {
           ProviderOrdersCubit.get(context).fetchOrdersCurrentProvider(context,10,true);
           ProviderOrdersCubit.get(context).getMyOrdersPreviousProvider(context);
           ProviderOrdersCubit.get(context).getMyOrdersCancelledProvider(context);
           Navigator.pop(context);
           showToast(text: '${res.data['message']}', state: ToastStates.success, context: context);
         }
         else {
           showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
         }
       }
    return null;
  }
  Future<dynamic> rejectOrder(int id , BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    Response<dynamic> res = await DioHelper.postData(
        url: AppApis.rejectOrder(id),
        token:cubit.token.isNotEmpty?cubit.token:t);
       if(res.data['success']==false){
       showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
       }else{
         if (res.statusCode == 200) {
           ProviderOrdersCubit.get(context).fetchOrdersCurrentProvider(context,10,true);
           ProviderOrdersCubit.get(context).getMyOrdersPreviousProvider(context);
           ProviderOrdersCubit.get(context).getMyOrdersCancelledProvider(context);
           Navigator.pop(context);
           showToast(text: '${res.data['message']}', state: ToastStates.success, context: context);
         }
         else {
           showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
         }
       }
    return null;
  }
  Future<dynamic> cancelOrder(int id , BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    Response<dynamic> res = await DioHelper.postData(
        url: AppApis.cancelOrder(id),
        token:cubit.token.isNotEmpty?cubit.token:t);
       if(res.data['success']==false){
       showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
       }else{
         if (res.statusCode == 200) {
           ProviderOrdersCubit.get(context).fetchOrdersCurrentProvider(context,10,true);
           ProviderOrdersCubit.get(context).getMyOrdersPreviousProvider(context);
           ProviderOrdersCubit.get(context).getMyOrdersCancelledProvider(context);
           Navigator.pop(context);
           showToast(text: '${res.data['message']}', state: ToastStates.success, context: context);
         }
         else {
           showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
         }
       }
    return null;
  }
  Future<dynamic> deliveredOrder(int id , BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    Response<dynamic> res = await DioHelper.postData(
        url: AppApis.deliveredOrder(id),
        token:cubit.token.isNotEmpty?cubit.token:t);
       if(res.data['success']==false){
       showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
       }else{
         if (res.statusCode == 200) {
           ProviderOrdersCubit.get(context).fetchOrdersCurrentProvider(context,10,true);
           ProviderOrdersCubit.get(context).getMyOrdersPreviousProvider(context);
           ProviderOrdersCubit.get(context).getMyOrdersCancelledProvider(context);
           Navigator.pop(context);
           showToast(text: '${res.data['message']}', state: ToastStates.success, context: context);
         }
         else {
           showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
         }
       }
    return null;
  }
  Future<dynamic> preparingOrder(int id , BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    Response<dynamic> res = await DioHelper.postData(
        url: AppApis.preparingOrder(id),
        token:cubit.token.isNotEmpty?cubit.token:t);
       if(res.data['success']==false){
       showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
       }else{
         if (res.statusCode == 200) {
           ProviderOrdersCubit.get(context).fetchOrdersCurrentProvider(context,10,true);
           ProviderOrdersCubit.get(context).getMyOrdersPreviousProvider(context);
           ProviderOrdersCubit.get(context).getMyOrdersCancelledProvider(context);
           Navigator.pop(context);
           showToast(text: '${res.data['message']}', state: ToastStates.success, context: context);
         }
         else {
           showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
         }
       }
    return null;
  }
}