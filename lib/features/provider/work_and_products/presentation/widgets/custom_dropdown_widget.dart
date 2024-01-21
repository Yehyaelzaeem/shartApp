import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color.dart';

class CustomDropdownWidget extends StatelessWidget {
  const CustomDropdownWidget({super.key, required this.text, this.onChanged, required this.items, this.iconStyleData, this.buttonStyleData});
   final String text;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;
  final IconStyleData? iconStyleData;
  final ButtonStyleData? buttonStyleData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: DropdownButton2<String>(
        isExpanded: true,
        underline: const SizedBox.shrink(),
        hint: Text(
          '${text}',
          style: TextStyle( fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: items,
        onChanged:onChanged,
        iconStyleData: iconStyleData ??IconStyleData(),

        buttonStyleData:buttonStyleData?? ButtonStyleData(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8.r))),
      ),
    );
  }
}
