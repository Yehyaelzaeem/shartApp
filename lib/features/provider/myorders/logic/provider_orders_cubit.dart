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
  Future<dynamic> getMyOrdersCurrentProvider(BuildContext context)async{
    await providerMyOrdersRemoteDataSource.getProviderOrders(10, 'current', AuthProviderCubit.get(context).token, context).then((value){
      myOrdersCurrent =value!;
      emit(GetMyOrdersState());
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
}
