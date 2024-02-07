import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/user/merchants/logic/merchants_cubit.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../widgets/custom_merchants_item.dart';
import '../widgets/custom_search_widget.dart';

class MerchantsScreen extends StatelessWidget {
  const MerchantsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit=MerchantsCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(
            title: getLang(context, 'merchants'), hasBackButton: true),
      ),
      body:
      Column(
        children: [
          CustomSearchWidget(),
          BlocConsumer<MerchantsCubit, MerchantsState>(
            listener: (BuildContext context,MerchantsState state) {},
            builder: (BuildContext context, MerchantsState state) {
              if(cubit.isSearching==false){
                if(cubit.merchantsModel!=null){
                  if(cubit.merchantsModel!.data!.length==0){
                    return Expanded(child: Center(child: Text('${getLang(context, 'no_data')}'),));
                  }else{
                    return Expanded(
                      child:
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 9.w,
                          mainAxisSpacing: 15.h,
                          // childAspectRatio: 5/6.5
                          mainAxisExtent: 190.h,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return CustomMerchantsItem(merchantsModelData: cubit.merchantsModel!.data![index],);
                        },
                        shrinkWrap: true,
                        // physics: BouncingScrollPhysics(),
                        itemCount: cubit.merchantsModel!.data!.length,
                        padding: EdgeInsets.all(16.w),
                      ),
                    );
                  }
                }
                else{
                  return Expanded(child: Center(child: CircularProgressIndicator(),));
                }
            }
              else{
                if(cubit.merchantsSearchModel!=null){
                  if(cubit.merchantsSearchModel!.data!.length==0){
                    return Expanded(child: Center(child: Text('${getLang(context, 'no_data_provider')}'),));
                  }else{
                    return Expanded(
                      child:
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 9.w,
                          mainAxisSpacing: 15.h,
                          // childAspectRatio: 5/6.5
                          mainAxisExtent: 190.h,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return CustomMerchantsItem(merchantsModelData: cubit.merchantsSearchModel!.data![index],);
                        },
                        shrinkWrap: true,
                        // physics: BouncingScrollPhysics(),
                        itemCount: cubit.merchantsSearchModel!.data!.length,
                        padding: EdgeInsets.all(16.w),
                      ),
                    );
                  }
                }
                else{
                  return Expanded(child: Center(child: CircularProgressIndicator(),));
                }
              }

            },
          ),
        ],
      ),
    );
  }
}
