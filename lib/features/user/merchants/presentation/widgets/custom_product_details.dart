import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/features/user/menu/data/model/product_model.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/resources/themes/styles/styles.dart';
import '../../../../../widgets/custom_divider.dart';
import '../../../../../widgets/custom_show_image.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../cart/logic/cart_cubit.dart';
import '../../../products/presentation/widgets/custom_image_slider.dart';
import 'custom_row deyatils.dart';

class CustomProductDetails extends StatelessWidget {
  final ProductModelData productModelData;
  CustomProductDetails({super.key, required this.productModelData, this.isCart});
 final bool? isCart;
  @override
  Widget build(BuildContext context) {
    CartCubit cubit =CartCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: getLang(context, 'product_details'),hasBackButton: true,hasCartButton: true,),
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
                CustomImageSliderWidget(listImage: productModelData.images!.map((Images e) => e.image).toList(),)
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
                      CustomRowDetails(title: getLang(context, 'product_name'),value: productModelData.title!,),
                      CustomRowDetails(title: getLang(context, 'price'),dis:50.w,
                        color: redColor,value: '${productModelData.price!.toString()} ${getLang(context, 'rs')}',
                        fontSize: 23,
                      ),
                    ],
                  ),
                  CustomDivider(),
                  productModelData.brand!=null?
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomRowDetails(title: getLang(context, 'brand'),value: productModelData.brand!.name!,),
                          productModelData.height!=null?
                          CustomRowDetails(title: getLang(context, 'height'),dis:40.w, value: productModelData.height!.name!,):
                          SizedBox.shrink(),
                        ],
                      ),
                      CustomDivider(),
                    ],
                  ):SizedBox.shrink(),
                  productModelData.modal!=null?
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomRowDetails(title: getLang(context, 'car_model'),value:  productModelData.modal!.name!,),
                          productModelData.width!=null?
                          CustomRowDetails(title: getLang(context, 'width'),dis:40.w,value: productModelData.width!.name!,):
                          SizedBox.shrink(),
                        ],
                      ),
                      CustomDivider(),
                    ],
                  ):SizedBox.shrink(),
                  productModelData.size!=null?
                  Column(
                    children: <Widget>[
                      CustomRowDetails(title: getLang(context, 'size'),value:productModelData.size!.name!,),
                      CustomDivider(),
                    ],
                  ):SizedBox.shrink(),
                  CustomRowDetails(title: getLang(context, 'status'),value:productModelData.productStatus!,),
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
                    productModelData.description!,
                    style:
                    TextStyles.font16BlackColor500WeightTajawal.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      fontFamily: FontConstants.lateefFont,
                    )
                  ),
                  SizedBox(height: 35.h,),
                  isCart!=null?
                  BlocConsumer<CartCubit, CartState>(
                    listener: (BuildContext context,CartState state) {},
                    builder: (BuildContext context,CartState state) {
                      Cart  cartProduct=  Cart(
                          id: productModelData.id,
                          productId: productModelData.id.toString(),
                          productName: productModelData.title,
                          productPrice: productModelData.price,
                          description: productModelData.description,
                          image: productModelData.images![0].image,
                          type: productModelData.type,
                          productState: productModelData.productStatus,
                          providerId: productModelData.provider!=null?productModelData.provider!.id!.toString():'',
                          count: 1,
                          productBrand: productModelData.brand!=null?productModelData.brand!.name:'');
                      return Column(children: <Widget>[
                        if (cubit.products.where((Cart element) => element.id == productModelData.id).toList().length == 0)
                          InkWell(onTap: (){
                            if( cubit.products.isEmpty){
                              cubit.addProduct(cartProduct);
                            }
                            if(cubit.products[0].providerId == cartProduct.providerId ){
                              cubit.addProduct(cartProduct);

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
                        if (cubit.products.where((Cart element) => element.id == cartProduct.id).toList().length > 0)
                          InkWell(
                            onTap: (){
                              cubit.removeProduct(cartProduct);
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
                  ):SizedBox.shrink(),
                  SizedBox(height: 50.h,),
                ],
              )
            ),

          ],
        ),
      ),
    );
  }
}
