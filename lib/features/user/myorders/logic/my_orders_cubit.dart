import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';

import '../data/data_base/data_base.dart';
import '../data/model/check_car_model.dart';
import '../data/model/myorder_model.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());

  static MyOrdersCubit get(BuildContext context)=>BlocProvider.of(context);
  MyOrderRemoteDataSource myOrderRemoteDataSource =MyOrderRemoteDataSource();
  GetCheckCarsModel? getCheckCarsModel;
  MyOrdersModel? myOrdersModel;
  Future<dynamic> getMyOrder(BuildContext context)async{
    myOrderRemoteDataSource.getMyOrder(AuthCubit.get(context).token, context).then((value) {
      myOrdersModel =value!;
      emit(GetMyOrderState());
    });
  }
  Future<dynamic> getMyCheckCars(BuildContext context)async{
    myOrderRemoteDataSource.getMyCheckCars(context).then((GetCheckCarsModel? value) {
      getCheckCarsModel =value!;
      emit(GetMyOrderState());
    });
  }
}
