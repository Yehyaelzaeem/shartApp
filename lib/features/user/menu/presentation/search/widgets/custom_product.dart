import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import 'package:shart/features/user/menu/data/model/product_model.dart';
import '../../../../../../core/resources/color.dart';

class CustomProductItemSearch extends StatelessWidget {
  const CustomProductItemSearch({super.key, this.productModelData});
  final ProductModelData? productModelData;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          boxShadow: <BoxShadow>[BoxShadow(color: greyColor.withOpacity(0.8), blurRadius: 2, spreadRadius: 1)]),
      child: Column(
        children: <Widget>[
        Container(
          height: 131.h,
          width: MediaQuery.of(context).size.width,
          child:
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            ),
            child: Image.network(productModelData!.images![0].image!,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return Center(child: Text('Error loading image'));
            },),
          ),
        ),
          Expanded(
            child: Center(
              child: Text(
                productModelData!.title!,
                style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                  color: blackTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),



        ],
      ),
    );
  }
}
