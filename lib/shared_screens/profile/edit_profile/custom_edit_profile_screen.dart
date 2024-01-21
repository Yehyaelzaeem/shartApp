import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/shared_screens/profile/edit_profile/widget/custom_edit_profile_body_widget.dart';
import '../../../features/provider/auth/logic/auth_provider_cubit.dart';
import '../../../features/provider/profile/logic/provider_profile_cubit.dart';
import '../../../features/user/profile/logic/user_profile_cubit.dart';
import '../../../widgets/custom_app_bar.dart';

class CustomEditProfileScreen extends StatelessWidget {
  const CustomEditProfileScreen({super.key, required this.type});
 final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:  PreferredSize(
          preferredSize: Size(double.infinity, 80.h),
          child:
          CustomAppBar(title: getLang(context, 'edit_profile'), hasBackButton: true,
            onTap: (){
              ProviderProfileCubit.get(context).getProviderProfile('${AuthProviderCubit.get(context).token}', context);
              Navigator.pop(context);
            },
          )),
      body:
      type=='user'?
      BlocConsumer<UserProfileCubit,UserProfileState>(
        listener: (BuildContext context, UserProfileState state) {},
        builder: (BuildContext context, UserProfileState state) {
         return CustomEditProfileBodyWidget(type: 'user', userCubit: UserProfileCubit.get(context), providerCubit: ProviderProfileCubit.get(context),);
        },
      ):
      BlocConsumer<ProviderProfileCubit,ProviderProfileState>(
        listener: (BuildContext context, ProviderProfileState state) {},
        builder: (BuildContext context, ProviderProfileState state) {
         return CustomEditProfileBodyWidget(type: 'provider', userCubit: UserProfileCubit.get(context), providerCubit: ProviderProfileCubit.get(context),);
        },
      ),
    );
  }
}
