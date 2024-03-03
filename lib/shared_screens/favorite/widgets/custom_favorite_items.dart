import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/features/user/favorite/logic/favorite_cubit.dart';

import '../../../core/resources/assets_menager.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/font_manager.dart';
import '../../../features/user/favorite/data/model/favorite_mer_model.dart';
import '../../../features/user/favorite/data/model/favorite_model.dart';
import '../../../features/user/merchants/data/models/mer_model.dart';
import '../../../features/user/merchants/logic/merchants_cubit.dart';
import '../../../features/user/merchants/presentation/screens/merchants_details_screen.dart';
import '../../../features/user/products/presentation/screens/product_details_screen.dart';

class CustomFavoriteItem extends StatelessWidget {
  const CustomFavoriteItem({super.key, this.favoriteProductsUserData, this.favoriteMerModelData, this.isMer});
  final FavoriteProductsUserData? favoriteProductsUserData;
  final FavoriteMerModelData? favoriteMerModelData;
  final bool? isMer;
  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit =MerchantsCubit.get(context);
    return  InkWell(
      onTap: (){
         if(isMer==true){
           cubit.reStart();
           cubit.getProductsMerchants(favoriteMerModelData!.id!, context);
           cubit.getWorksMerchants(favoriteMerModelData!.id!, context);
           cubit.getAddressMerchants(favoriteMerModelData!.id!, context);
           MerchantsModelData merchantsModel =MerchantsModelData(
             id:favoriteMerModelData!.id,
             name:favoriteMerModelData!.name,
             email:favoriteMerModelData!.email,
             phone:favoriteMerModelData!.phone!,
             phoneCountry:null,
             image:favoriteMerModelData!.image,
             storeName:favoriteMerModelData!.storeName,
             commercialRegistrationNo:favoriteMerModelData!.commercialRegistrationNo,
             ipan:favoriteMerModelData!.ipan,
             commercialEndDate:favoriteMerModelData!.commercialEndDate,
             mainAddress:favoriteMerModelData!.mainAddress,
             commercialRegistrationFile:favoriteMerModelData!.commercialRegistrationFile,
             logo:favoriteMerModelData!.logo,
             nationalIdImage:favoriteMerModelData!.nationalIdImage,
             status:favoriteMerModelData!.status,
             suspensionReason:favoriteMerModelData!.suspensionReason,
             profileCompleted:favoriteMerModelData!.profileCompleted,
             isVerified:favoriteMerModelData!.isVerified,
             otp:favoriteMerModelData!.otp,
             passwordOtp:favoriteMerModelData!.passwordOtp,
             type:favoriteMerModelData!.type,
             currentSubscription:null,
             addressesCount:favoriteMerModelData!.addressesCount,
             productsCount:favoriteMerModelData!.productsCount,
             rate:favoriteMerModelData!.rate,
             isFav: favoriteMerModelData!.isFav,
           );
           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
               MerchantsDetailsScreen(merchantsModelData: merchantsModel,)));
         }
         else{
           final  FavoriteProductsUserData data =favoriteProductsUserData!;
           List<String> list= <String>[];
           for(Images a in data.images!){
             list.add(a.image.toString());
           }
           Navigator.push(context,
             MaterialPageRoute(builder: (BuildContext context)=>ProductDetailsScreen(
             title: data.title,
             price: data.price.toString() ,
             brandName:data.brand!=null?data.brand!.name:'',
             width:'${data.width!=null?data.width!:''}',
             height:'${data.height!=null?data.height!:''}',
             images: list,
             isFav: data.isFav,
             id:data.id! ,
             size:'${data.size!=null?data.size!:''}',
             productStatus: data.productStatus,
             description:data.description ,
           )));
         }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: greyColor.withOpacity(0.9),
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
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ),
                  child: Image.network(
                    isMer==true?
                    favoriteMerModelData!.logo!:
                    favoriteProductsUserData!.images![0].image!,
                    height: 147.h,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    errorBuilder: (context,error,v){
                      return Padding(
                        padding: EdgeInsets.only(top:  70.h,bottom: 10.h),
                        child: Center(child: CircularProgressIndicator(),),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 16.w,
                  child:
                      isMer==true?
                      StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                        return
                          favoriteMerModelData!.isFav==true?
                          InkWell(
                            onTap: (){
                              setState(() {
                                favoriteMerModelData!.isFav=false;
                              });
                              MerchantsCubit.get(context).addAndRemoveFavoriteMerchants(favoriteMerModelData!.id!, context);
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
                                favoriteMerModelData!.isFav=true;
                              });
                              MerchantsCubit.get(context).addAndRemoveFavoriteMerchants(favoriteMerModelData!.id!, context);
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
                      }):
                      StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                        return
                          favoriteProductsUserData!.isFav==true?
                          InkWell(
                          onTap: (){
                            setState(() {
                              favoriteProductsUserData!.isFav=false;
                            });
                            FavoriteCubit.get(context).addAndRemoveFavoriteProducts(favoriteProductsUserData!.id.toString(),AuthCubit.get(context).token,context);
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
                                favoriteProductsUserData!.isFav=true;
                              });
                              FavoriteCubit.get(context).addAndRemoveFavoriteProducts(favoriteProductsUserData!.id.toString(),AuthCubit.get(context).token,context);
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
                  isMer==true?
                   favoriteMerModelData!.name!:
                  favoriteProductsUserData!.title!,
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
