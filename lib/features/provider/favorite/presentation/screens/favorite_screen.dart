import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/resources/assets_menager.dart';

class ProviderFavoriteScreen extends StatefulWidget {
  const ProviderFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<ProviderFavoriteScreen> createState() => _ProviderFavoriteScreen();
}

class _ProviderFavoriteScreen extends State<ProviderFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: 'المفضلة'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 9.w,
          mainAxisSpacing: 15.h,
          mainAxisExtent: 210.h,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
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
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    'اسم المتجر',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        shrinkWrap: true,
        itemCount: 6,
        padding: EdgeInsets.all(16.w),
      ),
    );
  }
}
