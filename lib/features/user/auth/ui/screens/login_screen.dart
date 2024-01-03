import 'package:flutter/material.dart';
import '../../../../../shared_screens/login/custom_login_screen.dart';
class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomLoginScreen(type: 'user',);
  }
}
