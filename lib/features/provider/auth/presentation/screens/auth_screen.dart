import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../user/auth/ui/widgets/auth_background_widget.dart';
import '../../logic/auth_provider_cubit.dart';
import '../widgets/login_widget.dart';
import '../widgets/register_widget.dart';

class AuthProviderScreen extends StatelessWidget {
  AuthProviderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AuthProviderCubit cubit =AuthProviderCubit.get(context);
    return Scaffold(
      body: BlocConsumer<AuthProviderCubit, AuthProviderState>(
            listener: (BuildContext context, AuthProviderState state) {},
            builder: (BuildContext context, AuthProviderState state) {
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
                              width: 232.w,
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
