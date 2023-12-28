import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../core/resources/color.dart';

class CustomDialogs {
  static void showAlertDialog({
    required DialogType type,
    required Function btnOkOnPress,
    Function? btnCancelOnPress,
    required String title,
    required String desc,
    required BuildContext ctx,
    required String btnOkText,
    String? btnCancelText,
    Widget? body,
  }) {
    AwesomeDialog(
      context: ctx,
      dialogType: type,
      btnCancelText: btnCancelText,
      btnOkText: btnOkText,
      btnOkColor: primaryColor,
      btnCancelColor: Colors.red,
      title: title,
      desc: desc,
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnCancelOnPress: () {
        if (btnCancelOnPress != null) btnCancelOnPress();
      },
      btnOkOnPress: () => btnOkOnPress(),
      body: body,
    ).show();
  }
}
