import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'طلباتي',hasBackButton: true),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding:   EdgeInsets.only(top: 24.h,right: 16.w),
            child: Text(
              'تفاصيل الطلب',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 115.h,
                margin:
                EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
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
                        width: 134.w,
                        height: 115.h,
                        decoration: BoxDecoration(color: packagesColor),
                        child: Image.asset(
                          ImagesManager.fixCar1,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 11.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:   EdgeInsets.only(top: 15.h,bottom: 5.h),
                          child: Text(
                            'أسم الماركة',
                            style: TextStyle(
                              fontWeight: FontWeightManager.light,
                              fontSize: 12.sp,
                              color: greyColor,
                            ),
                          ),
                        ),
                        Text(
                          'أسم المنتج',
                          style: TextStyle(
                            fontWeight: FontWeightManager.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        Padding(
                          padding:   EdgeInsets.only(top: 8.h ),
                          child: Text(
                            'أسم المتجر',
                            style: TextStyle(
                              fontWeight: FontWeightManager.regular,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),

                      ],
                    ),
                    Spacer(),
                    Align(

                      child:   Padding(
                        padding:   EdgeInsets.only(left: 16.w,bottom: 16.h),
                        child: Text(
                          '${'rs'} 300',
                          style: TextStyle(
                            fontWeight: FontWeightManager.regular,
                            fontSize: 16.sp,
                            color: Color(0xffDB3022),
                          ),
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                    )
                  ],
                ),
              );
            },
            itemCount: 1,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
          )
        ],
      ),
    );
  }
}
