import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../menu/data/model/product_model.dart';
import '../data/data_base/data_base.dart';
import '../data/models/mer_address.dart';
import '../data/models/mer_model.dart';
import '../data/models/mer_works_model.dart';
part 'merchants_state.dart';

class MerchantsCubit extends Cubit<MerchantsState> {
  MerchantsCubit() : super(MerchantsInitial());
  TextEditingController searchController =TextEditingController();
  bool isSearching =false;
  static MerchantsCubit get(BuildContext context)=>BlocProvider.of(context);
  MerchantsRemoteDataSource merchantsRemoteDataSource =MerchantsRemoteDataSource();
  MerchantsModel? merchantsModel;
  MerchantsModel? merchantsSearchModel;
  MerchantsWorksModel? merchantsWorksModel;
  MerchantsAddressModel? merchantsAddressModel;
  UserProductModel? productsModel;
  Future<dynamic> getMerchants(BuildContext context)async{
    await merchantsRemoteDataSource.getMerchants( context: context).then((MerchantsModel? value) {
      merchantsModel=value;
      emit(GetMerchantsState());
    });
  }
  Future<dynamic> getSearchMerchants(String name ,BuildContext context)async{
    merchantsSearchModel=null;
    await merchantsRemoteDataSource.getMerchants(name: name, context: context).then((MerchantsModel? value) {
      merchantsSearchModel=value;
      emit(GetMerchantsState());
    });
  }

  Future<dynamic> getProductsMerchants(int id ,BuildContext context)async{
    await merchantsRemoteDataSource.getProductsMerchants(id,context).then((UserProductModel? value) {
      productsModel=value;
      emit(GetMerchantsState());
    });
  }

  Future<dynamic> getWorksMerchants(int id ,BuildContext context)async{
    await merchantsRemoteDataSource.getWorksMerchants(id,context).then((MerchantsWorksModel? value) {
      merchantsWorksModel=value;
      emit(GetMerchantsState());
    });
  }

  Future<dynamic> getAddressMerchants(int id ,BuildContext context)async{
    await merchantsRemoteDataSource.getAddressMerchants(id,context).then((MerchantsAddressModel? value) {
      merchantsAddressModel=value;
      emit(GetMerchantsState());
    });
  }
  Future<dynamic> addAndRemoveFavoriteMerchants(int id ,BuildContext context)async{
    await merchantsRemoteDataSource.addAndRemoveFavoriteMerchants(id,context);
    emit(FavoriteMerchantsState());
  }
  void reStart(){
    merchantsAddressModel=null;
    merchantsWorksModel=null;
    productsModel=null;
    emit(GetMerchantsState());
  }
  void changeSearch(bool x){
    isSearching=x;
    emit(GetMerchantsState());
  }
  bool isFullScreen = false;

  void changeIsFullScreen(){
    isFullScreen=isFullScreen;
    emit(GetMerchantsState());
  }
}
