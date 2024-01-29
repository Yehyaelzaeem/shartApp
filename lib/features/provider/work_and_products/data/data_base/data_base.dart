import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/shared_preference/shared_preference.dart';
import 'package:shart/features/provider/work_and_products/data/model/size_model.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../logic/work_products_cubit.dart';
import '../model/get_products_list_model.dart';
import '../model/product_push_data_model.dart';
import '../model/works_model.dart';

abstract class BaseProviderProductsAndWorksRemoteDataSource{
  Future<dynamic> addProduct(String token ,ProductPushDataModel productPushDataModel ,BuildContext context);
  Future<GetProductsModel?> getAllProducts(String token ,BuildContext context);
  Future<dynamic> delete(String token ,String id ,BuildContext context);
  Future<dynamic> editProduct(String token ,ProductPushDataModel productPushDataModel ,String id,BuildContext context);
  Future<dynamic> addWorks(String token,BuildContext context);
  Future<WorksModel?> getWorks(String token,BuildContext context);
  Future<dynamic> deleteWork(String token ,String id ,BuildContext context);
  Future<SizeModel?> getSharedSize(BuildContext context);
  Future<SizeModel?> getSharedHeight(BuildContext context);
  Future<SizeModel?> getSharedWidth(BuildContext context);


}

class ProviderProductsAndWorksRemoteDataSource implements BaseProviderProductsAndWorksRemoteDataSource {

  @override
  Future<dynamic> addProduct(String token, ProductPushDataModel productPushDataModel, BuildContext context)async {
    dynamic t = await CacheHelper.getDate(key: 'token');
    WorkProductsCubit cubit =WorkProductsCubit.get(context);
    cubit.changeUpdateLoading(true);
    List<MultipartFile> list =<MultipartFile>[
      for(File a in cubit.imagesFile )
      await MultipartFile.fromFile(a.path, filename: 'upload'),
    ];

    FormData data = FormData.fromMap({
      'images[]':list,
      'title': '${productPushDataModel.title}',
      'brand_id':  '${productPushDataModel.brandId}',
      'modal_id':  '${productPushDataModel.modelId}',
      'product_status':  '${productPushDataModel.state}',
      'description':  '${productPushDataModel.description}',
      'price':  '${productPushDataModel.price}',
      'type':  '${productPushDataModel.type}',
      'width_id':  '${productPushDataModel.width}',
      'height_id':  '${productPushDataModel.height}',
      'size_id':  '${productPushDataModel.size}',
    });
    print("1 :${productPushDataModel.type}");
    print("11 :${productPushDataModel.width}");
    print("111 :${productPushDataModel.height}");
    print("11111 :${productPushDataModel.size}");
    Response<dynamic> response = await DioHelper.postData(url: AppApis.addProduct,
        dataOption: data,
        token: token.isNotEmpty?token:t);
    if (response.statusCode == 200) {

        showToast(text: '${getLang(context, 'my_business_showToast2')}', state: ToastStates.success, context: context);
            WorkProductsCubit.get(context).getAllProducts(context);
            Navigator.of(context).pop();

            cubit.multiImagePickerController.clearImages();
            cubit.typeSelectedValue = '';
            cubit.productNameSelectedValue.text = '';
            cubit.brandSelectedValue = '';
            cubit.brandSelectedId='';
            cubit.brandModelSelectedValue = '';
            cubit.brandModelSelectedId='';
            cubit.stateSelectedValue='';
            cubit.widthSelectedValue = '';
            cubit.heightSelectedValue = '';
            cubit.sizeSelectedValue = '';
            cubit.priceController.text='';
            cubit.desController.text='';

        cubit.changeUpdateLoading(false);

    }
    else {
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
      cubit.changeUpdateLoading(false);

    }
    cubit.changeUpdateLoading(false);

  }

  @override
  Future<GetProductsModel?> getAllProducts(String token, BuildContext context)async {
    dynamic t = await CacheHelper.getDate(key: 'token');
    Response<dynamic> res = await DioHelper.getData(url: AppApis.getProducts,
        token: token.isNotEmpty?token:t);
    if (GetProductsModel.fromJson(res.data).success == false) {
      // showToast(text: '${GetProductsModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
         // showToast(text: '${GetProductsModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        return GetProductsModel.fromJson(res.data);
      }
      else {
         // showToast(text: '${GetProductsModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;

  }

  @override
  Future<dynamic> delete(String token, String id, BuildContext context)async {
    WorkProductsCubit cubit= WorkProductsCubit.get(context);
    cubit.changeUpdateLoadingDelete(true);
    dynamic t = await CacheHelper.getDate(key: 'token');
    Response<dynamic> response = await DioHelper.postData(url: AppApis.deleteProduct(int.parse(id)),
        token: token.isNotEmpty?token:t);

    if (response.statusCode == 200) {
      showToast(text: '${getLang(context, 'my_business_showToast3')}', state: ToastStates.success, context: context);
      WorkProductsCubit.get(context).getAllProducts(context);
      cubit.changeUpdateLoadingDelete(false);

    }
    else {
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
      cubit.changeUpdateLoadingDelete(false);

    }
    cubit.changeUpdateLoadingDelete(false);

    // if (DeleteModel.fromJson(res.data).success == false) {
    //    showToast(text: '${DeleteModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    // }
    // else{
    //   if (res.statusCode == 200) {
    //     showToast(text: '${DeleteModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
    //     WorkProductsCubit.get(context).getAllProducts(context);
    //     return DeleteModel.fromJson(res.data);
    //   }
    //   else {
    //     showToast(text: '${DeleteModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    //     throw 'Error';
    //   }
    // }
    // return null;
  }

  @override
  Future<dynamic> editProduct(String token, ProductPushDataModel productPushDataModel, String id, BuildContext context)async {
    dynamic t = await CacheHelper.getDate(key: 'token');
    WorkProductsCubit cubit =WorkProductsCubit.get(context);
    cubit.changeUpdateLoading(true);
    print('${cubit.imagesFile.length}');
    List<MultipartFile> list =<MultipartFile>[
      for(File a in cubit.imagesFile )
        await MultipartFile.fromFile(a.path, filename: 'upload'),
    ];
    FormData data = FormData.fromMap({
      'images[]':list,
      'title': '${productPushDataModel.title}',
      'brand_id':  '${productPushDataModel.brandId}',
      'modal_id':  '${productPushDataModel.modelId}',
      'product_status':  '${productPushDataModel.state}',
      'description':  '${productPushDataModel.description}',
      'price':  '${productPushDataModel.price}',
      'type':  '${productPushDataModel.type}',
      'width_id':  '${productPushDataModel.width}',
      'height_id':  '${productPushDataModel.height}',
      'size_id':  '${productPushDataModel.size}',
    });
    Response<dynamic> response = await DioHelper.postData(url: AppApis.editProduct(int.parse(id)),
        dataOption: data,
        token: token.isNotEmpty?token:t);

    if (response.statusCode == 200) {
      showToast(text: '${getLang(context, 'my_business_showToast2')}', state: ToastStates.success, context: context);
      WorkProductsCubit.get(context).getAllProducts(context);
      cubit.changeUpdateLoading(false);
      Navigator.of(context).pop();
      cubit.multiImagePickerController.clearImages();
    }
    else {
      cubit.changeUpdateLoading(false);
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
    }
    cubit.changeUpdateLoading(false);

    // if (EditProductModel.fromJson(res.data).success == false) {
    //   showToast(text: '${EditProductModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    // }
    // else{
    //   if (res.statusCode == 200) {
    //     showToast(text: '${EditProductModel.fromJson(res.data).success}', state: ToastStates.success, context: context);
    //     WorkProductsCubit.get(context).getAllProducts(context);
    //     Navigator.of(context).pop();
    //     return EditProductModel.fromJson(res.data);
    //   }
    //   else {
    //     showToast(text: '${EditProductModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    //     throw 'Error';
    //   }
    // }
    // return null;
  }

  @override
  Future<dynamic> addWorks(String token, BuildContext context)async {
    WorkProductsCubit cubit =WorkProductsCubit.get(context);
    cubit.changeUpdateLoading(true);
    dynamic t = await CacheHelper.getDate(key: 'token');
    List<MultipartFile> list =<MultipartFile>[
      for(File a in cubit.imagesFileWorks )
        await MultipartFile.fromFile(a.path, filename: 'upload'),
    ];
    print( cubit.imagesFileWorks.length);
    FormData data = FormData.fromMap({
      'file': await MultipartFile.fromFile(cubit.image!.path, filename: 'upload'),
    });
    Response<dynamic> response = await DioHelper.postData(url: AppApis.addWorks,
        dataOption: data,
        token: token.isNotEmpty?token:t);
    if (response.statusCode == 200) {
      cubit.changeAddingState(!cubit.isAdding);
      cubit.changeUpdateLoading(false);
      WorkProductsCubit.get(context).getWorks(context);
      cubit.image =null;
      // json.encode(response.data['message']);
      showToast(text:'${getLang(context, 'my_business_showToast2')}', state: ToastStates.success, context: context);
    }
    else {
      cubit.changeUpdateLoading(false);
      showToast(text:'${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
    }
    cubit.changeUpdateLoading(false);
  }

  @override
  Future<WorksModel?> getWorks(String token, BuildContext context)async {
    dynamic t = await CacheHelper.getDate(key: 'token');
    WorkProductsCubit cubit =WorkProductsCubit.get(context);

    Response<dynamic> res = await DioHelper.getData(url: AppApis.getAllWorks,
        token: token.isNotEmpty?token:t);

    if (WorksModel.fromJson(res.data).success == false) {
    // showToast(text: '${WorksModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        // showToast(text: '${WorksModel.fromJson(res.data).success}', state: ToastStates.success, context: context);
        return WorksModel.fromJson(res.data);
      }
      else {
         // showToast(text: '${WorksModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<dynamic> deleteWork(String token, String id, BuildContext context) async{
    WorkProductsCubit cubit= WorkProductsCubit.get(context);
    cubit.changeUpdateLoadingDelete(true);
    dynamic t = await CacheHelper.getDate(key: 'token');
    Response<dynamic> response = await DioHelper.postData(url: AppApis.deleteWorks(int.parse(id)),
        token: token.isNotEmpty?token:t);


    if (response.statusCode == 200) {
      showToast(text: '${getLang(context, 'my_business_showToast3')}', state: ToastStates.success, context: context);
       WorkProductsCubit.get(context).getWorks(context);
       cubit.changeUpdateLoadingDelete(false);
    }
    else {
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
      print(response.statusMessage);
      cubit.changeUpdateLoadingDelete(false);

    }
    cubit.changeUpdateLoadingDelete(false);

  }

  @override
  Future<SizeModel?> getSharedHeight(BuildContext context)async {
    WorkProductsCubit cubit =WorkProductsCubit.get(context);

    Response<dynamic> res = await DioHelper.getData(url: AppApis.getHeight,);
    if (SizeModel.fromJson(res.data).success == false) {
    }
    else{
      if (res.statusCode == 200) {
        return SizeModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<SizeModel?> getSharedSize(BuildContext context) async{
    Response<dynamic> res = await DioHelper.getData(url: AppApis.getSize,);

    if (SizeModel.fromJson(res.data).success == false) {
    }
    else{
      if (res.statusCode == 200) {
        return SizeModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<SizeModel?> getSharedWidth(BuildContext context)async {
    Response<dynamic> res = await DioHelper.getData(url: AppApis.getWidth,);

    if (SizeModel.fromJson(res.data).success == false) {
    }
    else{
      if (res.statusCode == 200) {
        return SizeModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }


}
