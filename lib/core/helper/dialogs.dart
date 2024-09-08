import 'package:flutter/material.dart';

class DialogsClass {
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Colors.blue.withOpacity(.8),
        behavior: SnackBarBehavior.floating));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(
                child: CircularProgressIndicator(
              strokeWidth: 1,
            )));
  }
  Future<bool> confirm(
      BuildContext context, {
        String? title,
        required String message,
      }) async {
    bool? result;
    // await Dialogs.materialDialog(
    //   title: title ?? LocaleKeys.notification.tr(),
    //   msg: message,
    //   color: Colors.white,
    //   context: context,
    //   actions: [
    //     IconsOutlineButton(
    //       onPressed: () {
    //         result = true;
    //         NavigationService.goBack();
    //       },
    //       text: LocaleKeys.yes.tr(),
    //       iconData: Icons.check,
    //       textStyle: TextStyle(color: AppColorLight().kPrimaryColor),
    //       iconColor: AppColorLight().kPrimaryColor,
    //     ),
    //     IconsOutlineButton(
    //       onPressed: () {
    //         result = false;
    //         NavigationService.goBack();
    //       },
    //       text: LocaleKeys.no.tr(),
    //       iconData: Icons.close,
    //       textStyle: TextStyle(color: AppColorLight().kPrimaryColor),
    //       iconColor: AppColorLight().kPrimaryColor,
    //     ),
    //   ],
    // );
    return result ?? false;
  }
}
