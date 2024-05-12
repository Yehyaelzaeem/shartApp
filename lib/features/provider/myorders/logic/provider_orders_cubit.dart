import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import '../data/data_base/data_base.dart';
import '../data/models/provider_order_model.dart';
part 'provider_orders_state.dart';

class ProviderOrdersCubit extends Cubit<ProviderOrdersState> {
  ProviderOrdersCubit() : super(ProviderOrdersInitial());
  static ProviderOrdersCubit get(BuildContext context)=>BlocProvider.of(context);
  ProviderMyOrdersRemoteDataSource providerMyOrdersRemoteDataSource =ProviderMyOrdersRemoteDataSource();
  ProviderOrderModel? myOrdersCurrent;
  ProviderOrderModel? myOrdersPrevious;
  ProviderOrderModel? myOrdersCancelled;

  int limit =10;
  bool loading = false;
  void _showOrders() {
    loading=false;
    emit(GetMyOrdersState());
  }
  void changeState(){
    loading=true;
    emit(GetMyOrdersState());
  }
  void fetchOrdersCurrentProvider(BuildContext context,int limit ) async {
    try {
      changeState();
      final List<ProviderOrderModelData> ordersList = await getMyOrdersCurrentProvider(context,limit);
      myOrdersCurrentList=ordersList;
      emit(GetMyOrdersState());
      _showOrders();
    } catch (_) {
      // Handle error
    }
  }
  List<ProviderOrderModelData>? myOrdersCurrentList;
  Future<List<ProviderOrderModelData>> getMyOrdersCurrentProvider(BuildContext context, int limit)async{
    // myOrdersCurrent=null;

   return await providerMyOrdersRemoteDataSource.getProviderOrders(limit, 'current', AuthProviderCubit.get(context).token, context).then((value){
      myOrdersCurrent =value!;
      List<ProviderOrderModelData>? data =value.data!;
      emit(GetMyOrdersState());
      return data;
    });
  }
  Future<dynamic> getMyOrdersPreviousProvider(BuildContext context)async{
    await providerMyOrdersRemoteDataSource.getProviderOrders(10, 'previous', AuthProviderCubit.get(context).token, context).then((value){
      myOrdersPrevious =value!;
      emit(GetMyOrdersState());
    });
  }
  Future<dynamic> getMyOrdersCancelledProvider(BuildContext context)async{
    await providerMyOrdersRemoteDataSource.getProviderOrders(10, 'cancelled', AuthProviderCubit.get(context).token, context).then((value){
      myOrdersCancelled =value!;
      emit(GetMyOrdersState());
    });
  }
  void putNull(){
     myOrdersCurrent=null;
     myOrdersPrevious=null;
     myOrdersCancelled=null;
     emit(GetMyOrdersState());
  }
  void putNullCurrent(){
     myOrdersCurrent=null;
     emit(GetMyOrdersState());
  }

  Future<dynamic> acceptOrder(int id,BuildContext context)async{
    await providerMyOrdersRemoteDataSource.acceptOrder(id, context);
    emit(AcceptOrdersState());
  }
  Future<dynamic> rejectOrder(int id,BuildContext context)async{
    await providerMyOrdersRemoteDataSource.rejectOrder(id, context);
    emit(AcceptOrdersState());
  }
  Future<dynamic> cancelOrder(int id,BuildContext context)async{
    await providerMyOrdersRemoteDataSource.cancelOrder(id, context);
    emit(AcceptOrdersState());
  }
  Future<dynamic> deliveredOrder(int id,BuildContext context)async{
    await providerMyOrdersRemoteDataSource.deliveredOrder(id, context);
    emit(AcceptOrdersState());
  }
  Future<dynamic> preparingOrder(int id,BuildContext context)async{
    await providerMyOrdersRemoteDataSource.preparingOrder(id, context);
    emit(AcceptOrdersState());
  }
}
