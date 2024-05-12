import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../../../../core/resources/assets_menager.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/themes/styles/styles.dart';
import '../../../data/model/wallet_model.dart';

class CustomWalletItem extends StatelessWidget {
  const CustomWalletItem({super.key, required this.wallets, });
 final Wallets wallets;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 5.h),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.all(Radius.circular(10),)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(ImagesManager.logo),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(children: [
                      wallets.orderId!=null?
                      Text('${getLang(context, 'order_no')} #${wallets.orderId}',
                        style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                            fontSize: 20.sp,
                            height: 1,
                            color: blackColor
                        ),
                      ):
                      Text('${getLang(context, 'transfer_number')} #${wallets.id}',
                        style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                            fontSize: 20.sp,
                            height: 1,
                            color: blackColor
                        ),
                      ),
                      Text(wallets.date.toString(),
                        style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                            fontSize: 20.sp,
                            height: 1,
                            color: Colors.grey.shade500
                        ),
                      ),
                    ],),
                    wallets.shartAmount!=null?
                    Row(
                      children: <Widget>[
                        Text('${getLang(context,'shart')} : ',
                          style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                              fontSize: 20.sp,
                              height: 1,
                              color: Colors.grey.shade500
                          ),
                        ),
                        Text('${wallets.shartAmount.toString()} ${getLang(context, 'rs')}',
                          style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              height: 1,
                              color: redColor.withOpacity(0.8)
                          ),
                        ),
                      ],
                    )
                        :SizedBox.shrink(),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text('${wallets.providerAmount.toString()} ${getLang(context, 'rs')}',
                    style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: redColor.withOpacity(0.8)
                    ),
                  ),
                  // SizedBox(height: 5.h,),
                  // Text(wallets.status.toString(),
                  //   style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                  //       fontSize: 20.sp,
                  //       height: 1,
                  //       color: Colors.grey.shade500
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
