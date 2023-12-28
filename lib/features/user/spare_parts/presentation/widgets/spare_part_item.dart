import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';

class SparePartItemWidget extends StatelessWidget {
  const SparePartItemWidget(
      {Key? key,
      required this.brandName,
      required this.productName,
      required this.price,
      required this.image})
      : super(key: key);
  final String brandName;
  final String productName;
  final num price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 281.h,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 167.w,
            height: 131.h,
            decoration: BoxDecoration(
              color: greyColor.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  topLeft: Radius.circular(10.r)),
            ),
            child: Image.asset(image,),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16.sp, right: 16.sp, top: 16.sp, bottom: 5.sp),
            child: Text(
              brandName,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeightManager.regular,
                color: highGreyColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 5.h),
            child: Text(
              productName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              '${price} ر.س',
              style: TextStyle(
                fontSize: 16.sp,
                color: redColor,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          ),

          InkWell(onTap: (){},child: Container(
            margin: EdgeInsets.symmetric(horizontal: 9.w,vertical: 5),
            height: 48.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Center(child: Text('أضف إلي السلة',style: TextStyle(
              fontWeight: FontWeight.bold
            ),)),

          ),),
        ],
      ),
    );
  }
}
