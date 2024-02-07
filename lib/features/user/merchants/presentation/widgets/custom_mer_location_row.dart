import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import '../../../../../core/resources/color.dart';
import '../../data/models/mer_address.dart';

class CustomMerLocationRow extends StatelessWidget {
  const CustomMerLocationRow({super.key, required this.merchantsAddressModelData});
  final MerchantsAddressModelData merchantsAddressModelData;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: <Widget>[
        Icon(Icons.location_on_outlined,color: highGreyColor,),
        SizedBox(width: 5.w,),
        Text(merchantsAddressModelData.address!,
          style: TextStyles.font16GeryColor400WeightLateefFont
        )
      ],
    );
  }
}
