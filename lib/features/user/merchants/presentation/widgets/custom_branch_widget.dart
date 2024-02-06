import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/font_manager.dart';

import '../../../../../core/resources/color.dart';

class CustomBranchAddressesWidgetTabBar extends StatelessWidget {
  const CustomBranchAddressesWidgetTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0,left: 16.0),
      child: Column(
        children: [
          SizedBox(height: 20.h,),
          Row(
            children: [
              Icon(Icons.location_on_outlined,color: highGreyColor,),
              SizedBox(width: 5.w,),
              Text('طريق طلحة بن عبيد الله بحى النسيم الشرقى بالرياض',
              style: TextStyle(
                fontSize: 16,
                fontFamily: FontConstants.lateefFont,
                fontWeight: FontWeight.w400,
                color: Color(0xff4B4B4B)
              ),

              )
            ],
          ),
          SizedBox(height: 15.h,),
          Row(
            children: [
              Icon(Icons.location_on_outlined,color: highGreyColor,),
              SizedBox(width: 5.w,),
              Text('طريق طلحة بن عبيد الله بحى النسيم الشرقى بالرياض',
              style: TextStyle(
                fontSize: 16,
                fontFamily: FontConstants.lateefFont,
                fontWeight: FontWeight.w400,
                color: Color(0xff4B4B4B)
              ),

              )
            ],
          ),
          SizedBox(height: 15.h,),
          Row(
            children: [
              Icon(Icons.location_on_outlined,color: highGreyColor,),
              SizedBox(width: 5.w,),
              Text('طريق طلحة بن عبيد الله بحى النسيم الشرقى بالرياض',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontConstants.lateefFont,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4B4B4B)
                ),

              )
            ],
          ),
          SizedBox(height: 15.h,),
          Row(
            children: [
              Icon(Icons.location_on_outlined,color: highGreyColor,),
              SizedBox(width: 5.w,),
              Text('طريق طلحة بن عبيد الله بحى النسيم الشرقى بالرياض',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontConstants.lateefFont,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4B4B4B)
                ),

              )
            ],
          ),
          SizedBox(height: 15.h,),

        ],
      ),
    );
  }
}
