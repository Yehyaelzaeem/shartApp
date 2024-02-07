import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/user/merchants/logic/merchants_cubit.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../data/models/mer_model.dart';
import 'custom_mer_product_widget.dart';

class CustomProductsWidgetTabBar extends StatelessWidget {
  const CustomProductsWidgetTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit=MerchantsCubit.get(context);

    return
      BlocConsumer<MerchantsCubit, MerchantsState>(
        listener: (BuildContext context,MerchantsState state) {},
        builder: (BuildContext context,MerchantsState state) {
          if(cubit.productsModel!=null){
              if(cubit.productsModel!.data!.length==0){
                return Center(child: Text('${getLang(context, 'no_data')}'),);
              }else{
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 9.w,
                      mainAxisSpacing: 15.h,
                      // childAspectRatio: 5/6.5
                      mainAxisExtent: 200.h,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return CustomMerProductWidget(productModelData:cubit.productsModel!.data![index],);
                    },
                    shrinkWrap: true,
                    // physics: BouncingScrollPhysics(),
                    itemCount: cubit.productsModel!.data!.length,
                    padding: EdgeInsets.all(16.w),
                  ),
                );
              }
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      );
  }
}
