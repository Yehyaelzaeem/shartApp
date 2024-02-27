import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/routing/routes.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar(title: 'المتاجر',hasBackButton: true),
      ),
      body:
      GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 9.w,
          mainAxisSpacing: 15.h,
          // childAspectRatio: 5/6.5
          mainAxisExtent: 250.h,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              NavigationManager.push(Routes.storeProducts);
            },
            child: Container(
              height: 200.h,
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
                  Container(

                    decoration: BoxDecoration(
                      color: greyColor.withOpacity(0.4),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.r),
                          topLeft: Radius.circular(10.r)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(ImagesManager.sawabImg,
                            height: 147.h, fit: BoxFit.fill,width: double.infinity,),
                        Positioned(
                          top: 8.h,
                          right: 16.w,
                          child: CircleAvatar(
                            backgroundColor: whiteColor,
                            child: Icon(
                              Icons.favorite_border,
                              color: Color(0xff818181),
                            ),
                          ),
                        ),
                      ],
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
