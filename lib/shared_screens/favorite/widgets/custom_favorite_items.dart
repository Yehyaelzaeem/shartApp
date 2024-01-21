import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/features/user/favorite/logic/favorite_cubit.dart';

import '../../../core/resources/assets_menager.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/font_manager.dart';
import '../../../features/user/favorite/data/model/favorite_model.dart';
import '../../../features/user/products/presentation/screens/product_details_screen.dart';

class CustomFavoriteItem extends StatelessWidget {
  const CustomFavoriteItem({super.key, required this.favoriteProductsUserData});
  final FavoriteProductsUserData favoriteProductsUserData;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        final  FavoriteProductsUserData data =favoriteProductsUserData;
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProductDetailsScreen(
          title: data.title,
          price: data.price.toString() ,
          brandName:data.brand!=null?data.brand!.name:'',
          width:'${data.width!=null?data.width!:''}',
          height:'${data.height!=null?data.height!:''}',
          image: data.images![0].image,
          size:'${data.size!=null?data.size!:''}',
          productStatus: data.productStatus,
          description:data.description ,
        )));
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(productModelData: favoriteProductsUserData,)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: greyColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  favoriteProductsUserData.images![0].image!,
                  height: 147.h,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Positioned(
                  top: 8.h,
                  right: 16.w,
                  child:
                      StatefulBuilder(builder: (context,setState){
                        return
                          favoriteProductsUserData.isFav==true?
                          InkWell(
                          onTap: (){
                            setState(() {
                              favoriteProductsUserData.isFav=false;
                            });
                            FavoriteCubit.get(context).addAndRemoveFavoriteProducts(favoriteProductsUserData.id.toString(),AuthCubit.get(context).token,context);
                          },
                          child: CircleAvatar(
                              minRadius: 12.sp,
                              backgroundColor: whiteColor,
                              child:
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 15.sp,
                              )
                          ),
                        ):
                          InkWell(
                            onTap: (){
                              setState(() {
                                favoriteProductsUserData.isFav=true;
                              });
                              print('sdsadasd');
                              FavoriteCubit.get(context).addAndRemoveFavoriteProducts(favoriteProductsUserData.id.toString(),AuthCubit.get(context).token,context);

                            },
                            child: CircleAvatar(
                              minRadius: 12.sp,
                              backgroundColor: whiteColor,
                              child:
                              Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.grey,
                                size: 15.sp,
                              ),
                            ),
                          ) ;
                      }),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Text(
                  favoriteProductsUserData.title!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
