import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../data/models/mer_model.dart';
import '../../logic/merchants_cubit.dart';
import '../screens/merchants_details_screen.dart';

class CustomMerchantsItem extends StatelessWidget {
  const CustomMerchantsItem({super.key, required this.merchantsModelData});
  final MerchantsModelData merchantsModelData;
  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit =MerchantsCubit.get(context);
    return   InkWell(
      onTap: (){
        cubit.reStart();
        cubit.getProductsMerchants(merchantsModelData.id!, context);
        cubit.getWorksMerchants(merchantsModelData.id!, context);
        cubit.getAddressMerchants(merchantsModelData.id!, context);
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
            MerchantsDetailsScreen(merchantsModelData: merchantsModelData,)));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: whiteColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: greyColor.withOpacity(0.3),
                  blurRadius: 1,
                  spreadRadius: 1)
            ]),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    topLeft: Radius.circular(10.r)),
              ),
              child: Stack(
                children: <Widget>[
                  Image.network(merchantsModelData.logo!=null?merchantsModelData.logo!:'',
                    errorBuilder: (BuildContext context,Object error,StackTrace? v){
                    return
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.sp),
                          topLeft: Radius.circular(10.sp),
                        ),
                        child: Container(
                          height: 150.h,
                          child: Image.asset(ImagesManager.holder, fit: BoxFit.fitWidth,width: double.infinity,)
                        ),
                      );
                    },
                    height: 150.h, fit: BoxFit.fitHeight,width: double.infinity,),
                  Positioned(
                    top: 8.h,
                    right: 10.w,
                    child:

                    StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                      return
                        merchantsModelData.isFav==true?
                        InkWell(
                          onTap: (){
                            setState(() {
                              merchantsModelData.isFav=false;
                            });
                            cubit.addAndRemoveFavoriteMerchants(merchantsModelData.id!,context);
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
                            setState(() {
                              merchantsModelData.isFav=true;
                            });
                            cubit.addAndRemoveFavoriteMerchants(merchantsModelData.id!,context);
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
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  merchantsModelData.name!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeightManager.bold,
                  ),
                  textAlign:TextAlign.center,

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
