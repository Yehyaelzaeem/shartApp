import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../shared_screens/web_view/custom_web_view_screen.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../../../cart/logic/cart_cubit.dart';
import '../../../cart/presentation/widgets/custom_steo3_body.dart';
import '../../data/model/myorder_model.dart';
import '../../logic/my_orders_cubit.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.myOrdersModelData});
  final MyOrdersModelData myOrdersModelData;
  @override
  Widget build(BuildContext context) {
    int x =0;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.h,),
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getLang(context, 'order_summary'),
              style:
              TextStyle(
                  fontFamily: FontConstants.Tajawal,
                  fontSize: 24,
                  color: blackTextColor,
                  fontWeight: FontWeight.w500
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16.h,),
            Row(
              children: <Widget>[
                Text(
                  getLang(context, 'number_products'),
                  style:
                  TextStyle(
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 14,
                      color: geryTextColor,
                      fontWeight: FontWeight.w400
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 50.w,),
                Text(
                  '${myOrdersModelData.items!.length}',
                  style:
                  TextStyle(
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 14,
                      color: blackTextColor,
                      fontWeight: FontWeight.w400
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),

              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              children: [
                Text(
                  getLang(context, 'order_value'),
                  style:
                  TextStyle(
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 14,
                      color: geryTextColor,
                      fontWeight: FontWeight.w400
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 50.w,),
                Text(
                  '${myOrdersModelData.totalPrice} ${getLang(context, 'rs')}',
                  style:
                  TextStyle(
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 14,
                      color: blackTextColor,
                      fontWeight: FontWeight.w400
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),

              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              children: <Widget>[
                Text(
                  getLang(context, 'delivery_value'),
                  style:
                  TextStyle(
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 14,
                      color: geryTextColor,
                      fontWeight: FontWeight.w400
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 50.w,),
                Text(
                  '${0.0} ${getLang(context, 'rs')}',
                  style:
                  TextStyle(
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 14,
                      color: blackTextColor,
                      fontWeight: FontWeight.w400
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),


              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getLang(context, 'delivery_address'),
                  style:
                  TextStyle(
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 14,
                      color: geryTextColor,
                      fontWeight: FontWeight.w400
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 50.w,),
                Expanded(
                  child: Text(
                    '${myOrdersModelData.userAddress!.name}',
                    style:
                    TextStyle(
                        fontFamily: FontConstants.Tajawal,
                        fontSize: 14,
                        color: blackTextColor,
                        fontWeight: FontWeight.w400
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),

              ],
            ),
            SizedBox(height: 16.h,),
            SizedBox(height: 16.h,),
            Padding(
              padding:  EdgeInsets.only(left: 5.w,right: 5.w),
              child: Divider(color: dividerColor,thickness: 1,),
            ),
            SizedBox(height: 15.h,),
            Row(
              children: <Widget>[
                Text(
                  getLang(context, 'total_price'),
                  style:
                  TextStyle(
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 16,
                      color: blackTextColor,
                      fontWeight: FontWeight.w700
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 27.w,),
                Text(
                  '${myOrdersModelData.totalPrice} ${getLang(context, 'rs')}',
                  style:
                  TextStyle(
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 14,
                      color: redColor,
                      fontWeight: FontWeight.w700
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(height: 30.h,),
            Text(
              getLang(context, 'payment_method'),
              style:
              TextStyle(
                  fontFamily: FontConstants.Tajawal,
                  fontSize: 24,
                  color: blackTextColor,
                  fontWeight: FontWeight.w500
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 10.h,),
            StatefulBuilder(builder: (context,setState){
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset('assets/images/pay.png'),
                          SizedBox(width: 5.w,),
                          Text(getLang(context, 'cash'),
                            style:   TextStyle(
                                fontFamily: FontConstants.Tajawal,
                                fontSize: 14,
                                color: blackTextColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Radio(
                        value: 0,
                        groupValue:x,
                        onChanged: (int? value) {
                          setState(() {
                            x = value as int;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/visa.png'),
                          SizedBox(width: 5.w,),
                          Text(getLang(context, 'visa'),
                            style:   TextStyle(
                                fontFamily: FontConstants.Tajawal,
                                fontSize: 14,
                                color: blackTextColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Radio(
                        value: 1,
                        groupValue: x,
                        onChanged: (int? value) {
                          setState(() {
                            x = value as int;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              );
            }),
            SizedBox(height: 70.h,),



            BlocConsumer<MyOrdersCubit, MyOrdersState>(
              listener: (BuildContext context,MyOrdersState state) {},
              builder: (BuildContext context, MyOrdersState state) {
                CartCubit cubit =CartCubit.get(context);
                return
                  CustomElevatedButton(
                      isLoading: state is PaymentLoadingState,
                      onTap: (){
                     MyOrdersCubit.get(context).payment(id: myOrdersModelData.id!, methodPayment: 'card', context: context);

                  },
                      buttonText: getLang(context, 'confirm_payment'));
              },
            ),
            SizedBox(height: 90.h,)
          ],
        )
          ],
        ),
      ),
    );
  }
}
