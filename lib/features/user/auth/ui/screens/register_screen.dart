import 'package:flutter/material.dart';
import '../../../../../shared_screens/register/custom_register_screen.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      CustomRegisterScreen(type: 'user',);
  }
}
