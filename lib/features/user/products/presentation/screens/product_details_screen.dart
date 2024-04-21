import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/features/user/favorite/logic/favorite_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/resources/themes/styles/styles.dart';
import '../../../../../shared_screens/visitor_screen/widget/visitor_dailog.dart';
import '../../../../../widgets/custom_divider.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../cart/logic/cart_cubit.dart';
import '../../../menu/logic/menu_cubit.dart';
import '../../../merchants/presentation/widgets/custom_row deyatils.dart';
import '../widgets/custom_image_slider.dart';

class ProductDetailsScreen extends StatelessWidget {
   ProductDetailsScreen({Key? key, this.images, this.title, this.price, this.brandName, this.width, this.height, this.size, this.productStatus, this.description, this.cartProduct, this.modelName, required this.id, this.isFav, this.isCart, this.type,}) : super(key: key);
 final List<String>? images;
 final String? title;
 final String? price;
 final String? brandName;
 final String? type;
 final String? modelName;
 final String? width;
 final String? height;
 final String? size;
 final int id;
  bool? isFav;
 final String? productStatus;
 final String? description;
  final Cart? cartProduct;
  final bool? isCart;

  @override
  Widget build(BuildContext context) {
    FavoriteCubit cubit2=FavoriteCubit.get(context);
    CartCubit cubit =CartCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: getLang(context, 'product_details'),hasBackButton: true),
        preferredSize: Size(double.infinity, 70.h),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child:
                Stack(
                  children: <Widget>[
                    CustomImageSliderWidget(listImage: images!,),
                    isCart==true?
                    SizedBox.shrink():
                    Positioned(
                      top: 8.h,
                      right: 10.w,
                      child:
                      StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                        return
                          isFav==true?
                          InkWell(
                            onTap: (){
                              if(AuthCubit.get(context).token.isNotEmpty){
                                setState(() {
                                  isFav=false;
                                });
                                cubit2.addAndRemoveFavoriteProducts(id.toString(),AuthCubit.get(context).token,context).then((value) {
                                  if(type!=null){
                                    if(type=='spare_parts'){
                                      MenuCubit.get(context).getProducts(type:'spare_parts',context: context);
                                    }
                                    else if(type=='tires'){
                                      MenuCubit.get(context).getProducts(type:'tires',context: context);
                                    }
                                    else if(type =='rims'){
                                      MenuCubit.get(context).getProducts(type:'rims',context: context);
                                    }
                                  }
                                });
                              }else{
                                showToast(text: getLang(context, 'Log_in_first'), state: ToastStates.error, context: context);
                              }
                              },
                            child: CircleAvatar(
                                minRadius: 14.sp,
                                backgroundColor: whiteColor,
                                child:
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 18.sp,
                                )
                            ),
                          ):
                          InkWell(
                            onTap: (){
                              if(AuthCubit.get(context).token.isNotEmpty){
                                setState(() {
                                  isFav=true;
                                });
                                cubit2.addAndRemoveFavoriteProducts(id.toString(),AuthCubit.get(context).token,context).then((value) {
                                  if(type!=null){
                                    if(type=='spare_parts'){
                                      MenuCubit.get(context).getProducts(type:'spare_parts',context: context);
                                    }
                                    else if(type=='tires'){
                                      MenuCubit.get(context).getProducts(type:'tires',context: context);
                                    }
                                    else if(type =='rims'){
                                      MenuCubit.get(context).getProducts(type:'rims',context: context);
                                    }
                                  }
                                });
                              }else{
                                showToast(text: getLang(context, 'Log_in_first'), state: ToastStates.error, context: context);
                              }
                              },
                            child: CircleAvatar(
                              minRadius: 14.sp,
                              backgroundColor: whiteColor,
                              child:
                              Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.grey,
                                size: 18.sp,
                              ),
                            ),
                          ) ;
                      }),

                    ),
                  ],
                )
            ),
            SizedBox(height: 25.h,),
            Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.w),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomRowDetails(title: getLang(context, 'product_name'),value: title!,),
                        CustomRowDetails(title: getLang(context, 'price'),dis:50.w,
                          color: redColor,value: '${price!.toString()} ${getLang(context, 'rs')}',
                          fontSize: 23,
                        ),
                      ],
                    ),
                    CustomDivider(),
                    brandName!=null?
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomRowDetails(title: getLang(context, 'brand'),value:brandName!,),
                            height!=null&&height!.isNotEmpty?
                            CustomRowDetails(title: getLang(context, 'height'),dis:40.w, value:height!,):
                            SizedBox.shrink(),
                          ],
                        ),
                        CustomDivider(),
                      ],
                    ):SizedBox.shrink(),
                    modelName!=null?
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomRowDetails(title: getLang(context, 'car_model'),value:  modelName!,),
                            width!=null&&width!.isNotEmpty?
                            CustomRowDetails(title: getLang(context, 'width'),dis:40.w,value: width!,):
                            SizedBox.shrink(),
                          ],
                        ),
                        CustomDivider(),
                      ],
                    ):SizedBox.shrink(),
                    size!=null&&size!.isNotEmpty?
                    Column(
                      children: <Widget>[
                        CustomRowDetails(title: getLang(context, 'size'),value:size!,),
                        CustomDivider(),
                      ],
                    ):SizedBox.shrink(),
                    CustomRowDetails(title: getLang(context, 'status'),value:productStatus!,),
                    CustomDivider(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                      child: Text(
                        getLang(context, 'des'),
                        style:
                        TextStyles.font16GeryColor400WeightTajawal.copyWith(
                            fontFamily: FontConstants.lateefFont,
                            fontSize: 20,
                            fontWeight: FontWeightManager.bold
                        ),
                      ),
                    ),
                    Text(
                        description!,
                        style:
                        TextStyles.font16BlackColor500WeightTajawal.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          fontFamily: FontConstants.lateefFont,
                        )
                    ),
                    SizedBox(height: 35.h,),
                    cartProduct!=null?
                    BlocConsumer<CartCubit, CartState>(
                      listener: (BuildContext context,CartState state) {},
                      builder: (BuildContext context,CartState state) {
                        return Column(children: <Widget>[
                          if (cubit.products.where((Cart element) => element.id == cartProduct!.id).toList().length == 0)
                             InkWell(onTap: (){
                               if(AuthCubit.get(context).token.isNotEmpty){
                                 if( cubit.products.isEmpty){
                                   cubit.addProduct(cartProduct!);
                                 }
                                 if(cubit.products[0].providerId == cartProduct!.providerId ){
                                   cubit.addProduct(cartProduct!);

                                 }else{
                                   showToast(text: getLang(context, 'no_store'), state: ToastStates.error, context: context);
                                 }
                               }else{
                                 visitorDialog(context);
                                 // showToast(text: getLang(context, 'Log_in_first'),state: ToastStates.error, context: context);
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
                    ):
                    SizedBox.shrink(),
                    SizedBox(height: 50.h,),
                  ],
                )
            ),
//            Padding(
//              padding:  EdgeInsets.only(left: 18.w,right: 18.w),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  Row(
//                    children: [
//                      Expanded(
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Text(
//                              title!,
//                              style: TextStyle(
//                                  color: Color(0xff100E0D),
//                                  fontSize: 16.sp,
//                                  fontFamily: FontConstants.Tajawal,
//                                  fontWeight: FontWeightManager.bold),
//                            ),
//                            SizedBox(height: 10.h,),
//                            Text(
//                              brandName!,
//                              style: TextStyle(
//                                  color:Color(0xff4b4b4b) ,
//                                  fontFamily: FontConstants.Tajawal,
//                                  fontWeight: FontWeightManager.medium,
//                              ),
//                            ),
//                            modelName!=null?Column(
//                              children: [
//                                SizedBox(height: 10.h,),
//                                Text(
//                                  modelName!,
//                                  style: TextStyle(
//                                      color:Color(0xff4b4b4b) ,
//                                      fontFamily: FontConstants.Tajawal,
//                                      fontWeight: FontWeightManager.medium,
//                                  ),
//                                ),
//                              ],
//                            ):SizedBox.shrink(),
//                            SizedBox(height: 10.h,),
//                            size!=''?
//                            Column(
//                              children: [
//                                Text(
//                                  size!,
//                                  style:TextStyle(
//                                      color:Color(0xff4b4b4b) ,
//                                      fontWeight: FontWeightManager.regular),
//                                ),
//                                SizedBox(height: 10.h,),
//                              ],
//                            ):SizedBox.shrink(),
//                            Text(
//                              productStatus!,
//                              style:TextStyle(
//                                  color:Color(0xff4b4b4b) ,
//                                  fontWeight: FontWeightManager.medium),
//                            ),
//                            SizedBox(height: 10.h,),
//
//
//                          ],),
//                      ),
//                      Expanded(
//                        child: Padding(
//                          padding:  EdgeInsets.only(right: 30.w),
//                          child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                              Container(
//                                width: 150,
//                                child: FittedBox(
//                                  child: Text(
//                                  '${getLang(context, 'price')} : ${price!} ${getLang(context, 'rs')}',
//                                     style:
//                                     TextStyle(
//                                         color: redColor,
//                                         fontSize: 16.sp,
//                                         fontWeight: FontWeightManager.bold),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                ),
//                              ),
//                            SizedBox(height: 10.h,),
//                            width!='' ||height!=''?
//                            Column(
//                              children: [
//                                Text(
//                                  width!,
//                                  style:TextStyle(
//                                      color:Color(0xff4b4b4b) ,
//                                      fontWeight: FontWeightManager.regular),
//                                ),
//                                SizedBox(height: 10.h,),
//                                Text(
//                                  height!,
//                                  style:TextStyle(
//                                      color:Color(0xff4b4b4b) ,
//                                      fontWeight: FontWeightManager.regular),
//                                ),
//                              ],
//                            ):SizedBox(height: 50.h,),
//                            SizedBox(height: 10.h,),
//
//
//                          ]),
//                        ),
//                      ),
//                    ],
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
//                    child: Text(
//                      getLang(context, 'des'),
//                      style: TextStyle(fontWeight: FontWeightManager.bold),
//                    ),
//                  ),
//                  Text(description!),
//                  SizedBox(height: 100.h,),
//                  cartProduct!=null?
//                  BlocConsumer<CartCubit, CartState>(
//                   listener: (BuildContext context,CartState state) {},
//                   builder: (BuildContext context,CartState state) {
//                     return Column(children: [
//
//                  ],);
//   },
// ):SizedBox.shrink()
//
//                ],
//              ),
//            )
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