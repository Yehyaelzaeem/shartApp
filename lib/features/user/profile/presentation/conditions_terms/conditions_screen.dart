import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/localization/appLocale.dart';

class ConditionsScreen extends StatelessWidget {
  const ConditionsScreen({Key? key,    this.text}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar(
          title: getLang(context,'terms_conditions'),hasBackButton: true,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
        child:
        Center(child: Text(text!)),
      ),
    );
  }
}
