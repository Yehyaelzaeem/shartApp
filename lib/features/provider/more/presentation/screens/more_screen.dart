import 'package:flutter/material.dart';
import '../../../../../shared_screens/more_screen/custom_more_screen.dart';

class ProviderMoreScreen extends StatelessWidget {
  const ProviderMoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomMoreScreen(type: 'provider',);
  }
}
