import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
import 'cart_screen.dart';

class CartBottomNavScreen extends StatelessWidget {
  const CartBottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  PopScope(
        canPop: false,
        onPopInvoked: (_) async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => UserBottomNavScreen(
                checkPage: '0',
              )));
        },
        child: CartScreen());
  }
}
