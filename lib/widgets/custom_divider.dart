import 'package:flutter/material.dart';

import '../core/resources/color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Divider(color:dividerColor.withOpacity(0.25) ,
        indent: 0,
        endIndent: MediaQuery.of(context).size.width*0.5,
      ),
    );
  }
}
