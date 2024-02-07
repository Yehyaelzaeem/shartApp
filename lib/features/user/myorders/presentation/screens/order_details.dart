import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_product_widget.dart';
import '../../data/model/myorder_model.dart';
import '../widgets/custom_item_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key, required this.myOrdersModelData}) : super(key: key);
 final MyOrdersModelData myOrdersModelData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: '${getLang(context, 'my_requests')}',hasBackButton: true),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:   EdgeInsets.only(top: 24.h,right: 16.w),
                child: Text(
                  getLang(context, 'order_details'),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:   EdgeInsets.only(top: 0.h,right: 16.w),
                child: Row(
                  children: [
                    Text(
                      '${getLang(context, 'order_id')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 25.w,),
                    Text(
                      '${myOrdersModelData.id.toString()}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:   EdgeInsets.only(top: 0.h,right: 16.w),
                child: Row(
                  children: [
                    Text(
                      '${getLang(context, 'the_shop')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 25.w,),
                    Text(
                      myOrdersModelData.provider!.name!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:   EdgeInsets.only(top: 0.h,right: 16.w),
                child: Row(
                  children: [
                    Text(
                      '${getLang(context, 'order_status')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 25.w,),
                    Text(
                      '${getLang(context, '${myOrdersModelData.status}')}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:   EdgeInsets.only(top: 0.h,right: 16.w),
                child: Row(
                  children: [
                    Text(
                      '${getLang(context, 'total-price')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 25.w,),
                    Text(
                      myOrdersModelData.totalPrice!.toString(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    '${getLang(context, 'the_address')} :',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: geryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 25.w,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Text('${myOrdersModelData.userAddress!.address!}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return CustomWidgetOrder(items: myOrdersModelData.items![index], status:myOrdersModelData.status!,);
                },
                itemCount: myOrdersModelData.items!.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
