import 'package:flutter/material.dart';
import '../../../../../shared_screens/favorite/custom_favorite_screen.dart';

class ProviderFavoriteScreen extends StatelessWidget {
  const ProviderFavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomFavoriteScreen(type: 'provider',);
  }
}
