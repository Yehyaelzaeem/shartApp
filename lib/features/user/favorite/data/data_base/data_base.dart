import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/features/user/favorite/logic/favorite_cubit.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../model/favorite_mer_model.dart';
import '../model/favorite_model.dart';

abstract class BaseFavoriteRemoteDataSource{
  Future<FavoriteProductsUser?> getFavoriteProducts(String token ,BuildContext context);
  Future<FavoriteMerModel?> getFavoriteMerProducts(BuildContext context);
  Future addAndRemoveFavoriteProducts(String productId ,String token ,BuildContext context);
}
class FavoriteRemoteDataSource implements BaseFavoriteRemoteDataSource{

  @override
  Future<FavoriteProductsUser?> getFavoriteProducts(String token ,BuildContext context)async {

    AuthCubit cubit =AuthCubit.get(context);

    Response<dynamic> response = await DioHelper.getData(
        url: AppApis.getFavoriteUser,
        language: cubit.localeLanguage==Locale('en')?'en':'ar',
        token: token
    );

    if (FavoriteProductsUser.fromJson(response.data).success == false) {
       }
    else{
      if (response.statusCode == 200) {
        return FavoriteProductsUser.fromJson(response.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;

  }

 @override
  Future<FavoriteMerModel?> getFavoriteMerProducts(BuildContext context)async {

    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> response = await DioHelper.getData(
        url: AppApis.getFavoriteMerchants,
        language: cubit.localeLanguage==Locale('en')?'en':'ar',
        token: cubit.token
    );

    if (FavoriteMerModel.fromJson(response.data).success == false) {
       }
    else{
      if (response.statusCode == 200) {

        return FavoriteMerModel.fromJson(response.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;

  }

  @override
  Future addAndRemoveFavoriteProducts(String productId, String token, BuildContext context)async {
    AuthCubit cubit =AuthCubit.get(context);
    if(cubit.token.isNotEmpty){
      Response<dynamic> response = await DioHelper.postData(
          url: AppApis.addFavoriteUser,
          data: <String,dynamic>{
            'provider_product_id':productId
          },
          language: cubit.localeLanguage==Locale('en')?'en':'ar',
          token: token);
      if (response.statusCode == 200) {
        FavoriteCubit.get(context).getFavoriteProducts(cubit.token, context);
        showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.success, context: context);
      }
      else {
        showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
      }
    }else{
      showToast(text: getLang(context, 'Log_in_first'), state: ToastStates.error, context: context);
    }

  }


}