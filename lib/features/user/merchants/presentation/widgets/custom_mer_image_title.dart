import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/themes/styles/styles.dart';
import '../../data/models/mer_model.dart';

class CustomMerImageTitleWidget extends StatelessWidget {
  const CustomMerImageTitleWidget({super.key, required this.merchantsModelData});
  final MerchantsModelData merchantsModelData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child:
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              merchantsModelData.logo!,
              errorBuilder: (BuildContext context,Object error,StackTrace? v){
                return Center(child: CircularProgressIndicator(),);
              },
              fit: BoxFit.cover,
              width: 120.w,
              height: 120.w,
            ),
          ),
        ),
        SizedBox(height: 10.h,),
        Center(
          child: Text(merchantsModelData.storeName!,
            style:
              TextStyles.font16BlackColor500WeightTajawal.copyWith(
              fontWeight: FontWeight.w700,)
          ),),
      ],
    );
  }
}
