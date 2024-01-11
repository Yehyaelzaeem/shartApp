import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_menager.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/font_manager.dart';

class CustomFavoriteItem extends StatelessWidget {
  const CustomFavoriteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: greyColor.withOpacity(0.5),
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
              Image.asset(
                ImagesManager.sawabImg,
                height: 147.h,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
              Positioned(
                top: 8.h,
                right: 16.w,
                child: CircleAvatar(
                  minRadius: 12.sp,
                  backgroundColor: whiteColor,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 15.sp,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                'اسم المتجر',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
