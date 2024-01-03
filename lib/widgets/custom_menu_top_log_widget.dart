import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/resources/assets_menager.dart';
import '../core/routing/navigation_services.dart';
import '../core/routing/routes.dart';

class CustomTopRowLogo extends StatelessWidget {
  const CustomTopRowLogo({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return   Row(
      children: <Widget>[
        SizedBox(width: 155.w,),
        Image.asset(
          ImagesManager.logoCircle,
        ),
        Spacer(),
        InkWell(
          onTap: () {
            NavigationManager.push(Routes.notifications);
          },
          child: Padding(
              padding: EdgeInsets.only(top: 10, left: 10.w),
              child: SvgPicture.asset('assets/images/svg/notification.svg')
            // Lottie.asset('assets/json/notification.json',
            //     width: 30.sp, height: 30.sp),
          ),
        ),
        SizedBox(width: 16.w,),
      ],
    );
  }
}
