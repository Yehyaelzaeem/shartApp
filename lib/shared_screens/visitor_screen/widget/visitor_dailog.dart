
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/appLocale.dart';
import '../../../features/common/intro/presentation/screens/choose_user_type_screen.dart';
import '../../../widgets/custom_alert_dialog.dart';

void visitorDialog(BuildContext context){
  CustomDialogs.showAlertDialog(
    type: DialogType.info,
    btnOkOnPress: () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ChooseUserTypeScreen()));
    },
    ctx: context,
    btnCancelOnPress: () {},
    title: getLang(context,'sign_up'),
    desc: getLang(context, 'Log_in_first'),
    btnOkText: getLang(context, 'sign'),
    btnCancelText:getLang(context, 'back'),
  );
}