import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_button.dart';
import '../../data/model/myorder_model.dart';
import '../../logic/my_orders_cubit.dart';

class PaymentScreen extends StatelessWidget {
   PaymentScreen({super.key, required this.myOrdersModelData});
  final MyOrdersModelData myOrdersModelData;
  int paymentMethod =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.h,),
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
              children: <Widget>[
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
            // Row(
            //   children: <Widget>[
            //     Text(
            //       getLang(context, 'delivery_value'),
            //       style:
            //       TextStyle(
            //           fontFamily: FontConstants.Tajawal,
            //           fontSize: 14,
            //           color: geryTextColor,
            //           fontWeight: FontWeight.w400
            //       ),
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       textAlign: TextAlign.start,
            //     ),
            //     SizedBox(width: 50.w,),
            //     Text(
            //       '${0.0} ${getLang(context, 'rs')}',
            //       style:
            //       TextStyle(
            //           fontFamily: FontConstants.Tajawal,
            //           fontSize: 14,
            //           color: blackTextColor,
            //           fontWeight: FontWeight.w400
            //       ),
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       textAlign: TextAlign.start,
            //     ),
            //
            //
            //   ],
            // ),
            // SizedBox(height: 5.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
            StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(ImagesManager.pay),
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
                      Radio<int>(
                        value: 0,
                        groupValue:paymentMethod,
                        onChanged: (int? value) {
                          setState(() {
                            paymentMethod = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(ImagesManager.visa),
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
                      Radio<int>(
                        value: 1,
                        groupValue: paymentMethod,
                        onChanged: (int? value) {
                          setState(() {
                            paymentMethod = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(ImagesManager.card2),
                          SizedBox(width: 5.w,),
                          Text(getLang(context, 'master_card'),
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
                      Radio<int>(
                        value: 2,
                        groupValue: paymentMethod,
                        onChanged: (int? value) {
                          setState(() {
                            paymentMethod = value!;
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
                return
                  CustomElevatedButton(
                      isLoading: state is PaymentLoadingState,
                      onTap: (){
                        MyOrdersCubit myOrdersCubit= MyOrdersCubit.get(context);
                        if(paymentMethod==0){
                          myOrdersCubit.payment(id: myOrdersModelData.id!, methodPayment: 'cash', context: context);
                        }else if (paymentMethod==1){
                          myOrdersCubit.payment(id: myOrdersModelData.id!, methodPayment: 'card', context: context);
                        }else{
                          myOrdersCubit.payment(id: myOrdersModelData.id!, methodPayment: 'card', context: context);
                        }
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
