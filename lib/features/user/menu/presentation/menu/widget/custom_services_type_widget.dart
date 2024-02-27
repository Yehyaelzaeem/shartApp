import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/routing/navigation_services.dart';

class CustomServicesTypeWidget extends StatelessWidget {
   CustomServicesTypeWidget({super.key, this.image, this.text , this.onTap, this.color});
  void Function()? onTap;
  Color? color;
  final String? image;
  final  String? text;
  @override
  Widget build(BuildContext context) {
    return    GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(16.w),
        width: double.infinity,
        height: 103.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(image!),
            SizedBox(width: 24.w),
            Expanded(
              child: Text(
                text!,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeightManager.light,
                  height: 1,
                  fontFamily: FontConstants.lateefFont,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
