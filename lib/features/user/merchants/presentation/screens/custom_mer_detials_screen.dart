import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/font_manager.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_app_bar.dart';

class CustomMerDetailsScreen extends StatelessWidget {
  const CustomMerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: getLang(context, 'merchant_details'),hasBackButton: true),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(ImagesManager.car2,
                    // fit: BoxFit.fill,
                    width: 120.w,
                      height: 120.w,
                    ),
                  ),
                ),
                Center(
                  child: Text('الثعلب لقطع غيار السيارات',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: FontConstants.Tajawal,
                    fontSize: 16,
                    color: blackTextColor
                  ),
                  ),),
                SizedBox(height: 24.h,),
                Text(getLang(context, 'number_products'),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 16,
                      color: blackTextColor
                  ),
                ),
                Text('15 ${getLang(context, 'product')}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 16,
                      color: Color(0xff4B4B4B)
                  ),
                ),
                SizedBox(height: 16 .h,),
                Divider(color: dividerColor,),
                SizedBox(height: 16.h,),
                Text('${getLang(context, 'products')}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 16,
                      color: blackTextColor
                  ),
                ),
                Container(
                  height:110.h ,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 110.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black38,blurRadius: 2)],
                            borderRadius: BorderRadius.circular(5)
                          ),
                          width: 80.w,
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)
                                  ),
                                  child: Image.asset(ImagesManager.rim),
                                ),
                              ),
                              Container(
                                height:25.h,
                                child: Center(
                                  child: Text('أسم المنتج',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontConstants.Tajawal,
                                    fontSize: 12
                                  ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      );
                  }),
                ),
                SizedBox(height: 24.h,),
                Divider(color: dividerColor,),
                SizedBox(height: 24.h,),
                Text('${getLang(context, 'business_photos')}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 16,
                      color: blackTextColor
                  ),
                ),
                Container(
                  height:130.h ,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 120.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black38,blurRadius: 2)],
                                borderRadius: BorderRadius.circular(5)
                            ),
                            width: 135.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)
                              ),
                              child: Image.asset(ImagesManager.rim),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(height: 24.h,),
                Divider(color: dividerColor,),
                SizedBox(height: 24.h,),
                Text('${getLang(context, 'branch_addresses')}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontConstants.Tajawal,
                      fontSize: 16,
                      color: blackTextColor
                  ),
                ),
                SizedBox(height: 10.h,),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,color: highGreyColor,),
                    SizedBox(width: 5.w,),
                    Text('طريق طلحة بن عبيد الله بحى النسيم الشرقى بالرياض',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontConstants.lateefFont,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4B4B4B)
                      ),

                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,color: highGreyColor,),
                    SizedBox(width: 5.w,),
                    Text('طريق طلحة بن عبيد الله بحى النسيم الشرقى بالرياض',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontConstants.lateefFont,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4B4B4B)
                      ),

                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,color: highGreyColor,),
                    SizedBox(width: 5.w,),
                    Text('طريق طلحة بن عبيد الله بحى النسيم الشرقى بالرياض',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontConstants.lateefFont,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4B4B4B)
                      ),

                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,color: highGreyColor,),
                    SizedBox(width: 5.w,),
                    Text('طريق طلحة بن عبيد الله بحى النسيم الشرقى بالرياض',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontConstants.lateefFont,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4B4B4B)
                      ),

                    )
                  ],
                ),
                SizedBox(height: 40.h,),
              ],
            ),
          ),
        ),
    );
  }
}
