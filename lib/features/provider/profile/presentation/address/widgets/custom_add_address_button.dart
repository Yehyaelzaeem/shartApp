import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../../../../core/routing/navigation_services.dart';
import '../../../../../../core/routing/routes.dart';

class CustomAddAddressButton extends StatelessWidget {
  const CustomAddAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: InkWell(
        onTap: () {
          NavigationManager.push(Routes.providerAddAddress);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.add, color: Color(0xff136B79)),
            Text(getLang(context, 'add_main_subtitle'),
                style: TextStyle(
                    color: Color(0xff136B79),
                    fontFamily: 'Lateef',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
