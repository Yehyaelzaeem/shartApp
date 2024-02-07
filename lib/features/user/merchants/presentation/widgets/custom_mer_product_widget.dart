import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/user/menu/data/model/product_model.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../products/presentation/screens/product_details_screen.dart';
import 'custom_product_details.dart';

class CustomMerProductWidget extends StatelessWidget {
  const CustomMerProductWidget({super.key, required this.productModelData});
  final ProductModelData productModelData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:
            (BuildContext context)=>CustomProductDetails(productModelData: productModelData,isCart: true,),),);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: whiteColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: greyColor,
                  blurRadius: 1,
                  spreadRadius: 1)
            ]),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: greyColor.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r)),),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r)),
                  child: Image.network(
                    productModelData.images![0].image!,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context,Object error,StackTrace? v){
                      return Center(child: CircularProgressIndicator(),);
                    },
                    width: double.infinity,),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Text(
                productModelData.title!,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeightManager.bold,
                ),
                textAlign: TextAlign.center,

              ),
            )
          ],
        ),
      ),
    );
  }
}
