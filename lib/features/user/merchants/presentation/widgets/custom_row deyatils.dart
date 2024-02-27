import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';

import '../../../../../core/resources/font_manager.dart';
import '../../../../provider/work_and_products/data/model/product_model.dart';

class CustomRowDetails extends StatelessWidget {
  const CustomRowDetails({super.key,this.title, this.value, this.dis, this.color, this.fontSize});
  final String? title;
  final String? value;
  final double? dis;
  final double? fontSize;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: <Widget>[
        Container(
          width: dis?? 60.w,
          child: Text(
             title!,
              style: TextStyles.font16GeryColor400WeightTajawal.copyWith(
                fontFamily: FontConstants.lateefFont,
                color: color??null,
                fontSize: fontSize??null
              ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Container(
          width:  120.w,
          child: Text(
             ': ${value!}',
              style:
              TextStyles.font16BlackColor500WeightTajawal.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: FontConstants.lateefFont,
                color: color??null,
                fontSize: fontSize??null
              ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),

      ],
    );
  }
}
