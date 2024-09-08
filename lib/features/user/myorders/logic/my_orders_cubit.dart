import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import '../../../../shared_screens/web_view/custom_web_view_screen.dart';
import '../data/data_base/data_base.dart';
import '../data/model/check_car_model.dart';
import '../data/model/my_supplies_model.dart';
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
  MySuppliesModel? mySuppliesModel;

  int limit =10;
  int suppliesLimit =10;
  bool loading = false;
  bool suppliesLoading = false;
  void _showOrders() {
    loading=false;
    emit(GetMyOrdersState());
  }
  void showSupplies() {
    suppliesLoading=false;
    emit(GetMyOrdersState());
  }
  void changeState2(){
    loading=true;
    emit(GetMyOrdersState());
  } void changeSuppliesState2(){
    suppliesLoading=true;
    emit(GetMyOrdersState());
  }
  List<MyOrdersModelData>? myOrderList;
  List<MySuppliesModelData>? mySuppliesModelList;
  void fetchOrders(BuildContext context,int limit,bool hasNotNull ) async {
    print('ddddddddddddd');
    hasNotNull==true?null:
    myOrderList=null;
    try {
      changeState2();
      print('1111111111111111');

      final List<MyOrdersModelData> ordersList = await getMyOrder(context,limit);
      print('222222222222222222');

      myOrderList=ordersList;
      emit(GetMyOrdersState());
      _showOrders();
    } catch (_) {
      // Handle error
    }
  }
  void fetchSupplies(BuildContext context,int limit,bool hasNotNull ) async {
    hasNotNull==true?null:
    mySuppliesModelList=null;
    try {
      changeSuppliesState2();
      final List<MySuppliesModelData> mySupplies = await getMySupplies(limit,context);
      mySuppliesModelList=mySupplies;
      emit(GetMyOrdersState());
      showSupplies();
    } catch (_) {
      // Handle error
    }
  }
  Future<dynamic> paySuppliesOrder(int id,BuildContext context)async{
    emit(PaymentLoadingState());
     myOrderRemoteDataSource.paySuppliesOrder(id,context).then((value){
       emit(PaymentSuccessState());
     });

  }

  Future<List<MyOrdersModelData>> getMyOrder(BuildContext context,int limit)async{
    emit(GetMyOrderState());
    print('333333333333333333');

    return myOrderRemoteDataSource.getMyOrder(limit,AuthCubit.get(context).token, context).then((MyOrdersModel? value) {
      print('4444444444444444444444');

      myOrdersModel =value!;
      emit(GetMyOrderState());
      return value.data!;
    });
  }
  Future< List<MySuppliesModelData>> getMySupplies(int limit ,BuildContext context,)async{
    emit(GetMyOrderState());
    return myOrderRemoteDataSource.getMySupplies(limit,context).then((MySuppliesModel? value) {
      mySuppliesModel =value!;
      emit(GetMyOrderState());
      return value.data!;
    });
  }

  Future<dynamic> getMyCheckCars(BuildContext context,)async{
    getCheckCarsModel=null;
    emit(GetMyOrderState());
    myOrderRemoteDataSource.getMyCheckCars(context).then((GetCheckCarsModel? value) {
      getCheckCarsModel =value!;
      emit(GetMyOrderState());
    });
  }


  String? urlPayment;
  Future<dynamic> payment({required int id,required String methodPayment,required BuildContext context})async{
    emit(PaymentLoadingState());
    myOrderRemoteDataSource.payment(id,methodPayment,context).then((String value) {
      urlPayment=value;
      emit(PaymentSuccessState());
      if(methodPayment=='card'){
        if(value.isNotEmpty){
          Navigator.push(context, MaterialPageRoute(builder:
              (BuildContext context)=> CustomWebView( title:getLang(context, 'shart'), selectedUrl: value, type: 'car',)));
        }
      }
       });
  }
  void changeState(){
    emit(PaymentErrorState());
  }
  ProductDataSource? productDataSource;
  ProductCarCheckDataSource? productCarCheckDataSource;
  List<Product> products = <Product>[];
  List<CheckCar> checkCars = <CheckCar>[];

  void getInvoice(MyOrdersModelData myOrdersModelData){
    productDataSource= ProductDataSource(productData: products);
       emit(GetMyOrderState());
  }
  void getInvoiceCheckCar(GetCheckCarsModelData getCheckCarsModelData){
    productCarCheckDataSource= ProductCarCheckDataSource(checkCar: checkCars);
       emit(GetMyOrderState());
  }
  void cancelOrderUser(int id ,BuildContext context){
    myOrderRemoteDataSource.cancelOrderUser(id, context);
    emit(GetMyOrderState());
  }
  void getProductData(MyOrdersModelData myOrdersModelData) {
    products.clear();
    for(Items a in myOrdersModelData.items!){
      products.add(Product(name: a.providerProduct!.title!, description: a.providerProduct!.description!,
          price: a.providerProduct!.price!.toString(), quantity: a.qty!.toString(),
          total: '${(double.parse(a.providerProduct!.price!.toString())*double.parse(a.qty!.toString())).toString()}'));
    }
    emit(GetMyOrderState());
   }
   void getCheckCarData(GetCheckCarsModelData getCheckCarsModelData,BuildContext context) {
     checkCars.clear();
     DateTime originalDate = DateTime.parse(getCheckCarsModelData.createdAt!);

     DateTime futureDate = originalDate.add(Duration(days: 30));

     final String fromDate =formatDate(originalDate,context);
     final String toDate =formatDate(futureDate,context);
     String ago =AuthCubit.get(context).localeLanguage==Locale('en')?'Month':'شهر';

     checkCars.add(CheckCar(ago: ago, fromTime: fromDate, toTime: toDate, name: getCheckCarsModelData.package!.title!,
         price: getCheckCarsModelData.package!.price!.toString()),);
    emit(GetMyOrderState());
   }
  String formatDate(DateTime date,BuildContext context) {
    DateFormat formatter = DateFormat('dd MMMM yyyy', AuthCubit.get(context).localeLanguage.toString());
    return formatter.format(date);
  }
}
