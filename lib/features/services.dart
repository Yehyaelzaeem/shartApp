import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static Future<dynamic> push(BuildContext context, String routeName) {
    return Navigator.of(context).pushNamed(routeName);
  }

  static Future<dynamic> pushReplacement(
      BuildContext context, String routeName) {
    return Navigator.of(context).pushReplacementNamed(routeName);
  }

  static void pop(BuildContext context) {
    return Navigator.of(context).pop();
  }
}
