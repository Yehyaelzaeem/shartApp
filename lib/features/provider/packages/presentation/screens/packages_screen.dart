import 'package:flutter/material.dart';
import '../../../../../shared_screens/pachages/custom_packages_screen.dart';

class ProviderPackagesScreen extends StatelessWidget {
  const ProviderPackagesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPackagesScreen(type: 'provider',);
  }
}
