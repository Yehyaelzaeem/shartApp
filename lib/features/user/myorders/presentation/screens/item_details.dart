import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/widgets/custom_alert_dialog.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/input_decoration.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_text_field.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(title: 'تفاصيل القطعة',hasBackButton: true),
          preferredSize: Size(double.infinity, 80.h)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 24.h),
              height: 115.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: whiteColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: greyColor.withOpacity(0.3),
                        blurRadius: 1,
                        spreadRadius: 1)
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: 134.w,
                        height: 115.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                              topLeft: Radius.circular(10.r)),
                        ),
                        child: Image.asset(ImagesManager.fixCar2,
                            fit: BoxFit.fill),
                      ),
                      Positioned(
                          top: 4,
                          right: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.black26,
                                ),
                                onPressed: () {}),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'الثواب لقطع الغيارات',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeightManager.medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DropdownButton2<String>(
              isExpanded: true,
              underline: const SizedBox.shrink(),
              hint: Text(
                'ماركة السيارة',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff4B4B4B),
                ),
              ),
              items: <String>['test', 'test']
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
              buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: greyColor.withOpacity(0.5)))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.h),
              child: DropdownButton2<String>(
                isExpanded: true,
                underline: const SizedBox.shrink(),
                hint: Text(
                  'موديل السيارة',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff4B4B4B),
                  ),
                ),
                items: <String>['test', 'test']
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
                buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: greyColor.withOpacity(0.5)))),
              ),
            ),
            DropdownButton2<String>(
              isExpanded: true,
              underline: const SizedBox.shrink(),
              hint: Text(
                'نوع السيارة',
                style: TextStyle(fontSize: 14, color: Color(0xff4B4B4B)),
              ),
              items: <String>['test', 'test']
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
              buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: greyColor.withOpacity(0.5)))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.h),
              child: DropdownButton2<String>(
                isExpanded: true,
                underline: const SizedBox.shrink(),
                hint: Text(
                  'حالة السيارة',
                  style: TextStyle(fontSize: 14, color: Color(0xff4B4B4B)),
                ),
                items: <String>['test', 'test']
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
                buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: greyColor.withOpacity(0.5)))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25.h),
              child: CustomTextField(
                  hintText: 'إرفاق صورة القطعة',
                  controller: TextEditingController(),
                  hintColor: Color(0xff4B4B4B),
                  prefixIcon: Icon(Icons.camera_alt, color: Colors.grey)),
            ),
            TextField(
              decoration: customInputDecoration(
                  hintText: 'معلومات إضافية',
                  contentVerticalPadding: 20,
                  hintColor: Color(0xff4B4B4B)),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
                onTap: () {
                  CustomDialogs.showAlertDialog(
                      type: DialogType.success,
                      btnOkOnPress: () {},
                      btnCancelText: 'إلغاء',

                      title: 'إرسال الطلب',
                      desc:
                          'تم إرسال طلبك إلى المتجر وسيتم التواصل معك فى أقرب وقت',
                      ctx: context,
                      btnOkText: 'موافق');
                },
                buttonText: 'إرسال طلب'),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
