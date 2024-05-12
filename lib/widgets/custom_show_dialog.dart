import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/widgets/custom_button.dart';

void customShowDialog({required String title, required String body, required Function  onPressed,required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(body),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 5.h),
            child: CustomElevatedButton(
                onTap: onPressed,
                buttonText:getLang(context, 'agree2')),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 5.h), child: CustomElevatedButton(
                fontColor: Colors.white,
                backgroundColor: Colors.grey,
                onTap: (){
                  Navigator.of(context).pop();
                },
                buttonText: getLang(context, 'back')),
          ),

        ],
      );
    },
  );
}