import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class AppDialogs {


  Future<bool> confirm(
    BuildContext context, {
    String? title,
    required String message,
  }) async {
    bool? result;
    await Dialogs.materialDialog(
      msgStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
      title: title ,
      msg: message,
      color: primaryColor,
      context: context,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            result = true;
            Navigator.pop(context);
          },
          text:'${getLang(context, 'yes')}',
          iconData: Icons.check,
          textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
          iconColor:  Colors.black,
        ),
        IconsOutlineButton(
          onPressed: () {
            result = false;
            Navigator.pop(context);
          },
          text: '${getLang(context, 'no')}',
          iconData: Icons.close,
          textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
          iconColor: Colors.black,
        ),
      ],
    );
    return result ?? false;
  }




  //
}


enum SnackbarType { success, error, warning, info, other }

class AppSnackbar {
  static void show({
    required BuildContext context,
    String? title, //TODO remove this
    required String message,
    SnackbarType type = SnackbarType.other,
  })
  {
    AnimatedSnackBarType snackBarType = AnimatedSnackBarType.info;
    switch (type) {
      case SnackbarType.success:
        snackBarType = AnimatedSnackBarType.success;
        break;
      case SnackbarType.error:
        snackBarType = AnimatedSnackBarType.error;
        break;
      case SnackbarType.warning:
        snackBarType = AnimatedSnackBarType.warning;
        break;
      case SnackbarType.info:
        snackBarType = AnimatedSnackBarType.info;
        break;
      case SnackbarType.other:
        snackBarType = AnimatedSnackBarType.info;
        break;
    }

    AnimatedSnackBar.material(
      message,
      type: snackBarType,
      duration: Duration(seconds: 6),
      mobileSnackBarPosition:
      MobileSnackBarPosition.top, // Position of snackbar on mobile devices
    ).show(context);
  }
}
