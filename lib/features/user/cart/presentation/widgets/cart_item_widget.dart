import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';

import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../products/presentation/screens/product_details_screen.dart';
import '../../data/model/cart_model.dart';
import '../../logic/cart_cubit.dart';
class CardItem extends StatelessWidget {
  final Cart product;
  const CardItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartCubit cubit =CartCubit.get(context);
    AuthCubit authCubit =AuthCubit.get(context);
    return InkWell(
      onTap: (){
        List<String> list = [product.image.toString()];

        Navigator.push(context, MaterialPageRoute(builder:
            (BuildContext context)=>ProductDetailsScreen(
          title: product.productName,
          price: product.productPrice.toString() ,
          brandName:product.productBrand!=null?product.productBrand!:'',
          width:'',
          height:'',
          images: list,
          size:'',
          productStatus: product.productState,
          description:product.description ,
        )));
      },
      child: BlocConsumer<CartCubit, CartState>(
          listener: (BuildContext context,CartState state) {},
          builder: (BuildContext context,CartState state) {
            return Container(
                width: 343.w,
                height: 115.h,
                decoration: BoxDecoration(
                   border: Border.all(color: Colors.black.withOpacity(0.25)),
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 115.h,
                      width: 130.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(authCubit.localeLanguage == Locale('ar') ? 20 : 0), bottomRight: Radius.circular(authCubit.localeLanguage == Locale('ar')? 20 : 0), bottomLeft: Radius.circular(authCubit.localeLanguage == Locale('en') ? 20 : 0), topLeft: Radius.circular(authCubit.localeLanguage == Locale('en') ? 20 : 0)),
                        child: product.image!.isNotEmpty ? Image.network(
                          product.image!,
                          width: 91,
                          height: 104,
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context ,Object error ,StackTrace? errorBuilder){
                            return Text('waiting for image ....');
                          },
                        )
                            : Image.asset(
                          ImagesManager.tire1,
                          width: 91,
                          height: 104,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      width:90.w ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 14.h,),
                          Text(
                                product.productBrand!,
                                style:
                                TextStyle(
                                  fontFamily: FontConstants.fontFamily,
                                  fontSize: 12.sp,
                                  color: geryTextColor,
                                  fontWeight: FontWeight.w400
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                          Text(
                            product.productName!,
                            style:
                            TextStyle(
                                fontFamily: FontConstants.fontFamily,
                                fontSize: 16.sp,
                                color: blackTextColor,
                                fontWeight: FontWeight.w700
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 20.h,),
                          Text(
                            '${product.productPrice} ${getLang(context, 'rs')}',
                            style:
                            TextStyle(
                                fontFamily: FontConstants.fontFamily,
                                fontSize: 16.sp,
                                color: redColor,
                                fontWeight: FontWeight.w500
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),

                        ],
                      ),
                    ),
                    Container(
                      width: 90.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(height: 14.h,),
                          InkWell(
                              onTap: (){
                                cubit.removeProduct(product);
                              },
                              child: Icon(CupertinoIcons.delete, size: 20.w,)),
                          SizedBox(height: 37.h,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  cubit.addQty(product);
                                },
                                child: Container(
                                  width: 28.w,
                                  height: 28.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 0.88,
                                        color: highGreyColor
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+',
                                      style:  TextStyle(
                                          fontSize: 20.0,
                                          color: blackTextColor,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Text(
                                '${product.count}',
                                style:  TextStyle(
                                    fontSize: 18.sp,
                                    color: blackTextColor,
                                    fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.removeQty(product);
                                },
                                child: Container(
                                  width: 28.w,
                                  height: 28.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 0.88,
                                        color: highGreyColor
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '-',
                                      style:  TextStyle(
                                          fontSize: 20.0,
                                          color: blackTextColor,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],),
                    ),
                    SizedBox(width: 5.w,),

                  ],
                ),
              );
          },
        ),
    );
  }
}
