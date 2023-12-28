import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/widgets/custom_app_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'تفاصيل المنتج',hasBackButton: true),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Image.asset(ImagesManager.car1,
                    width: 150.sp, height: 150.sp)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  getLang(context, 'اسم المنتج'),
                  style: TextStyle(fontWeight: FontWeightManager.bold),
                ),
                SizedBox(
                  width: 110.w,
                  child: Text(
                    '${getLang(context, 'السعر')} : 300 ر.س',
                    style: TextStyle(color: redColor),
                  ),
                )
              ],
            ),
            Padding(
              padding:   EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    getLang(context, 'اسم الماركة'),
                    style: TextStyle(fontWeight: FontWeightManager.bold),
                  ),
                  SizedBox(
                    width: 110.w,
                    child: Text(
                      getLang(context, 'العرض'),
                      style: TextStyle(color: greyColor),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  getLang(context, 'المقاس'),
                  style: TextStyle(fontWeight: FontWeightManager.bold),
                ),
                SizedBox(
                  width: 110.w,
                  child: Text(
                    getLang(context, 'الارتفاع'),
                    style: TextStyle(color: greyColor),
                  ),
                )
              ],
            ),
            Padding(
              padding:   EdgeInsets.symmetric(vertical: 5.h),
              child: Text(
                  getLang(context, 'الحالة'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
              child: Text(
                  getLang(context, 'الوصف :'),
              ),
            ),
            Text(
                'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص .'),
          ],
        ),
      ),
    );
  }
}
