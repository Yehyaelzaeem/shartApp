import 'package:flutter/material.dart';
import '../../../../../shared_screens/messages/custom_messages_screen.dart';

class UserMessagesScreen extends StatelessWidget {
  const UserMessagesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomMessagesScreen(type: 'user',);
  }
}
