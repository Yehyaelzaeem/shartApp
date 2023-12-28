import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';

class CompleteRenterDataScreen extends StatefulWidget {
  const CompleteRenterDataScreen({Key? key}) : super(key: key);

  @override
  State<CompleteRenterDataScreen> createState() =>
      _CompleteRenterDataScreenState();
}

class _CompleteRenterDataScreenState extends State<CompleteRenterDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child:
            CustomAppBar(title: 'إستكمال بيانات المتجر', hasBackButton: true),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: ScreenUtil().screenHeight*0.85 ,
          margin: EdgeInsets.only(top: 24.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              border: Border.all(color: Colors.grey)),
          child: Column(
            children: <Widget>[
              CustomTextField(
                  hintText: 'إرفاق شعار المتجر',
                  hintColor: Colors.black,
                  controller: TextEditingController(),
                  prefixIcon: Icon(Icons.camera_alt_outlined)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: CustomTextField(
                  hintText: 'أسم المتجر',
                  hintColor: Colors.black,
                  controller: TextEditingController(),
                ),
              ),
              CustomTextField(
                hintText: 'رقم السجل التجاري',
                hintColor: Colors.black,
                controller: TextEditingController(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: CustomTextField(
                  hintText: 'العنوان الرئيسى للمتجر',
                  hintColor: Colors.black,
                  controller: TextEditingController(),
                ),
              ),
              Spacer(),
              Padding(
                padding:   EdgeInsets.only(bottom: 80.h),
                child: CustomElevatedButton(onTap: () {}, buttonText: 'تم'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
