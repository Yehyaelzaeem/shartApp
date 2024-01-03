import 'package:flutter/material.dart';
import '../../../../../shared_screens/messages/custom_messages_screen.dart';

class ProviderMessagesScreen extends StatelessWidget {
  const ProviderMessagesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomMessagesScreen(type: 'provider',);
  }
}
