import 'package:flutter/material.dart';
import '../../../../../shared_screens/more_screen/custom_more_screen.dart';
import '../../../profile/logic/user_profile_cubit.dart';
class UserMoreScreen extends StatelessWidget {
  const UserMoreScreen({Key? key}) : super(key: key);
  // @override
  @override
  Widget build(BuildContext context) {
    UserProfileCubit cubit =UserProfileCubit.get(context);
    return CustomMoreScreen(type: 'user',);
  }
}
