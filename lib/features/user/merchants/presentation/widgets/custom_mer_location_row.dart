import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import '../../../../../core/helper/my_date_util.dart';
import '../../../../../core/resources/color.dart';
import '../../data/models/mer_address.dart';

class CustomMerLocationRow extends StatelessWidget {
  const CustomMerLocationRow({super.key, required this.merchantsAddressModelData});
  final MerchantsAddressModelData merchantsAddressModelData;
  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap: (){
        MyDateUtil.lunchMap(LatLng(double.parse(merchantsAddressModelData.lat??''), double.parse(merchantsAddressModelData.lng??'')));
      },
      child:   Row(
        children: <Widget>[
          Icon(Icons.location_on_outlined,color: highGreyColor,),
          SizedBox(width: 5.w,),
          Text(merchantsAddressModelData.address!,
              style: TextStyles.font16GeryColor400WeightLateefFont
          )
        ],
      ),
    );
  }
}
