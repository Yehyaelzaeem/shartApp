import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/features/user/menu/logic/menu_cubit.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../myorders/logic/my_orders_cubit.dart';
import '../model/banners_model.dart';
import '../model/check_model.dart';
import '../model/pay_vis_model.dart';
import '../model/product_model.dart';
import '../model/supplies_model.dart';

abstract class BaseMenuRemoteDataSource{
  Future<PackageCheckModel?> getPackage(BuildContext context);
  Future<SuppliesModel?> getSuppliesPackage(BuildContext context);
  Future<BannersModel?> getBanners(String type ,BuildContext context);
  Future<PaymentVisibilityModel?> getPaymentVisibility();
  Future<dynamic> storeSupplies(int id, BuildContext context);
  Future<UserProductModel?> getProducts(  {String? type ,String? providerId,
    String? brandId,
    String? modelId,
    String? productStatus,
    String? name,
    required BuildContext context});

}

class MenuRemoteDataSource implements BaseMenuRemoteDataSource {

  @override
  Future<PackageCheckModel?> getPackage(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(url: AppApis.checkCars,
        language: cubit.localeLanguage==Locale('en')?'en':'ar');

    if (PackageCheckModel.fromJson(res.data).success == false) {
      showToast(text: '${PackageCheckModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
         return PackageCheckModel.fromJson(res.data);
      }
      else {
        // showToast(text: '${PackageCheckModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }
  @override
  Future<SuppliesModel?> getSuppliesPackage(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(url: AppApis.suppliesPackages,
        language: cubit.localeLanguage==Locale('en')?'en':'ar');

    if (SuppliesModel.fromJson(res.data).success == false) {
      showToast(text: '${SuppliesModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
         return SuppliesModel.fromJson(res.data);
      }
      else {
        // showToast(text: '${PackageCheckModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }
  @override
  Future<dynamic> storeSupplies(int id, BuildContext context)async {
    AuthCubit cubit =AuthCubit.get(context);
    var data = json.encode({
      "supply_package_id": id
    });
   try{

     Map<String, String> headers = {
       'Content-Type': 'application/json',
       'Accept': 'application/json',
       'x-api-key': 'SIv5q09xLI689LNoALEh2D4Af/TsFkoypEMd/2XdtvGPfKHmU6HENZuuBgaBQKXM',
       'Accept-Language': '${cubit.localeLanguage.toString()}',
       'Authorization': 'Bearer ${cubit.token}'
     };

     var dio = Dio();
     var response = await dio.request(
       'https://dev02.matrix-clouds.com/shart/public/api/user/store-supplies-package-order',
       options: Options(
         method: 'POST',
         headers: headers,
       ),
       data: data,
     );

     if (response.statusCode == 200) {
       print(response.data);
       int id= response.data['data']['id'];
       MyOrdersCubit.get(context).paySuppliesOrder(id,context);
     }
     else {
       showToast(text: 'Error', state: ToastStates.error, context: context);
       throw 'Error';

     }
   }catch(e){
     MenuCubit.get(context).changeState();
   }
  }

  @override
  Future<BannersModel?> getBanners(String type ,BuildContext context)async {
    AuthCubit cubit =AuthCubit.get(context);

    Response<dynamic> res = await DioHelper.getData(url: AppApis.banners(type),language: cubit.localeLanguage==Locale('en')?'en':'ar');

    if (BannersModel.fromJson(res.data).success == false) {
      // showToast(text: '${BannersModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        // showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        return BannersModel.fromJson(res.data);
      }
      else {
        // showToast(text: '${PackageCheckModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<UserProductModel?> getProducts(
      {String? type ,
      String? providerId,
      String? brandId,
      String? modelId,
      String? heightId,
      String? widthId,
      String? sizeId,
      String? productStatus,
      String? name,
     required BuildContext context}) async{
    MenuCubit cubitController =MenuCubit.get(context);
    cubitController.changeLoading(true);
    Map<String, dynamic> data = <String,dynamic >{};
    if (type != null && type.isNotEmpty) {
      data['type'] = type;
    } if (providerId != null && providerId.isNotEmpty) {
      data['provider_id'] = providerId;
    }
    if (brandId != null && brandId.isNotEmpty) {
      data['brand_id'] = brandId;
    }
    if (modelId != null && modelId.isNotEmpty) {
      data['modal_id'] = modelId;
    }
    if (productStatus != null && productStatus.isNotEmpty) {
      data['product_status'] = productStatus;
    }
    if (name != null && name.isNotEmpty) {
      data['name'] = name;
    }
    if (heightId != null && heightId.isNotEmpty) {
      data['height_id'] = heightId;
    }if (widthId != null && widthId.isNotEmpty) {
      data['width_id'] = widthId;
    }if (sizeId != null && sizeId.isNotEmpty) {
      data['size_id'] = sizeId;
    }
    AuthCubit cubit =AuthCubit.get(context);

    if(cubit.token.isNotEmpty){

      Response<dynamic> res = await DioHelper.postData(url: AppApis.getProductUser,
          language: cubit.localeLanguage==Locale('en')?'en':'ar',
          token: cubit.token,
          data: data
      );
      if (UserProductModel.fromJson(res.data).success == false) {
        cubitController.changeLoading(false);
      }
      else{
        if (res.statusCode == 200) {
          cubitController.changeLoading(false);
          if((providerId!=null && providerId!='') ||brandId!=null|| modelId!=null||productStatus!=null){
            Navigator.of(context).pop();
          }
          return UserProductModel.fromJson(res.data);
        }
        else {
          cubitController.changeLoading(false);
          throw 'Error';
        }
      }
    }
    else{
      Response<dynamic> res = await DioHelper.postData(url: AppApis.getProductUser,
          language: cubit.localeLanguage==Locale('en')?'en':'ar',
          data: data
      );
      if (UserProductModel.fromJson(res.data).success == false) {
        cubitController.changeLoading(false);
      }
      else{
        if (res.statusCode == 200) {
          cubitController.changeLoading(false);

          if((providerId!=null && providerId!='') ||brandId!=null|| modelId!=null||productStatus!=null){
            Navigator.of(context).pop();
          }
          // if(providerId!=null ||brandId!=null|| modelId!=null||productStatus!=null){
          //    Navigator.of(context).pop();
          // }
          return UserProductModel.fromJson(res.data);
        }
        else {
          cubitController.changeLoading(false);
          throw 'Error';
        }
      }
    }

     return null;
  }

  @override
  Future<PaymentVisibilityModel?> getPaymentVisibility()async {
   try{
     Response<dynamic> res = await DioHelper.getData(
         url: AppApis.getPaymentVisibility);
     if (res.statusCode == 200) {
       return PaymentVisibilityModel.fromJson(res.data);
     }
   }catch(e){}
   return null;
  }
}
