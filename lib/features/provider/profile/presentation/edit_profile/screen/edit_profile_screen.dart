import 'package:flutter/material.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import '../../../../../../shared_screens/profile/edit_profile/custom_edit_profile_screen.dart';
import '../../../logic/provider_profile_cubit.dart';

class ProviderEditProfileScreen extends StatelessWidget {
  const ProviderEditProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomEditProfileScreen(type: 'provider',);
  }
}
