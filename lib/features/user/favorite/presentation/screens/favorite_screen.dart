import 'package:flutter/material.dart';
import '../../../../../shared_screens/favorite/custom_favorite_screen.dart';
import '../../../../../shared_screens/visitor_screen/visitor_screen.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';

class UserFavoriteScreen extends StatelessWidget {
  const UserFavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (_) async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => UserBottomNavScreen(
                checkPage: '0',
              )));
        },
        child:
        AuthCubit.get(context).token.isEmpty?
            CustomVisitorScreen(): CustomFavoriteScreen(type: 'user',));
  }
}
