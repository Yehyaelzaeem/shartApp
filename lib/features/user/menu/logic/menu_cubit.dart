import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/banners_model.dart';
import '../data/model/check_model.dart';
import '../data/remote_data_base/menu_data_base.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());
  static MenuCubit get(BuildContext context)=>BlocProvider.of(context);
  MenuRemoteDataSource menuRemoteDataSource =MenuRemoteDataSource();
  // PackageCheckModel? packageCheckModel;
  Future getPackageCheck(BuildContext context)async{
    menuRemoteDataSource.getPackage(context).then((PackageCheckModel? value){
      // packageCheckModel=value;
      emit(GetPackageCheckState(value!));
    });
  }
  List<String> listBanners =[];
  List<BannersModelData?>? bannersModel;
  Future getBanners(String type,BuildContext context)async{
    menuRemoteDataSource.getBanners(type,context).then((BannersModel? value) {
      bannersModel=value!.data!;
      for(var a in value.data!){
        print('iddd :${a.id}');
        listBanners.add(a.image!??'');
      }
      emit(GetBannersState(value));
    });
  }
  void removeBanner(String type,BuildContext context){
    listBanners.clear();
    listBanners=<String>[];
    // getBanners(type,context);
    emit(RemoveState());
  }

}
