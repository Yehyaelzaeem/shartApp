import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_product_widget.dart';

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
              return
                CustomProductWidget(isOrder: true, isSparesParts: false, isCarCheck: false,);
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
