import 'package:flutter/material.dart';
import '../../../../../shared_screens/favorite/custom_favorite_screen.dart';

class UserFavoriteScreen extends StatelessWidget {
  const UserFavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomFavoriteScreen(type: 'user',);
  }
}
