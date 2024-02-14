import 'package:flutter/material.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';

class CustomMaterialButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double padding;

  const CustomMaterialButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = primaryColor,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.padding = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MaterialButton(
        onPressed: onPressed,
        color: color,
        textColor: textColor,
        padding: EdgeInsets.all(padding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(text,
          style: TextStyle(
            fontSize: 20,
            fontFamily: FontConstants.lateefFont,
            color: textColor, fontWeight: FontWeight.w600
          ),
          ),
        ),
      ),
    );
  }
}
