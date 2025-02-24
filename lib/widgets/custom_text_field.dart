import 'package:flutter/material.dart';

import '../core/functions/general_functions.dart';
import 'input_decoration.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon? prefixIcon;
   final IconButton? suffixIcon;
  final bool? enabled;
  final int? maxLines;
  final bool? isPassword;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? validationMessage;
  final Color? hintColor;
  final String?  hintFontFamily  ;
  final Color? prefixIconColor;
  final double? contentHorizontalPadding;
  final double? contentVerticalPadding;
  final Color? fillColor;
  final Color? borderColor;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? Function(String?)? validationFunc;
  void Function(String)? onFieldSubmitted;
  void Function(String)? onChanged;
  final  void Function()? onTap;
  TextStyle? hintStyle;
  CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.prefixIconColor,
    this.fillColor,
    this.contentHorizontalPadding,
    this.contentVerticalPadding,
    this.maxLines,
    this.hintFontFamily,
    this.validationMessage,
    this.isPassword,
    this.borderColor,
    this.fontWeight,
    this.fontSize,
    this.borderRadius,
    this.enabled,
    this.textInputType,
    this.textInputAction,
    this.validationFunc,
    this.hintStyle,
    this.hintColor,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.onChanged, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      obscureText: isPassword ?? false,
      maxLines: maxLines ?? 1,
      decoration: customInputDecoration(
        fontSize: fontSize,
        fontWeight: fontWeight,
        hintStyle:hintStyle ,
        hintText: hintText,
        contentHorizontalPadding: contentHorizontalPadding??15,
        contentVerticalPadding: contentVerticalPadding,
        borderRadius: borderRadius,
        borderColor: borderColor,
        prefixIconColor: prefixIconColor,
        prefixIcon: prefixIcon,
        hintFontFamily: hintFontFamily,
        suffixIcon: suffixIcon,
        enabled: enabled,
        hintColor: hintColor,
        fillColor: fillColor,
      ),

      validator: validationFunc,
      onSaved: (String? val) {
        controller.text = val!;
      },
      onTap: onTap,
      cursorWidth: 1,
      onTapOutside: (_) => GeneralFunctions.hideKeyboard(),
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: textInputType ?? TextInputType.text,
      onChanged:onChanged ,
    );
  }
}
