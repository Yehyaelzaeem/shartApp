import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import 'package:shart/features/provider/profile/data/model/wallet_model.dart';
import 'package:shart/features/provider/profile/logic/provider_profile_cubit.dart';
import 'package:shart/features/provider/profile/presentation/wallet/widget/custom_wallet_item.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
    return Scaffold(
      body: BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
        listener: (BuildContext context, ProviderProfileState state){},
        builder: (BuildContext context, ProviderProfileState state) {
          if(cubit.walletModel!=null){
            final WalletModelData data =cubit.walletModel!.data!;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(getLang(context, 'total'),
                            style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                                fontSize: 35.sp,
                                // color: whiteColor,
                                height: 1
                            ),
                          ),
                          Text('${double.parse(data.totalWallets.toString()).toStringAsFixed(1)} ${getLang(context, 'rs')}',
                            style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                                fontSize: 50.sp,
                                color: blackColor,
                                height: 1
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 100.h,
                          width:  MediaQuery.of(context).size.width*0.45,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.all(Radius.circular(10),)
                          ),
                          child:
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 10.w,),
                                Container(
                                    height: 50.w,
                                    width: 50.w,
                                    child: Image.asset(ImagesManager.rs,color: whiteColor,)),
                                SizedBox(width: 10.w,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(getLang(context, 'un_paid'),
                                        style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                                            fontSize: 25.sp,
                                            height: 1,
                                            color: whiteColor
                                        ),
                                      ),
                                      SizedBox(height: 15.h,),
                                      FittedBox(
                                        child: Text('${double.parse(data.unpaidWallets.toString()).toStringAsFixed(1)}\n ${getLang(context, 'rs')}',
                                          style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                                              fontSize: 30.sp,
                                              color: blackColor,
                                              height: 0.45,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5.w,),

                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 100.h,
                          width:  MediaQuery.of(context).size.width*0.45,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange.shade300,
                              borderRadius: BorderRadius.all(Radius.circular(10),)
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 10.w,),
                                Container(
                                    height: 50.w,
                                    width: 50.w,
                                    child: Image.asset(ImagesManager.rs,color: whiteColor,)),
                                SizedBox(width: 10.w,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(width: 10.w,),
                                      Text(getLang(context, 'paid'),
                                        style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                                            fontSize: 25.sp,
                                            color: whiteColor,
                                            height: 0.45
                                        ),
                                      ),
                                      SizedBox(height: 15.h,),
                                      FittedBox(
                                        child: Text('${double.parse(data.paidWallets.toString()).toStringAsFixed(1)} \n ${getLang(context, 'rs')}',
                                          style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                                              fontSize: 30.sp,
                                              color: blackColor,
                                              height: 0.45
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5.w,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  ...data.wallets!.map((e) => CustomWalletItem(wallets: e,)),
                  SizedBox(height: 10.h,),
                ],
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
