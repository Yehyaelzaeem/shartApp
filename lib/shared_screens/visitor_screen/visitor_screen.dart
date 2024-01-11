import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/widgets/custom_button.dart';

import '../../core/resources/font_manager.dart';
import '../../features/common/intro/presentation/screens/choose_user_type_screen.dart';

class CustomVisitorScreen extends StatelessWidget {
  const CustomVisitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(getLang(context, 'Log_in_first'),
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeightManager.bold,
            color: Colors.black,
            fontFamily: FontConstants.lateefFont,
          ),
          ),
          SizedBox(height: 50.h,),
          Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50),
            child: CustomElevatedButton(onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ChooseUserTypeScreen()));
            },
                buttonText: '${getLang(context, 'sign_up')}'),
          ),
        ],
      ),
    );
  }
}
