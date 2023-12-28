import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../widgets/custom_button.dart';

class SparePartsFilterScreen extends StatefulWidget {
  const SparePartsFilterScreen({Key? key}) : super(key: key);

  @override
  State<SparePartsFilterScreen> createState() => _SparePartsFilterScreenState();
}

class _SparePartsFilterScreenState extends State<SparePartsFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: 'حدد بحثك'),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 25.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('ماركة السيارة',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16.h),
                    DropdownButton2<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: Text(
                        'إختر',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: <String>['test', 'test', 'test']
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          // selectedValue = value;
                        });
                      },
                      iconStyleData: IconStyleData(iconEnabledColor: primaryColor),
                      buttonStyleData: ButtonStyleData(

                          decoration: BoxDecoration(
                              color: Color(0xffF9F7EE),

                              borderRadius: BorderRadius.circular(8.r))),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('موديل السيارة',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16.h),
                    DropdownButton2<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: Text(
                        'إختر',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: <String>['test', 'test', 'test']
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          // selectedValue = value;
                        });
                      },
                      iconStyleData: IconStyleData(iconEnabledColor: primaryColor),
                      buttonStyleData: ButtonStyleData(

                          decoration: BoxDecoration(
                              color: Color(0xffF9F7EE),

                              borderRadius: BorderRadius.circular(8.r))),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 25.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('نوع السيارة',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16.h),
                    DropdownButton2<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: Text(
                        'إختر',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: <String>['test', 'test', 'test']
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          // selectedValue = value;
                        });
                      },
                      iconStyleData: IconStyleData(iconEnabledColor: primaryColor),
                      buttonStyleData: ButtonStyleData(

                          decoration: BoxDecoration(
                              color: Color(0xffF9F7EE),

                              borderRadius: BorderRadius.circular(8.r))),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('حالة السيارة',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16.h),
                    DropdownButton2<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: Text(
                        'إختر',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: <String>['test',  'test']
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          // selectedValue = value;
                        });
                      },
                      iconStyleData: IconStyleData(iconEnabledColor: primaryColor),
                      buttonStyleData: ButtonStyleData(

                          decoration: BoxDecoration(
                              color: Color(0xffF9F7EE),

                              borderRadius: BorderRadius.circular(8.r))),
                    ),
                  ],
                ),
              ),



              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: CustomElevatedButton(onTap: () {}, buttonText: 'بحث'),
              ),
            ],
          )),
    );
  }
}
