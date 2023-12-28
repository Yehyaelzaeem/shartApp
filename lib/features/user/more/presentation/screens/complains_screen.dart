import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/functions/general_functions.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';

import '../../../../../core/resources/assets_menager.dart';

class ComplainsScreen extends StatefulWidget {
  const ComplainsScreen({Key? key}) : super(key: key);

  @override
  State<ComplainsScreen> createState() => _ComplainsScreenState();
}

class _ComplainsScreenState extends State<ComplainsScreen> {
  TextEditingController complainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: 'الشكاوي والاقتراحات',hasBackButton: true),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Image.asset(ImagesManager.complain),
            Padding(
              padding: EdgeInsets.only(bottom: 70.h, top: 30.h),
              child: TextFormField(
                onTapOutside: (PointerDownEvent v) {
                  GeneralFunctions.hideKeyboard();
                },
                onChanged: (String v) =>
                    GeneralFunctions.unFocusCursorRTL(complainController),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'برجاء كتابة الشكوي',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                controller: complainController,
                textInputAction: TextInputAction.done,
              ),
            ),
            CustomElevatedButton(onTap: () {}, buttonText: 'إرسال')
          ],
        ),
      ),
    );
  }
}
