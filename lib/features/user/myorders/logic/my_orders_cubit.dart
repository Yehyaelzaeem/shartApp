import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';

import '../data/data_base/data_base.dart';
import '../data/model/check_car_model.dart';
import '../data/model/myorder_model.dart';
import '../data/model/product_invoice.dart';
import '../presentation/widgets/data_source_data_grid.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());

  static MyOrdersCubit get(BuildContext context)=>BlocProvider.of(context);
  MyOrderRemoteDataSource myOrderRemoteDataSource =MyOrderRemoteDataSource();
  GetCheckCarsModel? getCheckCarsModel;
  MyOrdersModel? myOrdersModel;
  Future<dynamic> getMyOrder(BuildContext context)async{
    myOrdersModel=null;
    emit(GetMyOrderState());
    myOrderRemoteDataSource.getMyOrder(AuthCubit.get(context).token, context).then((value) {
      myOrdersModel =value!;
      emit(GetMyOrderState());
    });
  }
  Future<dynamic> getMyCheckCars(BuildContext context)async{
    getCheckCarsModel=null;
    emit(GetMyOrderState());
    myOrderRemoteDataSource.getMyCheckCars(context).then((GetCheckCarsModel? value) {
      getCheckCarsModel =value!;
      emit(GetMyOrderState());
    });
  }
  ProductDataSource? productDataSource;
  List<Product> products = <Product>[];

  void getInvoice(MyOrdersModelData myOrdersModelData){
    productDataSource= ProductDataSource(productData: products);
       emit(GetMyOrderState());
  }
  void cancelOrderUser(int id ,BuildContext context){
    myOrderRemoteDataSource.cancelOrderUser(id, context);
    emit(GetMyOrderState());
  }
  void getProductData(MyOrdersModelData myOrdersModelData) {
    for(Items a in myOrdersModelData.items!){
      products.add(Product(name: a.providerProduct!.title!, description: a.providerProduct!.description!,
          price: a.providerProduct!.price!.toString(), quantity: a.qty!.toString(),
          total: '${(double.parse(a.providerProduct!.price!.toString())*double.parse(a.qty!.toString())).toString()}'));
    }
    emit(GetMyOrderState());
   }
}
