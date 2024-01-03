import 'package:flutter/material.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import '../../../../../../shared_screens/profile/edit_profile/custom_edit_profile_screen.dart';
import '../../../logic/user_profile_cubit.dart';
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserProfileCubit cubit =UserProfileCubit.get(context);
    return WillPopScope(
      onWillPop:(){
        UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token}', context);
        Navigator.pop(context);
        return Future.value(false);
      },
      child:
      CustomEditProfileScreen(type: 'user',)
    );
  }
}
