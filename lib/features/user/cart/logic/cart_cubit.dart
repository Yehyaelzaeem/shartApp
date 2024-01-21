import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/features/user/profile/logic/user_profile_cubit.dart';
import '../../../../core/localization/appLocale.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../shared_screens/google_map/address_location_model.dart';
import '../../../../widgets/custom_button.dart';
import '../../../provider/profile/data/model/address_list_model.dart';
import '../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../data/data_base/data_base.dart';
import '../data/model/cart_items_order_model.dart';
import '../data/model/cart_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(BuildContext context)=>BlocProvider.of(context);
  CartRemoteDataSource cartRemoteDataSource =CartRemoteDataSource();
  List<Cart> products = <Cart>[];
  List<Items> items=<Items>[];
  double? lat;
  double? long;
  Position? p ;
  Future<void> getLocation(context)async{


    p =await Geolocator.getCurrentPosition().then((Position value) {
      lat=value.latitude;
      long=value.longitude;
      print('lat : => $lat');
      print('long : => $long');
      emit(ChangeStepState());

    });

  }
  AddressLocationModel? addressLocationModel;
  int addressType = 0;
  int currentStep =0;
  int radioValue =0;


  TextEditingController addressController = TextEditingController();
  TextEditingController addressStreetController = TextEditingController();
  TextEditingController addressNuHouseController = TextEditingController();
  TextEditingController addressMarkController = TextEditingController();
  int deliveryValue =50;
  bool isActive =false;


  void changeStep(int i){
    currentStep =i;
    emit(ChangeStepState());
  }
  void changeRadio(int i){
    radioValue =i;
    emit(ChangeStepState());
  }
  Future<dynamic> sendOrder(int userAddressId ,BuildContext context) async {
    print('cuibt id : $userAddressId');
    items.clear();
    for(Cart a in products){
      print(a.providerId);
      items.add(Items(
        providerId:int.parse(a.providerId!) ,
        providerProductId:int.parse(a.productId!),
        qty: a.count
      ));
    }
    CartItems cartItems=CartItems(
        items:items ,
        userAddressId:userAddressId,
        note:'note',
    );
    cartRemoteDataSource.sendOrder(cartItems, context);
    emit(SendOrderState());
  }
  void reStartAddressFields(){
    addressController.text='';
    addressStreetController.text='';
    addressNuHouseController.text='';
    addressMarkController.text='';
    long=0.0;
    lat=0.0;
  }
 Future<dynamic> addProduct(Cart product) async {
    if (products.where((Cart element) => element.id == product.id).toList().length == 0) products.add(product);
    products.where((Cart element) => element.id == product.id).first.count = 1;
    emit(GetCartDataState());  }

  Future<dynamic> addQty(Cart product) async {
    product.count = product.count! + 1;
    products.where((Cart element) => element.id == product.id).first.count = product.count;
    emit(GetCartDataState());
  }

  Future<dynamic> removeQty(Cart product) async {
    product.count = product.count! - 1;
    if (product.count == 0)
      products.removeWhere((Cart element) => element.id == product.id);
    else
      products.where((Cart element) => element.id == product.id).first.count = product.count;
    emit(GetCartDataState());  }

  Future<dynamic>  removeProduct(Cart product) async {
    products.removeWhere((Cart element) => element.id == product.id);
    emit(GetCartDataState());  }

  double totalPrice() {
    double total = 0;
    products.forEach((Cart element) {
      total += element.productPrice! * element.count!;
    });
    return total;
  }

  void removeAll() {
    products.clear();
  }

  bool isLoading=false;
  bool isAddingAddress=false;
  void changeLoading(bool x){
    isLoading=x;
    emit(ChangeLoadingState());
  }
  int addressId=0;
  Future<dynamic> addAddressUser(String token ,BuildContext context)async{
    AddressModelData addressModelData= AddressModelData(
      name: 'location / ${addressLocationModel!.country}/${addressLocationModel!.bigCity}/${addressLocationModel!.city}/${addressLocationModel!.locality}/${addressLocationModel!.street}',
      address: 'address : ${addressController.text} / street: ${addressStreetController.text} / number_house : ${addressNuHouseController.text} / mark : ${addressMarkController.text}',
      phone: UserProfileCubit.get(context).userProfileModel!=null?UserProfileCubit.get(context).userProfileModel!.data!.phone:'123456789',
      lng: long!.toString(),
      lat: lat!.toString(),
    );
    if(token.isNotEmpty&&addressModelData.name!=null&&addressModelData.address!=null&&addressModelData.phone!=null&&addressModelData.lng!=null&&addressModelData.lat!=null){
      cartRemoteDataSource.addAddressUser(addressModelData ,token, context);
      emit(ChangeLoadingState());
    }
    return null;
  }

  void changeAddingAddress(bool x){
    isAddingAddress=x;
    emit(ChangeLoadingState());
  }
}
