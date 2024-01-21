import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/widgets/custom_app_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, this.image, this.title, this.price, this.brandName, this.width, this.height, this.size, this.productStatus, this.description,}) : super(key: key);
 // final ProductModelData productModelData;
 final String? image;
 final String? title;
 final String? price;
 final String? brandName;
 final String? width;
 final String? height;
 final String? size;
 final String? productStatus;
 final String? description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: getLang(context, 'product_details'),hasBackButton: true),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Container(
                  height: 230.h,
                  width: double.infinity,
                  child: Image.network(image!,
                      // fit: BoxFit.fill,
                      errorBuilder: (BuildContext context ,Object error,StackTrace? errorBuilder){
                       return Text('Error to load image');
                      },
                     ),
                )),
            SizedBox(height: 25.h,),
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
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      getLang(context, 'width'),
                      style: TextStyle(color: greyColor),
                    ),

                  ),
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
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
              child: Text(
                  getLang(context, 'des'),
                style: TextStyle(fontWeight: FontWeightManager.bold),
              ),
            ),
            Text(description!)
          ],
        ),
      ),
    );
  }
}
