import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data_base/data_base.dart';
import '../data/model/history_packages_model.dart';
import '../data/model/packages_model.dart';
part 'provider_home_state.dart';

class ProviderHomeCubit extends Cubit<ProviderHomeState> {
  ProviderHomeCubit() : super(ProviderHomeInitial());
  static ProviderHomeCubit get(BuildContext context)=>BlocProvider.of(context);
  ProviderHomeRemoteDataSource providerHomeRemoteDataSource =ProviderHomeRemoteDataSource();
  PackagesModel? packagesModel;
  Future<dynamic> getPackages(BuildContext context)async{
    providerHomeRemoteDataSource.getPackagesProvider(context).then((value) {
      packagesModel=value!;
      emit(GetPackagesState());
    });
  }
  Future<dynamic> subscribePackages(String id ,BuildContext context)async{
    providerHomeRemoteDataSource.subscribePackagesProvider(id,context);
    emit(SubscribePackagesState());
  }
  HistoryPackages? historyPackages;
  Future<dynamic> getHistoryPackages(BuildContext context)async{
    providerHomeRemoteDataSource.getHistoryPackagesProvider(context).then((value) {
      historyPackages=value!;
      emit(HistoryPackagesState());
    });
  }
  bool isLoading=false;
  void changeLoad(bool x){
    isLoading=x;
    emit(ChangeLoadingState());

  }
}
