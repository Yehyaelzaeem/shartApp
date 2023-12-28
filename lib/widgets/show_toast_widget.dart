import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void showToast(
{ required String text,
  required ToastStates state,
  required BuildContext context,
  int? time,
  ToastGravity? gravity
})=>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ??ToastGravity.BOTTOM,
        timeInSecForIosWeb: time?? 5,
        backgroundColor: chooseColor(state,context),
        textColor: Colors.white,
        fontSize: 16.0
    );
enum ToastStates{success ,error,warning}

Color chooseColor(ToastStates state,BuildContext context){
  Color color;
  switch(state){
    case ToastStates.success:
      color =Colors.green.withOpacity(0.80);
      break;
    case ToastStates.error:
      color=Colors.red;
      break;
    case ToastStates.warning:
      color=Colors.red.shade300;
      break;
  }
  return color;
}