import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';

class CustomPreviousWorkWidgetTabBar extends StatelessWidget {
  const CustomPreviousWorkWidgetTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 9.w,
        mainAxisSpacing: 15.h,
        // childAspectRatio: 5/6.5
        mainAxisExtent: 110.h,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>MerchantsDetailsScreen()));
          },
          child:Container(
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.r),

              ),
              child: Image.asset(ImagesManager.rim,
                height: 110.h,width: double.infinity,),
            ),

        );
      },
      shrinkWrap: true,
      // physics: BouncingScrollPhysics(),
      itemCount: 6,
      padding: EdgeInsets.all(16.w),
    );
  }
}
