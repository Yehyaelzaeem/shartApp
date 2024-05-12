import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/provider/myorders/logic/provider_orders_cubit.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_loading2_widget.dart';
import '../../../myorders/data/models/provider_order_model.dart';
import '../../../myorders/presentation/screens/order_details_provider.dart';
import '../../../myorders/presentation/widgets/custom_myorders_widget.dart';

class CustomCurrentOrderHomeWidget extends StatelessWidget {
  const CustomCurrentOrderHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderOrdersCubit cubit =ProviderOrdersCubit.get(context);
    return BlocConsumer<ProviderOrdersCubit, ProviderOrdersState>(
      listener: (BuildContext context,ProviderOrdersState state) {},
      builder: (BuildContext context,ProviderOrdersState state) {
         if(cubit.myOrdersCurrentList!=null){
           if(cubit.myOrdersCurrentList!.length==0){
             return Padding(
               padding: const EdgeInsets.all(40.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Center(child: Image.asset(ImagesManager.cart33)),
                   SizedBox(height: 16.h,),
                   Text(
                     getLang(context, 'no_order_now'),
                     style: TextStyle(
                         fontSize: 20.0,
                         color: blackTextColor,
                         fontFamily: FontConstants.lateefFont,
                         fontWeight: FontWeight.w400
                     ),
                   ),
                 ],
               ),
             );
           }else{
             return ListView.builder(
               itemBuilder: (BuildContext context, int index) {
                 List<ProviderOrderModelData> data =cubit.myOrdersCurrentList!;
                 if(index < data.length){
                   return InkWell(
                     onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder:
                           (BuildContext context)=>OrderDetailsProviderScreen(
                         providerOrderModelData: cubit.myOrdersCurrent!.data![index],isAccess: true,)));
                     },
                     child: CustomProductMyOrderWidget(
                       isHome: true,
                       providerOrderModelData: cubit.myOrdersCurrent!.data![index],
                     ),
                   );
                 }else{
                   if (index == data.length) {
                     if(cubit.loading==true){
                       return Padding(
                         padding: const EdgeInsets.all(8),
                         child: CustomLoading2Widget(color: primaryColor,),
                       );
                     }else{
                       return SizedBox();
                     }
                   } else {
                     return Container(); }
                 }

               },
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemCount: cubit.myOrdersCurrentList!.length+1,
             );
           }
         }else{
           return Padding(
             padding:  EdgeInsets.only(top: 100.h),
             child: Center(child: CircularProgressIndicator(),),
           );
         }

      },
    );
  }
}
