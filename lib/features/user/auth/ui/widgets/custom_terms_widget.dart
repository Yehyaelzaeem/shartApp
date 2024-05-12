import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/features/provider/profile/logic/provider_profile_cubit.dart';
import 'package:shart/widgets/custom_loading2_widget.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/themes/styles/styles.dart';
import '../../../../../widgets/custom_show_dialog.dart';
import '../../../profile/logic/user_profile_cubit.dart';
import '../../logic/auth_cubit.dart';

class CustomTermsWidget extends StatefulWidget {
  const CustomTermsWidget({super.key});

  @override
  State<CustomTermsWidget> createState() => _CustomTermsWidgetState();
}

class _CustomTermsWidgetState extends State<CustomTermsWidget> {
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit=AuthCubit.get(context);
    UserProfileCubit userProfileCubit=UserProfileCubit.get(context);
    userProfileCubit.getTermsAndConditionsUser(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {},
      builder: (BuildContext context, AuthState state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 4),
          child: Row(
            children: <Widget>[
              SizedBox(width: 16.w,),
              SizedBox(
                  width: 16,
                  height: 16,
                  child:
                  StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState) {
                    return Checkbox(
                      side: const BorderSide(color: Color(0xff929D9C)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: cubit.isChecked,
                      activeColor: primaryColor,
                      onChanged: (bool? value) {
                        setState(() {
                          cubit.isChecked = value!;
                          if (cubit.isChecked == true) {
                           cubit.changeColor(highGreyColor);
                          }
                        });
                      },
                    );
                  },)
              ),
              SizedBox(width: 10.w,),
              Text(getLang(context,'agree'),
                style:
                TextStyles.font12BlackColor700WeightTajawal.copyWith(
                    color: cubit.color,
                  fontSize: 14,
                  fontFamily: FontConstants.lateefFont
                ),
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
//                ProviderProfileCubit.get(context).termsAndConditionsProvider !=null?
              BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return
                    InkWell(
                    onTap: () {
                     try{
                       if(userProfileCubit.termsAndConditionsUser!=null){
                         customShowDialog(title: userProfileCubit.termsAndConditionsUser!.data!.name!,
                             body: userProfileCubit.termsAndConditionsUser!.data!.content!,
                             onPressed: () {
                               cubit.changeCheck(true);
                               Navigator.of(context).pop();
                               },
                             context: context);
                       }else{
                         showDialog(context: context, builder: (BuildContext context)=>CustomLoading2Widget());
                       }
                     }catch(e){
                       print(e.toString());
                     }

                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(getLang(context,'terms_conditions'),
                        style:
                        TextStyles.font15BlueColor500WeightTajawal.copyWith(
                            color: cubit.color2,
                          fontFamily: FontConstants.lateefFont
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
