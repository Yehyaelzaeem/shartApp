import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/user/cart/logic/cart_cubit.dart';
import 'package:shart/widgets/show_toast_widget.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../provider/profile/data/model/address_list_model.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../../../myorders/logic/my_orders_cubit.dart';
import '../../../profile/logic/user_profile_cubit.dart';
import '../model/cart_items_order_model.dart';

abstract class BaseCartRemoteDataSource {
  Future<dynamic> sendOrder(CartItems cartItems ,BuildContext context);
  Future<dynamic> addAddressUser(AddressModelData addressModelData, String token, BuildContext context);

}
class CartRemoteDataSource implements BaseCartRemoteDataSource{


  @override
  Future<dynamic> addAddressUser(AddressModelData addressModelData, String token, BuildContext context) async{
    CartCubit cubit=CartCubit.get(context);
    cubit.changeAddOrderLoading(true);
    Response<dynamic> response = await DioHelper.postData(url: AppApis.addAddressUser, token: token,
        data: <String,dynamic>{
          'name':'${addressModelData.name}',
          'address':'${addressModelData.address}',
          'lat':'${addressModelData.lat}',
          'lng':'${addressModelData.lng}',
          'phone':'${addressModelData.phone}',
          'note':'',
        }
    );
    if (response.statusCode == 200) {
      CartCubit.get(context).addressId=int.parse('${json.encode(response.data['data']['id'])}');
      print(' address is = ${CartCubit.get(context).addressId}');
      CartCubit.get(context).sendOrder(CartCubit.get(context).addressId, context);
      // showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.success, context: context);
    }
    else {

      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
    }

    return null;
  }

  @override
  Future<dynamic> sendOrder(CartItems cartItems, BuildContext context)async {
    print('order address is = ${cartItems.userAddressId}');
    AuthCubit cubit =AuthCubit.get(context);
     CartCubit cartCubit =CartCubit.get(context);

    // cartCubit.changeLoading(true);
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-api-key': 'SIv5q09xLI689LNoALEh2D4Af/TsFkoypEMd/2XdtvGPfKHmU6HENZuuBgaBQKXM',
      'Accept-Language': cubit.localeLanguage==Locale('en')?'en':'ar',
      'Authorization': 'Bearer ${cubit.token}'
    };

     Dio dio = Dio();
    Response<dynamic> response = await dio.request(
      'https://shart.dev01.matrix-clouds.com/api/user/make-order',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: cartItems.toJson(),
    );

    if (response.statusCode == 200) {
      MyOrdersCubit.get(context).getMyOrder(context);
      cartCubit.changeAddOrderLoading(false);
      cartCubit.addressLocationModel=null;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 530.h,
              width: 343,
              child:
              Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),),
                  SizedBox(height: 70.h,),
                  Expanded(child: Image.asset('assets/images/true.png')),
                  SizedBox(height: 30.h,),
                  Text(
                    getLang(context, 'order_done'),
                    style:   TextStyle(
                        fontFamily: FontConstants.Tajawal,
                        fontSize: 20,
                        color: blackTextColor,
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 60.h,),
                  CustomElevatedButton(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                UserBottomNavScreen(
                              checkPage: '2',
                            )));
                        cartCubit.reStartAddressFields();
                        cartCubit.removeAll();
                      },
                      buttonText: getLang(context, 'ok'))
                ],
              )
              ,
            ),

          );
        },

      );
      // showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.success, context: context);
      // cartCubit.changeLoading(false);

    }
    else {
      cartCubit.changeAddOrderLoading(false);

      // cartCubit.changeLoading(false);
      showToast(text: '${json.encode(response.data['message'])}', state: ToastStates.error, context: context);
    }
    cartCubit.changeAddOrderLoading(false);

    // cartCubit.changeLoading(false);
  }

}