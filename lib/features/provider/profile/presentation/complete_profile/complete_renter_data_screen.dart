import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/provider/profile/presentation/complete_profile/widgets/custom_complete_body.dart';
import 'package:shart/widgets/custom_app_bar.dart';

class CompleteRenterDataScreen extends StatelessWidget {
  const CompleteRenterDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child:
        CustomAppBar(title: '${getLang(context, 'complete_store_information')}', hasBackButton: true),
      ),
      body:
      Container(
        height: ScreenUtil().screenHeight * 0.85,
        margin: EdgeInsets.only(top: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            border: Border.all(color: Colors.grey)),
        child: CustomCompleteProfileBody()
      ),
    );
  }
}
