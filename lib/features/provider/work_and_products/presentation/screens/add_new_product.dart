import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_field.dart';

class ProviderAddNewProduct extends StatefulWidget {
  const ProviderAddNewProduct({Key? key}) : super(key: key);

  @override
  State<ProviderAddNewProduct> createState() => _ProviderAddNewProductState();
}

class _ProviderAddNewProductState extends State<ProviderAddNewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'إضافة منتج', hasBackButton: true),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            margin: EdgeInsets.only(top: 24.h),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffD0D5DD)),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: Text(
                    'المنتجات المراد تقديمها',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lateef'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: DropdownButton2<String>(

                    isExpanded: true,

                    underline: const SizedBox.shrink(),
                    hint: Text(
                      'النوع',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                    items: <String>['test', 'test', 'test']
                        .map((String item) =>
                        DropdownMenuItem<String>(
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
                    buttonStyleData: ButtonStyleData(

                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(8.r))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: DropdownButton2<String>(

                    isExpanded: true,

                    underline: const SizedBox.shrink(),
                    hint: Text(
                      'أسم المنتج',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                    items: <String>['test', 'test', 'test']
                        .map((String item) =>
                        DropdownMenuItem<String>(
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
                    buttonStyleData: ButtonStyleData(

                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(8.r))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: DropdownButton2<String>(

                    isExpanded: true,

                    underline: const SizedBox.shrink(),
                    hint: Text(
                      'الماركة',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                    items: <String>['test', 'test', 'test']
                        .map((String item) =>
                        DropdownMenuItem<String>(
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
                    buttonStyleData: ButtonStyleData(

                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(8.r))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: DropdownButton2<String>(

                    isExpanded: true,

                    underline: const SizedBox.shrink(),
                    hint: Text(
                      'الموديل',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                    items: <String>['test', 'test', 'test']
                        .map((String item) =>
                        DropdownMenuItem<String>(
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
                    buttonStyleData: ButtonStyleData(

                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(8.r))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: DropdownButton2<String>(

                    isExpanded: true,

                    underline: const SizedBox.shrink(),
                    hint: Text(
                      'الحالة',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                    items: <String>['test', 'test', 'test']
                        .map((String item) =>
                        DropdownMenuItem<String>(
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
                    buttonStyleData: ButtonStyleData(

                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(8.r))),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.h),
                    child: CustomTextField(
                        hintText: 'الوصف',
                        controller: TextEditingController(),
                        hintColor: Colors.black)),
                CustomTextField(
                    enabled: false,
                    prefixIcon: Icon(Icons.camera_alt_outlined),
                    hintText: 'صورة القطعة',
                    controller: TextEditingController(),
                    hintColor: Colors.black),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.h),
                  child: CustomTextField(
                      textInputType: TextInputType.number,
                      hintText: 'سعر القطعة',
                      controller: TextEditingController(),
                      hintColor: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: CustomElevatedButton(onTap: () {}, buttonText: 'حفظ'),
                ),
              ],
            ),
          )),
    );
  }
}
