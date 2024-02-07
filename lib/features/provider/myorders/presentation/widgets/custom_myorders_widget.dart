import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../data/models/provider_order_model.dart';

class CustomProductMyOrderWidget extends StatelessWidget {
  const CustomProductMyOrderWidget({super.key, this.providerOrderModelData, this.isHome, });
  final ProviderOrderModelData? providerOrderModelData;
  final bool? isHome;
  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: 115.h,
      margin: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r)),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 115.h,
              width: 100.w,
              decoration: BoxDecoration(color: packagesColor),
              child: Image.network(
                providerOrderModelData!.items![0].providerProduct!.images![0].image!,
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context,Object error,StackTrace? v){
                  return Center(child: CircularProgressIndicator(),);
                },
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
                Row(
                  children: [
                    Text('رقم الطلب : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${providerOrderModelData!.id!}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: blackTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('اسم العميل : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${providerOrderModelData!.user!.name!}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: blackTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('الحالة : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${providerOrderModelData!.status!}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: blackTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('الاجمالي : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${providerOrderModelData!.totalPrice!} ${getLang(context, 'rs')}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: Colors.red,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          isHome==true?
          SizedBox.shrink():
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 7.h),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: Color(0xff136B79),
                  borderRadius: BorderRadius.all(Radius.circular(30.r))
              ),
              child: Text(
                '${getLang(context, '${providerOrderModelData!.status!}')}',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w),
        ],
      ),
    );
  }
}
