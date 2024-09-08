import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/show_toast_widget.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../logic/cart_cubit.dart';
import 'custom_address-user_widget.dart';
import 'custom_cart_items_colum.dart';

class CustomStepBody1Widget extends StatelessWidget {
  const CustomStepBody1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    CartCubit cubit =CartCubit.get(context);
    return
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomCatItemsColumWidget(),
            SizedBox(height: 10.h,),
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
                  '${cubit.totalPrice()} ${getLang(context, 'rs')}',
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
            //   children: [
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
            //       '${CartCubit.get(context).deliveryValue} ${getLang(context, 'rs')}',
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
            // SizedBox(height: 16.h,),
            Column(
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.only(left: 5.w,right: 5.w),
                  child: Divider(color: dividerColor,thickness: 1,),
                ),
                SizedBox(height: 15.h,),
                Row(
                  children: [
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
                      '${cubit.totalPrice()+cubit.deliveryValue} ${getLang(context, 'rs')}',
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
              ],
            ),
            SizedBox(height: 16.h,),
            CustomAddressUserWidget(),
            SizedBox(height: 16.h,),
            BlocConsumer<CartCubit, CartState>(
              listener: (BuildContext context,CartState state) {},
              builder: (BuildContext context, CartState state) {
                return
                  cubit.isAddOrderLoading?Center(child: CircularProgressIndicator(),) :
                  CustomElevatedButton(onTap: (){
                    cubit.sendOrder(cubit.orderAddressModelData!.id, context);
                  },
                      buttonText: getLang(context, 'sure'));
              },
            ),

            SizedBox(height: 20.h,),

          ],
        ),
      );
  }
}
