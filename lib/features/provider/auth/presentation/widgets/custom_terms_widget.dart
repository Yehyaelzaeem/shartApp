import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/features/provider/profile/logic/provider_profile_cubit.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/themes/styles/styles.dart';
import '../../../../../widgets/custom_loading2_widget.dart';
import '../../../../../widgets/custom_show_dialog.dart';

class CustomTermsWidgetProvider extends StatefulWidget {
  const CustomTermsWidgetProvider({super.key});

  @override
  State<CustomTermsWidgetProvider> createState() => _CustomTermsWidgetState();
}

class _CustomTermsWidgetState extends State<CustomTermsWidgetProvider> {
  @override
  Widget build(BuildContext context) {
    AuthProviderCubit cubit=AuthProviderCubit.get(context);
    ProviderProfileCubit profileCubit=ProviderProfileCubit.get(context);
    profileCubit.getTermsAndConditionsProvider(context);
    return BlocConsumer<AuthProviderCubit, AuthProviderState>(
      listener: (BuildContext context, AuthProviderState state) {},
      builder: (BuildContext context, AuthProviderState state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 4),
          child: Row(
            children: [
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
              Text(getLang(context, 'agree'),
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
              BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
                listener: (BuildContext context, ProviderProfileState state) {},
                builder: (BuildContext context, ProviderProfileState state) {
                  return
                    InkWell(
                    onTap: () {
                     try{
                       if(profileCubit.termsAndConditionsProvider!=null){
                         customShowDialog(title: profileCubit.termsAndConditionsProvider!.data!.name!,
                             body: profileCubit.termsAndConditionsProvider!.data!.content!,
                             onPressed: () {
                               cubit.changeCheckProvider(true);
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
                            fontFamily: FontConstants.lateefFont                        ),
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
