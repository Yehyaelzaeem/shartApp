import 'package:flutter/material.dart';
import '../../../../../shared_screens/register/custom_register_screen.dart';
class ProviderRegisterScreen extends StatelessWidget {
  const ProviderRegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomRegisterScreen(type: 'provider',);
  }
}
