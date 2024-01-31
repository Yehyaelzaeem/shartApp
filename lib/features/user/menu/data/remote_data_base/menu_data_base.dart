import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/features/user/menu/logic/menu_cubit.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../model/banners_model.dart';
import '../model/check_model.dart';
import '../model/product_model.dart';

abstract class BaseMenuRemoteDataSource{
  Future<PackageCheckModel?> getPackage(BuildContext context);
  Future<BannersModel?> getBanners(String type ,BuildContext context);
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
    Response<dynamic> res = await DioHelper.getData(url: AppApis.checkCars,language: cubit.localeLanguage==Locale('en')?'en':'ar');

    if (PackageCheckModel.fromJson(res.data).success == false) {
      showToast(text: '${PackageCheckModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        print('${PackageCheckModel.fromJson(res.data).data![1].title}');
        // showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
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
   print(data.toString());
    AuthCubit cubit =AuthCubit.get(context);

    if(cubit.token.isNotEmpty){
      print('startttt');

      Response<dynamic> res = await DioHelper.postData(url: AppApis.getProductUser,
          language: cubit.localeLanguage==Locale('en')?'en':'ar',
          token: cubit.token,
          data: data
      );
      print('asdsad');

      if (UserProductModel.fromJson(res.data).success == false) {
        cubitController.changeLoading(false);
      }
      else{
        if (res.statusCode == 200) {
          cubitController.changeLoading(false);

          if((providerId!=null && providerId!='') ||brandId!=null|| modelId!=null||productStatus!=null){
            // print('dddd222d');
            // print('1  : $providerId');
            // print('2  : $brandId');
            // print('3  : $modelId');
            // print('4  : $productStatus');
            // print('ddddd');
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

          if(providerId!=null ||brandId!=null|| modelId!=null||productStatus!=null){
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

     return null;
  }


}
