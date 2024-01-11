import 'package:flutter/material.dart';
import '../../../../../shared_screens/login/custom_login_screen.dart';

class ProviderLoginScreen extends StatelessWidget {
  const ProviderLoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      CustomLoginScreen(type: 'provider',);
  }
}
