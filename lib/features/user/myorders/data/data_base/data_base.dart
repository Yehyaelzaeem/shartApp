import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/shared_preference/shared_preference.dart';
import '../../../../../shared_screens/web_view/custom_web_view_screen.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../../logic/my_orders_cubit.dart';
import '../model/check_car_model.dart';
import '../model/my_supplies_model.dart';
import '../model/myorder_model.dart';

abstract class BaseMyOrderRemoteDataSource {
  Future<MyOrdersModel?> getMyOrder(int limit,String token ,BuildContext context);
  Future<GetCheckCarsModel?> getMyCheckCars(BuildContext context);
  Future<dynamic> cancelOrderUser(int id ,BuildContext context);
  Future<String> payment(int id ,String methodPayment,BuildContext context);
  Future<MySuppliesModel?> getMySupplies(int limit ,BuildContext context);
  Future<dynamic> paySuppliesOrder(int id ,BuildContext context);
}
class MyOrderRemoteDataSource implements BaseMyOrderRemoteDataSource{
  @override
  Future<MyOrdersModel?> getMyOrder(int limit,String token, BuildContext context) async{
    print('77777777777777');

    Response<dynamic> response = await DioHelper.getData(
        url: AppApis.getMyOrder(limit), token: token,);
    print('555555555555555');

    var x = MyOrdersModel.fromJson(response.data);
    print('666666666666666666666');

    if (response.statusCode == 200) {
        print('yehyasdss ${x}');
        print('yehyasdss }');
        return MyOrdersModel.fromJson(response.data);
      }
      else {
        throw 'Error';
      }

  }
  @override
  Future<dynamic> paySuppliesOrder(int id ,BuildContext context)async {
    AuthCubit cubit =AuthCubit.get(context);
    print('object $id');
    try{
      Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-api-key': 'SIv5q09xLI689LNoALEh2D4Af/TsFkoypEMd/2XdtvGPfKHmU6HENZuuBgaBQKXM',
        'Accept-Language': cubit.localeLanguage.toString(),
        'Authorization': 'Bearer ${cubit.token}'
      };
      String data = json.encode(<String, dynamic>{
        'supplies_order_id': id
      });
      Dio dio = Dio();
      Response<dynamic> response = await dio.request(
        AppApis.paySuppliesOrder,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        try{
          String url=response.data!;
          if(url.isNotEmpty){
            Navigator.push(context, MaterialPageRoute(builder:
                (BuildContext context)=> CustomWebView( title:getLang(context, 'shart'), selectedUrl: response.data!, type: 'supplies',)));
          }
        }catch (e){
          if(response.data['success']==false){
            showToast(text: '${response.data['message']}',
                state: ToastStates.error,
                context: context);
          }
        }

      }
      else {
        showToast(text: '${response.statusMessage!}',
            state: ToastStates.error,
            context: context);
      }

    }catch(e){
      if (e is DioError) {
        if (e.response != null) {
          showToast(text: e.response!.statusMessage.toString(), state: ToastStates.error, context: context);
        }
      }
      return '';
    }
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

       // showToast(text: '${GetCheckCarsModel.fromJson(response.data).data}', state: ToastStates.success, context: context);
        return GetCheckCarsModel.fromJson(response.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
    }
 @override
  Future<MySuppliesModel?> getMySupplies(int limit ,BuildContext context)async {
    print("sdsddd ${limit}");
    AuthCubit cubit =    AuthCubit.get(context);
    Response<dynamic> response = await DioHelper.getData(
      language: cubit.localeLanguage==Locale('en')?'en':'ar',
      url: AppApis.getMySupplies(limit), token: cubit.token,);

    if (MySuppliesModel.fromJson(response.data).success == false) {
      // showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (response.statusCode == 200) {
        print( MySuppliesModel.fromJson(response.data));
       // showToast(text: '${GetCheckCarsModel.fromJson(response.data).data}', state: ToastStates.success, context: context);
        return MySuppliesModel.fromJson(response.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
    }

  @override
  Future<dynamic> cancelOrderUser(int id, BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.postData(
        url: AppApis.cancelOrderUser(id),
        token:cubit.token.isNotEmpty?cubit.token:t);
    if(res.data['success']==false){
      showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
    }else{
      if (res.statusCode == 200) {
        MyOrdersCubit.get(context).fetchOrders(context,10,true);
        Navigator.pop(context);
        showToast(text: '${res.data['message']}', state: ToastStates.success, context: context);
      }
      else {
        showToast(text: '${res.data['message']}', state: ToastStates.error, context: context);
      }
    }
    return null;
  }

  @override
  Future<String> payment(int id, String methodPayment ,BuildContext context)async {
    AuthCubit cubit =AuthCubit.get(context);
    MyOrdersCubit myOrdersCubit=MyOrdersCubit.get(context);
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-api-key': 'SIv5q09xLI689LNoALEh2D4Af/TsFkoypEMd/2XdtvGPfKHmU6HENZuuBgaBQKXM',
      'Accept-Language': cubit.localeLanguage.toString(),
      'Authorization': 'Bearer ${cubit.token}'
    };
    String data = json.encode(<String, Object>{
      'order_id': id,
      'payment_method': methodPayment
    });
   try{
     Dio dio = Dio();
     Response<dynamic> response = await dio.request(
       AppApis.payment,
       options: Options(
         method: 'POST',
         headers: headers,
       ),
       data: data,
     );

     if (response.statusCode == 200) {
       if(methodPayment=='card'){
         return response.data;
       }
       if(response.data['success']==true){
         if(methodPayment=='card'){
           return response.data;
         }
         else{
           showToast(text: getLang(context,'payment_successful'), state: ToastStates.success, context: context);
           Navigator.pushAndRemoveUntil(context,
             MaterialPageRoute(builder: (BuildContext context)=>UserBottomNavScreen(checkPage: '2',)),
                 (Route<dynamic> route) => false,);
           return '';
         }
       }
       else{
         showToast(text:response.data['message'], state: ToastStates.error, context: context);
         return '';
       }
     }
     else {
       showToast(text: response.data['message'].toString(), state: ToastStates.error, context: context);
     return '';
     }
   }catch (e){
     if (e is DioError) {
       if (e.response != null) {
         showToast(text: e.response!.statusMessage.toString(), state: ToastStates.error, context: context);
       } else {
       }
     } else {
     }
     myOrdersCubit.changeState();
     return '';
   }
  }
  }