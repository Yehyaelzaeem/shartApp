import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../widgets/custom_slider_widget.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../cart/logic/cart_cubit.dart';
import '../../../menu/logic/menu_cubit.dart';
import '../widgets/custom_image_slider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, this.images, this.title, this.price, this.brandName, this.width, this.height, this.size, this.productStatus, this.description, this.cartProduct, this.modelName,}) : super(key: key);
 // final ProductModelData productModelData;
 final List<String>? images;
 final String? title;
 final String? price;
 final String? brandName;
 final String? modelName;
 final String? width;
 final String? height;
 final String? size;
 final String? productStatus;
 final String? description;
  final Cart? cartProduct;

  @override
  Widget build(BuildContext context) {
    CartCubit cubit =CartCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: getLang(context, 'product_details'),hasBackButton: true),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child:
                CustomImageSliderWidget(listImage: images!,)
            ),
            SizedBox(height: 25.h,),
           Padding(
             padding:  EdgeInsets.only(left: 18.w,right: 18.w),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   children: [
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             title!,
                             style: TextStyle(
                                 color: Color(0xff100E0D),
                                 fontSize: 16.sp,
                                 fontFamily: FontConstants.Tajawal,
                                 fontWeight: FontWeightManager.bold),
                           ),
                           SizedBox(height: 10.h,),
                           Text(
                             brandName!,
                             style: TextStyle(
                                 color:Color(0xff4b4b4b) ,
                                 fontFamily: FontConstants.Tajawal,
                                 fontWeight: FontWeightManager.medium,
                             ),
                           ),
                           modelName!=null?Column(
                             children: [
                               SizedBox(height: 10.h,),
                               Text(
                                 modelName!,
                                 style: TextStyle(
                                     color:Color(0xff4b4b4b) ,
                                     fontFamily: FontConstants.Tajawal,
                                     fontWeight: FontWeightManager.medium,
                                 ),
                               ),
                             ],
                           ):SizedBox.shrink(),
                           SizedBox(height: 10.h,),
                           size!=''?
                           Column(
                             children: [
                               Text(
                                 size!,
                                 style:TextStyle(
                                     color:Color(0xff4b4b4b) ,
                                     fontWeight: FontWeightManager.regular),
                               ),
                               SizedBox(height: 10.h,),
                             ],
                           ):SizedBox.shrink(),
                           Text(
                             productStatus!,
                             style:TextStyle(
                                 color:Color(0xff4b4b4b) ,
                                 fontWeight: FontWeightManager.medium),
                           ),
                           SizedBox(height: 10.h,),


                         ],),
                     ),
                     Expanded(
                       child: Padding(
                         padding:  EdgeInsets.only(right: 30.w),
                         child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                             Container(
                               width: 150,
                               child: FittedBox(
                                 child: Text(
                                 '${getLang(context, 'price')} : ${price!} ${getLang(context, 'rs')}',
                                    style:
                                    TextStyle(
                                        color: redColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeightManager.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                               ),
                             ),
                           SizedBox(height: 10.h,),
                           width!='' ||height!=''?
                           Column(
                             children: [
                               Text(
                                 width!,
                                 style:TextStyle(
                                     color:Color(0xff4b4b4b) ,
                                     fontWeight: FontWeightManager.regular),
                               ),
                               SizedBox(height: 10.h,),
                               Text(
                                 height!,
                                 style:TextStyle(
                                     color:Color(0xff4b4b4b) ,
                                     fontWeight: FontWeightManager.regular),
                               ),
                             ],
                           ):SizedBox(height: 50.h,),
                           SizedBox(height: 10.h,),


                         ]),
                       ),
                     ),
                   ],
                 ),
                 Padding(
                   padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                   child: Text(
                     getLang(context, 'des'),
                     style: TextStyle(fontWeight: FontWeightManager.bold),
                   ),
                 ),
                 Text(description!),
                 SizedBox(height: 100.h,),
                 cartProduct!=null?
                 BlocConsumer<CartCubit, CartState>(
                  listener: (BuildContext context,CartState state) {},
                  builder: (BuildContext context,CartState state) {
                    return Column(children: [
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
                 ],);
  },
):SizedBox.shrink()

               ],
             ),
           )
          ],
        ),
      ),
    );
  }
}
/*

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 85.w,
                  child: Text(
                    getLang(context, 'product_name'),
                    style: TextStyle(
                        color: Color(0xff100E0D),
                        fontSize: 16.sp,
                        fontWeight: FontWeightManager.bold),
                  ),
                ),
                Container(
                  width: 70.w,
                  child: Text(
                    title!,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.sp,
                        fontWeight: FontWeightManager.medium),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 120.w,
                    child: FittedBox(
                      child: Text(
                        '${getLang(context, 'price')} : ${price!} ${getLang(context, 'rs')}',
                        style:
                        TextStyle(
                            color: redColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeightManager.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                )
              ],
            ),
            Padding(
              padding:   EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.w,
                    child: Text(
                      getLang(context, 'brand_name'),
                      style: TextStyle(
                          color:geryTextColor ,
                          fontWeight: FontWeightManager.regular),
                    ),
                  ),
                  Container(
                    width: 90.w,
                    child: Text(
                      brandName!,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.sp,
                          fontWeight: FontWeightManager.medium),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  width!=''?
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      getLang(context, 'width'),
                      style: TextStyle(color: greyColor),
                    ),
                  ):SizedBox.shrink(),
                  Container(
                    width: 45.w,
                    child: Text(
                      '${width!}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.sp,
                          fontWeight: FontWeightManager.medium),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.w,

                  child: Text(
                    getLang(context, 'size'),
                    style:TextStyle(
                        color:geryTextColor ,
                        fontWeight: FontWeightManager.regular),
                  ),
                ),
                Container(
                  width: 90.w,

                  child: Text(
                    size!,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.sp,
                        fontWeight: FontWeightManager.medium),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
               size!=null?SizedBox(width: 20.w,):SizedBox.shrink(),
                SizedBox(
                  width: 75.w,
                  child: Text(
                    getLang(context, 'height'),
                    style: TextStyle(color: greyColor),
                  ),
                ),
                Container(
                  width: 45.w,
                  child: Text(
                    '${height}',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.sp,
                        fontWeight: FontWeightManager.medium),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Padding(
              padding:   EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                children: [
                  Text(
                      getLang(context, 'status'),
                    style: TextStyle(
                        color:blackTextColor ,
                        fontWeight: FontWeightManager.regular),
                  ),
                  SizedBox(width: 90.w,),
                  Text(
                    productStatus!,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.sp,
                        fontWeight: FontWeightManager.medium),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
 */