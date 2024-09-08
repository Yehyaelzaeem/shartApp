import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/color.dart';

class AuthBackGroundWidget extends StatelessWidget {
  final Widget designScreen;
  const AuthBackGroundWidget({super.key, required this.designScreen});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: 250.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
                color: primaryColor
            ),
          ),
          Positioned(
              top:50.h,
              left: 0,
              right: 0,
              child:
              Center(
                child: Image.asset(

                  ImagesManager.logo5,
                  fit: BoxFit.cover,

                ),
              )),
          Positioned(
            top: 180.h,
            child:
          designScreen,
          )
        ],
      ),
    );
  }
}





