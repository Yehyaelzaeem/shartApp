import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/banners_model.dart';
import '../data/model/check_model.dart';
import '../data/model/product_model.dart';
import '../data/remote_data_base/menu_data_base.dart';
part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());
  static MenuCubit get(BuildContext context)=>BlocProvider.of(context);
  MenuRemoteDataSource menuRemoteDataSource =MenuRemoteDataSource();

  String typeCarSelectedValue = '';
  String productNameSelectedValue = '';
  String brandSelectedValue = '';
  String brandSelectedId = '';
  String brandModelSelectedValue = '';
  String providerSelectedValue = '';
  String brandModelSelectedId = '';
  String statusSelectedValue = '';
  String providerId = '';
  TextEditingController searchController = TextEditingController();
 List<ProductModelProvider> providerList=[];
 List<ProductModelProvider> providerListTest=[];
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
    listBanners.clear();
    menuRemoteDataSource.getBanners(type,context).then((BannersModel? value) {
      bannersModel=value!.data!;
      for(var a in value.data!){
        listBanners.add(a.image!??'');
      }
      emit(GetBannersState(value));
    });
  }
  UserProductModel? productModel;
  Future getProducts(
      {String? type ,String? providerId, String? brandId, String? modelId, String? productStatus, String? name, required BuildContext context})async{
    menuRemoteDataSource.getProducts(type:type,providerId :providerId,brandId:brandId,modelId:modelId,productStatus:productStatus,name:name,context:context).then((UserProductModel? value) {
      productModel=value!;
      for(var a in productModel!.data!){
        providerList.add(a.provider!);
      }
      final ids = providerList.map((e) => e.id).toSet();
      providerList.retainWhere((x) => ids.remove(x.id));
      emit(GetProductsState());
    });
  }
  void restartData(){
    productModel=null;
  }
  void reSite(){
    brandSelectedValue='';
    brandModelSelectedValue='';
    providerId='';
    brandSelectedId='';
    brandModelSelectedId='';
    statusSelectedValue='';
    productNameSelectedValue='';
    typeCarSelectedValue='';
    providerSelectedValue='';
    emit(GetProductsState());
  }
  void removeBanner(String type,BuildContext context){
    listBanners.clear();
    listBanners=<String>[];
    // getBanners(type,context);
    emit(RemoveState());
  }
  bool isLoading=false;
  void changeLoading(bool x){
    isLoading=x;
    emit(ChangeLoadingState());
  }

}
