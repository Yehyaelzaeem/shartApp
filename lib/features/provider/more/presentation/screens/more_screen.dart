import 'package:flutter/material.dart';
import '../../../../../shared_screens/more_screen/custom_more_screen.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav.dart';

class ProviderMoreScreen extends StatelessWidget {
  const ProviderMoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (_) async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProviderBottomNavScreen(
                checkPage: '0',
              )));
        },
        child: CustomMoreScreen(type: 'provider',));
  }
}
