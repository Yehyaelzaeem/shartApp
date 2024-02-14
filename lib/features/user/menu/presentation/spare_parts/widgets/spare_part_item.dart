import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/user/cart/logic/cart_cubit.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../cart/data/model/cart_model.dart';

class SparePartItemWidget extends StatelessWidget {
  const SparePartItemWidget(
      {Key? key,
      required this.brandName,
      required this.productName,
      required this.price,
      required this.image,  this.isFav, required this.id, this.cartProduct, required this.providerName,})
      : super(key: key);
  final String brandName;
  final String productName;
  final String price;
  final String id;
  final String providerName;
  final String image;
  final bool? isFav;
  final Cart? cartProduct;

  @override
  Widget build(BuildContext context) {
    CartCubit cubit =CartCubit.get(context);
    return Container(
      // width: MediaQuery.of(context).size.width*0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: whiteColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: greyColor.withOpacity(0.3),
                blurRadius: 1,
                spreadRadius: 1)
          ]),
      child: BlocConsumer<CartCubit, CartState>(
  listener: (context, CartState state) {},
  builder: (context, CartState state) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 167.w,
            height: 131.h,
            decoration: BoxDecoration(
              color: greyColor.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  topLeft: Radius.circular(10.r)),
            ),
            child: Image.network(image,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Center(child: Text('Error loading image'));
              },
            )
          ),
         FittedBox(
           child: Column(
             children: [
               Padding(
                 padding: EdgeInsets.only(
                     left: 16.sp, right: 16.sp, top: 2.sp, bottom: 0.sp),
                 child: Text(
                   brandName,
                   style: TextStyle(
                     fontSize: 12.sp,
                     fontWeight: FontWeightManager.regular,
                     color: highGreyColor,
                   ),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                 ),
               ),
               Padding(
                 padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 0.h),
                 child: Text(
                   productName,
                   style: TextStyle(
                     fontSize: 16.sp,
                     fontWeight: FontWeightManager.bold,
                   ),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                 ),
               ),
               FittedBox(
                 child: Row(
                   children: <Widget>[
                     Text(
                       providerName,
                       style: TextStyle(
                         fontSize: 16.sp,
                         color: redColor,
                         fontWeight: FontWeightManager.medium,
                       ),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                     ),
                     SizedBox(width: 20.w,),
                     Text(
                       '${price} ${getLang(context, 'rs')}',
                       style: TextStyle(
                         fontSize: 16.sp,
                         color: redColor,
                         fontWeight: FontWeightManager.medium,
                       ),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
          Spacer(),

          if (cubit.products.where((Cart element) => element.id == cartProduct!.id).toList().length == 0)
          InkWell(onTap: (){
            print(cartProduct!.providerId);
            if( cubit.products.isEmpty){
              cubit.addProduct(cartProduct!);
            }
            if(cubit.products[0].providerId == cartProduct!.providerId ){
              cubit.addProduct(cartProduct!);

            }else{
              showToast(text: getLang(context, 'no_store'), state: ToastStates.error, context: context);
            }
          },
            child: Container(
            margin: EdgeInsets.symmetric(horizontal: 9.w,vertical: 5),
            height: 48.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Center(
                child: Text(getLang(context, 'add_cart'),style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
           ),
          ),
          if (cubit.products.where((Cart element) => element.id == cartProduct!.id).toList().length > 0)
            InkWell(
              onTap: (){
                cubit.removeProduct(cartProduct!);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.0),
                    color: blueColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Center(
                      child: Icon(Icons.check_circle, color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          Spacer(),
        ],
      );
  },
),
    );
  }
}
