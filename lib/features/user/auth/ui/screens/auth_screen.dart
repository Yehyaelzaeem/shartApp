import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/font_manager.dart';
import '../widgets/auth_background_widget.dart';
import '../widgets/login_widget.dart';
import '../widgets/register_widget.dart';

class AuthScreen extends StatelessWidget {
   AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit =AuthCubit.get(context);
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
            listener: (BuildContext context, AuthState state) {},
            builder: (BuildContext context, AuthState state) {
              return AuthBackGroundWidget(
                  designScreen:
                    Container(
                      width: 337.w,
                      height: 600.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xffFDFDFD),
                          boxShadow: <BoxShadow>[BoxShadow(
                              color: Colors.black26,blurRadius: 5
                          )]
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 30.h),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 30.h,
                              width: 235.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  border: Border.all(color: Colors.black38)
                              ),
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                    onTap:(){
                                      cubit.changeType(0);
                                    },
                                    child: Container(
                                      width: 115.w,
                                      decoration: BoxDecoration(
                                          color:  cubit.type==0?primaryColor:whiteColor,
                                          borderRadius: BorderRadius.circular(26),
                                      ),
                                    child: Center(
                                      child: Text(getLang(context, 'entry'),
                                      style: TextStyles.font12BlackColor700WeightTajawal.copyWith(
                                        fontSize: 16,
                                        fontFamily: FontConstants.lateefFont
                                      ),
                                      ),
                                    ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      cubit.changeType(1);
                                    },
                                    child:
                                    Container(
                                      width: 115.w,
                                      decoration: BoxDecoration(
                                          color:  cubit.type==1?primaryColor:whiteColor,
                                          borderRadius: BorderRadius.circular(26),
                                      ),
                                      child: Center(
                                        child: Text(getLang(context, 'register'),
                                          style: TextStyles.font12BlackColor700WeightTajawal.copyWith(
                                              fontSize: 16,
                                              fontFamily: FontConstants.lateefFont
                                          ),
                                        ),)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            cubit.type==0?
                             Expanded(child: LoginWidget()):
                             Expanded(child: RegisterWidget())

                          ],
                        ),
                      ),)
                   );
            },
          ),
    );
  }
}
