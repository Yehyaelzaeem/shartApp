import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../logic/user_profile_cubit.dart';
class CustomRadioAddAddressWidget extends StatefulWidget {
  const CustomRadioAddAddressWidget({super.key});

  @override
  State<CustomRadioAddAddressWidget> createState() => _CustomRadioAddAddressWidgetState();
}

class _CustomRadioAddAddressWidgetState extends State<CustomRadioAddAddressWidget> {
  @override
  Widget build(BuildContext context) {
    UserProfileCubit cubit =UserProfileCubit.get(context);

    return      Row(
      children: <Widget>[
        Radio<int>(
          value: 0,
          groupValue: cubit.addressType,
          onChanged: (int? val) {
           cubit.changeRadio(val);
           setState(() {
           });
          },
        ),
        Text(getLang(context, 'main_address2')),
        const Spacer(),
        Radio<int>(
          value: 1,
          groupValue: cubit.addressType,
          onChanged: (int? val) {
            cubit.changeRadio(val);
            setState(() {
            });
          },
        ),
        Text(getLang(context, 'sub_address')),
      ],
    );
  }
}
