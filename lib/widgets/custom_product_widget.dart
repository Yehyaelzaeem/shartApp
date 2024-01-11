import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import '../core/resources/assets_menager.dart';
import '../core/resources/color.dart';
import '../core/resources/font_manager.dart';

class CustomProductWidget extends StatelessWidget {
  const CustomProductWidget({super.key, required this.isOrder, required this.isSparesParts, required this.isCarCheck});
 final bool isOrder;
 final bool isSparesParts;
 final bool isCarCheck;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115.h,
      margin: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r)),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 115.h,
              decoration: BoxDecoration(color: packagesColor),
              child: Image.asset(
                ImagesManager.fixCar1,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 11.w),
          isCarCheck==true?
          FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15.h),
                Text(
                  'فحص شرط',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15.h),
                Text(
                  'ر.س 1000',
                  style: TextStyle(
                    fontWeight: FontWeightManager.regular,
                    fontSize: 14.sp,
                    color: Color(0xffDB3022),
                  ),
                )
              ],
            ),
          ):
          FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5,),
                Text(
                  'أسم الماركة',
                  style: TextStyle(
                    fontWeight: FontWeightManager.light,
                    fontSize: 12.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  'أسم المنتج',
                  style: TextStyle(
                    fontWeight: FontWeightManager.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  'أسم المتجر',
                  style: TextStyle(
                    fontWeight: FontWeightManager.regular,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10),
                isOrder==false?
                Text(
                  'ر.س 300',
                  style: TextStyle(
                    fontWeight: FontWeightManager.regular,
                    fontSize: 16.sp,
                    color: Color(0xffDB3022),
                  ),
                ): Align(
                 child:   Padding(
                   padding:   EdgeInsets.only(right: MediaQuery.of(context).size.width*0.35,bottom: 16.h),
                   child: FittedBox(
                     child: Text(
                       '${'rs'} 300',
                       style: TextStyle(
                         fontWeight: FontWeightManager.regular,
                         fontSize: 16.sp,
                         color: Color(0xffDB3022),
                       ),
                     ),
                   ),
                 ),
                 alignment: Alignment.bottomLeft,
               ),

              ],
            ),
          ),
          isSparesParts==true? Spacer():SizedBox.shrink(),
          isSparesParts==true?
          Container(
            height: 40.h,
            width: 90.w,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                color: Color(0xff136B79),
                borderRadius: BorderRadius.all(Radius.circular(50.r))
            ),
            child: FittedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${getLang(context, 'received')}',
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),
            ),
          ) :SizedBox.shrink(),
          isSparesParts==true? SizedBox(width: 6.w,) :SizedBox.shrink(),
          isCarCheck==true? Spacer():SizedBox.shrink(),
          isCarCheck==true? //       Spacer(),
          Container(
                  height: 40.h,
                  width: 90.w,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color:Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(50.r))
                  ),
                  child: FittedBox(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'طلب ملغي',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ):SizedBox.shrink(),
          isCarCheck==true? SizedBox(width: 8.w,) :SizedBox.shrink(),

          //       SizedBox(width: 10.w,)
        ],
      ),
    );
  }
}
