import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../data/models/mer_model.dart';
import '../../logic/merchants_cubit.dart';
import '../screens/custom_mer_detials_screen.dart';

class CustomTopMerchantsDetails extends StatelessWidget {
  const CustomTopMerchantsDetails({super.key, required this.merchantsModelData});
  final MerchantsModelData merchantsModelData;

  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit =MerchantsCubit.get(context);
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                  CustomMerDetailsScreen(merchantsModelData: merchantsModelData,)));
            },
            child: Container(
              height: 115.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: greyColor),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: <BoxShadow>[BoxShadow(color:Colors.black38,blurRadius: 1 )]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 140.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.r),
                          bottomRight: Radius.circular(10.r)),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 115.h,
                        width: 100.w,
                        decoration: BoxDecoration(color: packagesColor),
                        child: Image.network(
                          merchantsModelData.logo!=null?merchantsModelData.logo!:'',
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context,Object error,StackTrace? v){
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(ImagesManager.holder,fit: BoxFit.cover,),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(merchantsModelData.storeName!,
                          style: TextStyle(
                            fontWeight: FontWeightManager.bold,
                            fontSize: 16.sp,
                            color: blackTextColor,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                SvgPicture.asset(IconsManager.mer1),
                                SizedBox(width: 3.w,),
                                Text(
                                  '${merchantsModelData.productsCount} ${getLang(context, 'product')}',
                                  style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: 12.sp,
                                      color: geryTextColor,
                                      fontFamily: FontConstants.Tajawal
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                SvgPicture.asset(IconsManager.mer2),
                                SizedBox(width: 3.w,),
                                Text(
                                  '${merchantsModelData.addressesCount} ${getLang(context, 'branch')}',
                                  style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: 12.sp,
                                      color: geryTextColor,
                                      fontFamily: FontConstants.Tajawal
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(width: 17.w,),

                          ],
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 8.h,
            right: 10.w,
            child:
            StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
              return
                merchantsModelData.isFav==true?
                InkWell(
                  onTap: (){
                    if(AuthCubit.get(context).token.isNotEmpty){
                      setState(() {
                        merchantsModelData.isFav=false;
                      });
                      cubit.addAndRemoveFavoriteMerchants(merchantsModelData.id!,context);
                    }
                   else{
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
                        merchantsModelData.isFav=true;
                      });
                      cubit.addAndRemoveFavoriteMerchants(merchantsModelData.id!,context);
                    }
                    else{
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
      ),
    );
  }
}
