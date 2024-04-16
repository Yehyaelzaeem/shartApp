import 'package:flutter/material.dart';
import '../../../../../shared_screens/more_screen/custom_more_screen.dart';
import '../../../../../shared_screens/visitor_screen/visitor_screen.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../../../profile/logic/user_profile_cubit.dart';
class UserMoreScreen extends StatelessWidget {
  const UserMoreScreen({Key? key}) : super(key: key);
  // @override
  @override
  Widget build(BuildContext context) {
    UserProfileCubit cubit =UserProfileCubit.get(context);
    return PopScope(
        canPop: false,
        onPopInvoked: (_) async {
           Navigator.of(context).pushReplacement(MaterialPageRoute(
               builder: (BuildContext context) => UserBottomNavScreen(
                 checkPage: '0',
               )));
        },
        child:  AuthCubit.get(context).token.isEmpty?
        CustomVisitorScreen():  CustomMoreScreen(type: 'user',));
  }
}
