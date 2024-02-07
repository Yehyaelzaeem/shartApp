import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';

class CustomProductsWidgetTabBar extends StatelessWidget {
  const CustomProductsWidgetTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 9.w,
          mainAxisSpacing: 15.h,
          // childAspectRatio: 5/6.5
          mainAxisExtent: 200.h,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>MerchantsDetailsScreen()));
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
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: greyColor.withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            topLeft: Radius.circular(10.r)),
                      ),
                      child: Image.asset(ImagesManager.tire1,
                        width: double.infinity,),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Text(
                      'الثواب لقطع الغيار',
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
        },
        shrinkWrap: true,
        // physics: BouncingScrollPhysics(),
        itemCount: 6,
        padding: EdgeInsets.all(16.w),
      ),
    );
  }
}
