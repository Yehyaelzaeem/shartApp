import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../logic/merchants_cubit.dart';
import 'custom_mer_location_row.dart';

class CustomBranchAddressesWidgetTabBar extends StatelessWidget {
  const CustomBranchAddressesWidgetTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit=MerchantsCubit.get(context);

    return BlocConsumer<MerchantsCubit, MerchantsState>(
      listener: (BuildContext context,MerchantsState state) {},
      builder: (BuildContext context,MerchantsState state) {
        if(cubit.merchantsAddressModel!=null){
              if(cubit.merchantsAddressModel!.data!.length==0){
              return Center(child: Text('${getLang(context, 'no_data')}'),);}
              else
              {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16),
                  child:
                  ListView.separated(
                    itemCount:cubit.merchantsAddressModel!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomMerLocationRow(merchantsAddressModelData: cubit.merchantsAddressModel!.data![index],);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10.h,);
                    },
                  ),
                );
              }
             }
        else{
          return Center(child: CircularProgressIndicator(),);
        }

      },
    );
  }
}
