import 'dart:convert';

import 'package:dio/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shart/features/user/book_package_service/logic/book_package_cubit.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../../../myorders/logic/my_orders_cubit.dart';
import '../model/brand_color_model.dart';
import '../model/brand_model.dart';
import '../model/brands.dart';
import '../model/check_car_model.dart';



abstract class BaseBookPackageDataSource{
  Future<Brands?> getBrands(String? type,BuildContext context);
  Future<BrandModel?> getBrandModel(int brandId ,BuildContext context);
  Future<BrandColors?> getBrandColors(BuildContext context);
  Future<dynamic> checkCar(CheckCarModel checkCarModel,BuildContext context);

}

class BookPackageDataSource implements BaseBookPackageDataSource {


  @override
  Future<Brands?> getBrands(String? type,BuildContext context) async {
    AuthCubit cubit =AuthCubit.get(context);

    if(type!=null){
      Response<dynamic> res = await DioHelper.getData(
          url: AppApis.brands(type),
          language: cubit.localeLanguage==Locale('en')?'en':'ar');
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
    }else{
      Response<dynamic> res = await DioHelper.getData(
          url: AppApis.brandsAll,
          language: cubit.localeLanguage==Locale('en')?'en':'ar');
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
  Future<BrandModel?> getBrandModel(int brandId ,BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);

    Response<dynamic> res = await DioHelper.getData(url:
    AppApis.brandModel(brandId),language: cubit.localeLanguage==Locale('en')?'en':'ar');
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

  @override
  Future<dynamic> checkCar(CheckCarModel checkCarModel, BuildContext context)async {
    AuthCubit cubit =AuthCubit.get(context);
    BookPackageCubit cubit2 =BookPackageCubit.get(context);
    cubit2.changeLoading(true);
    Response<dynamic> response = await DioHelper.postData(
      data: <String,dynamic>{
        'package_id':checkCarModel.packageId,
        'brand_id':checkCarModel.brandId,
        'modal_id':checkCarModel.modelId,
        'color_id':checkCarModel.colorId,
        'year':checkCarModel.year,
        'chassis_no':checkCarModel.chassis_no,
        'description':checkCarModel.description,
      },
        token: cubit.token,
        url: AppApis.sendCheckCars,language: cubit.localeLanguage==Locale('en')?'en':'ar');
    if (response.data['success']== false) {
      cubit2.changeLoading(false);
      showToast(text: '${response.data['message']}',
          state: ToastStates.error,
          context: context);
    }
    else
    {
      if (response.statusCode == 200) {
        cubit2.changeLoading(false);
        // Navigator.of(context).pop();
        // Navigator.of(context).pop();
        // Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => UserBottomNavScreen(
              checkPage: '2',
            ),
          ),
              (Route route) => false,
        );
        MyOrdersCubit.get(context).getMyCheckCars(context);
        showToast(text: '${json.encode(response.data['message'])}',
            state: ToastStates.success,
            context: context);
        cubit2.brandSelectedValue ='';
        cubit2. brandSelectedId ='';
        cubit2.yearSelectedValue.text ='';
        cubit2.brandModelSelectedValue='';
        cubit2. brandModelSelectedId ='';
        cubit2.colorSelectedValue ='';
        cubit2. colorSelectedId ='';
        cubit2. descriptionController.text ='';
        cubit2. chassisController.text ='';
      }
      else {
        cubit2.changeLoading(false);
        showToast(text: '${json.encode(response.data['message'])}',
            state: ToastStates.error,
            context: context);
      }
    }
    cubit2.changeLoading(false);

  }
}
