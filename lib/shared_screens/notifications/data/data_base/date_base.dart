import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';

import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../logic/notification_cubit.dart';
import '../models/notificationModel.dart';
import '../models/single_order_model.dart';

class RemoteNotificationDataSource{
  Future<NotificationModel?> getNotification(int limit ,String type ,String token, BuildContext context) async{
    print('type : ${type}');
    print('type : ${limit}');
   NotificationCubit cubit =NotificationCubit.get(context);
    cubit.loading = true;
    cubit.changeState();
    try{
      Response<dynamic> res = await DioHelper.getData(url:
      type=='user'?
      AppApis.getUserNotification(limit):
      AppApis.getProviderNotification(limit),
          language: AuthCubit.get(context).localeLanguage==Locale('en')?'en':'ar',
          token: token);
      if (NotificationModel.fromJson(res.data).success == false) {
        // showToast(text: '${NotificationModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
      }
      else{
        if (res.statusCode == 200) {
          return NotificationModel.fromJson(res.data);
        }
        else {
          // showToast(text: '${NotificationModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
          throw 'Error';
        }
      }
    }catch(e){
      cubit.loading = false;
      cubit.changeState();
    }
    cubit.loading = false;
    cubit.changeState();
    return null;
  }
  Future<SingleOrderModel?> getSingleOrder(String type,int id ,String token, BuildContext context) async{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  Center(child: CircularProgressIndicator());
      },
    );
    Response<dynamic> res = await DioHelper.getData(url:
    type=='user'?
    AppApis.getSingleOrder(id):
    AppApis.getSingleOrderProvider(id),
        language: AuthCubit.get(context).localeLanguage==Locale('en')?'en':'ar',
        token: token);
    if (SingleOrderModel.fromJson(res.data).success == false) {

      Navigator.of(context).pop();
      showToast(text: '${SingleOrderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        Navigator.of(context).pop();
        return SingleOrderModel.fromJson(res.data);
      }
      else {
        Navigator.of(context).pop();
        showToast(text: '${SingleOrderModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    Navigator.of(context).pop();
    return null;
  }

}