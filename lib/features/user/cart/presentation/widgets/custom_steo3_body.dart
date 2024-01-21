import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../../logic/cart_cubit.dart';

class CustomStep3BodyWidget extends StatelessWidget {
  const CustomStep3BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CartCubit cubit =   CartCubit.get(context) ;
    return
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
            children: [
              Text(
                getLang(context, 'order_number'),
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
                '156',
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
                '${cubit.products.length}',
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
          Row(
            children: [
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
                '${CartCubit.get(context).deliveryValue} ${getLang(context, 'rs')}',
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
              Text(
                '51saf;kvs;v48',
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
          SizedBox(height: 16.h,),
          SizedBox(height: 16.h,),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
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
                groupValue: cubit.radioValue,
                onChanged: (value) {
                  cubit.changeRadio(value!);
                  // setState(() {
                  //   selectedRadio = value as int;
                  // });
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
                groupValue: cubit.radioValue,
                onChanged: (value) {
                  cubit.changeRadio(value!);
                  // setState(() {
                  //   selectedRadio = value as int;
                  // });
                },
              ),
            ],
          ),
          SizedBox(height: 70.h,),
          CustomElevatedButton(onTap: (){
           cubit.addAddressUser(AuthCubit.get(context).token, context);
            // _showDialog(context);
          },
              buttonText: getLang(context, 'confirm_payment')),
          SizedBox(height: 90.h,)
        ],
      );
  }
}

