import 'package:dio/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../model/brand_color_model.dart';
import '../model/brand_model.dart';
import '../model/brands.dart';



abstract class BaseBookPackageDataSource{
  Future<Brands?> getBrands(BuildContext context);
  Future<BrandModel?> getBrandModel(BuildContext context);
  Future<BrandColors?> getBrandColors(BuildContext context);

}

class BookPackageDataSource implements BaseBookPackageDataSource {


  @override
  Future<Brands?> getBrands(BuildContext context) async {
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(url: AppApis.brands,language: cubit.localeLanguage==Locale('en')?'en':'ar');
    if (Brands.fromJson(res.data).success == false) {
    }
    else {
      if (res.statusCode == 200) {
        return Brands.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<BrandColors?> getBrandColors(BuildContext context)async {
    AuthCubit cubit =AuthCubit.get(context);

    Response<dynamic> res = await DioHelper.getData(url: AppApis.brandColors,language: cubit.localeLanguage==Locale('en')?'en':'ar');
    if (BrandColors.fromJson(res.data).success == false) {
    }
    else {
      if (res.statusCode == 200) {
        return BrandColors.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<BrandModel?> getBrandModel(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);

    Response<dynamic> res = await DioHelper.getData(url: AppApis.brandModel(1),language: cubit.localeLanguage==Locale('en')?'en':'ar');
    if (BrandModel.fromJson(res.data).success == false) {
    }
    else {
      if (res.statusCode == 200) {
        return BrandModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }
}
