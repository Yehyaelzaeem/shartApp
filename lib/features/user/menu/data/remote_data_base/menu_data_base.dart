import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/core/routing/routes.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../logic/menu_cubit.dart';
import '../model/check_model.dart';

abstract class BaseMenuRemoteDataSource{
  Future<PackageCheckModel?> getPackage(BuildContext context);

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


}
