
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/user/menu/data/model/pay_vis_model.dart';
import '../data/model/banners_model.dart';
import '../data/model/check_model.dart';
import '../data/model/product_model.dart';
import '../data/model/supplies_model.dart';
import '../data/remote_data_base/menu_data_base.dart';
part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());
  static MenuCubit get(BuildContext context)=>BlocProvider.of(context);
  MenuRemoteDataSource menuRemoteDataSource =MenuRemoteDataSource();
  bool isSearching=false;
  String typeCarSelectedValue = '';
  String productNameSelectedValue = '';
  String brandSelectedValue = '';
  String brandSelectedId = '';
  String brandModelSelectedValue = '';
  String providerSelectedValue = '';
  String brandModelSelectedId = '';
  String statusSelectedValue = '';
  String providerId = '';
  String width = '';
  String widthId = '';
  String height = '';
  String heightId = '';
  String sizeId = '';
  String size = '';
 TextEditingController searchControllerHome =TextEditingController();
   PackageCheckModel? packageCheckModel;
  SuppliesModel? suppliesModel;
  TextEditingController searchController = TextEditingController();
 List<ProductModelProvider> providerList=<ProductModelProvider>[];
 List<ProductModelProvider> providerListTest=<ProductModelProvider>[];
  Future<dynamic> getPackageCheck(BuildContext context)async{
    packageCheckModel=null;
    emit(GetBannersState2());
    menuRemoteDataSource.getPackage(context).then((PackageCheckModel? value){
      packageCheckModel=value!;
      emit(GetPackageCheckState(value));
    });
  }
  Future<dynamic> getSuppliesPackage(BuildContext context)async{
    suppliesModel=null;
    emit(GetBannersState2());
    menuRemoteDataSource.getSuppliesPackage(context).then((SuppliesModel? value){
      suppliesModel=value!;
      emit(GetSuppliesState());
    });
  }
  List<String> listBanners =<String>[];
  List<BannersModelData?>? bannersModel;
  Future<dynamic> getBanners(String type,BuildContext context)async{
    listBanners=<String>[];
    emit(GetBannersState2());
    menuRemoteDataSource.getBanners(type,context).then((BannersModel? value) {
      bannersModel=value!.data!;
      for(BannersModelData a in value.data!){
        listBanners.add(a.image!);
      }
      emit(GetBannersState(value));
    });
  }
  PaymentVisibilityModel? paymentVisibilityModel;
  Future<dynamic> getPaymentVisibility()async{
    paymentVisibilityModel=null;
    emit(GetPaymentVisibilityState());
    menuRemoteDataSource.getPaymentVisibility().then(( PaymentVisibilityModel? value) {
      paymentVisibilityModel =value;
      emit(GetPaymentVisibilityState());
    });
  }
  UserProductModel? productModel;
  UserProductModel? searchProductModel;
  Future<dynamic> getProducts(
      {String? type ,String? providerId, String? brandId, String? modelId, String? productStatus, String? name, required BuildContext context})async{
    menuRemoteDataSource.getProducts(type:type,providerId :providerId,brandId:brandId,modelId:modelId,productStatus:productStatus,name:name,context:context).then((UserProductModel? value) {
      productModel=value!;
     try{
       for(ProductModelData a in productModel!.data!){
         providerList.add(a.provider!);
       }
       final ids = providerList.map((e) => e.id).toSet();
       providerList.retainWhere((x) => ids.remove(x.id));
     }catch(e){
       print('error when get provider ${e.toString()}');
     }
      emit(GetProductsState());
    });
  }
  Future<dynamic> searchProducts(
      {String? type ,String? providerId, String? brandId, String? modelId, String? productStatus, String? name, required BuildContext context})async{
    searchProductModel=null;
    menuRemoteDataSource.getProducts(type:type,providerId :providerId,brandId:brandId,modelId:modelId,productStatus:productStatus,name:name,context:context).then((UserProductModel? value) {
      searchProductModel=value!;
      emit(GetProductsState());
    });
  }
  Future<dynamic> searchProductsRimsAndTires (
      {String? type ,String? heightId,String? widthId,String? sizeId, String? brandId, String? productStatus, String? name, required BuildContext context})async{
    searchProductModel=null;
    menuRemoteDataSource.getProducts(type:type,providerId :providerId,widthId: widthId,sizeId: sizeId,brandId:brandId,heightId:heightId,productStatus:productStatus,name:name,context:context).then((UserProductModel? value) {
      searchProductModel=value!;
      print('sa==========${searchProductModel!.toJson()}');
      emit(GetProductsState());
    });
  }
  Future<dynamic> storeSupplies(int id,BuildContext context)async{
    isLoading=true;
    emit(StoreSuppliesLoadingState());
    menuRemoteDataSource.storeSupplies(id,context).then((value) {
      isLoading=false;
      emit(StoreSuppliesSuccessState());
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
    height='';
    heightId='';
    width='';
    widthId='';
    size='';
    sizeId='';
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
  void changeLoadingSearch(bool x){
    isSearching=x;
    emit(ChangeLoadingState());
  }
  bool isSearchStart=false;

  void changeSearchStart(bool x){
    isSearchStart=x;
    emit(ChangeLoadingState());
  }
  void changeState(){
    emit(StoreSuppliesSuccessState());

  }

}
