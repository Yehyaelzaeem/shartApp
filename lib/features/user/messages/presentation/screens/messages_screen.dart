import 'package:flutter/material.dart';
import '../../../../../shared_screens/messages/custom_messages_screen.dart';
import '../../../../../shared_screens/visitor_screen/visitor_screen.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';

class UserMessagesScreen extends StatelessWidget {
  const UserMessagesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (_) async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => UserBottomNavScreen(
                checkPage: '0',
              )));
        },
        child:
        AuthCubit.get(context).token.isEmpty?
        CustomVisitorScreen(): CustomMessagesScreen(type: 'user',));
  }
}
