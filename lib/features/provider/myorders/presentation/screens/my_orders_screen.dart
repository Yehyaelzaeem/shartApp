import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/provider/myorders/data/models/provider_order_model.dart';
import 'package:shart/features/provider/myorders/logic/provider_orders_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../widgets/custom_product_widget.dart';
import '../../../../user/myorders/presentation/screens/order_details.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav.dart';
import '../widgets/custom_myorders_widget.dart';
import 'order_details_provider.dart';

class ProviderOrdersScreen extends StatelessWidget {
  const ProviderOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderOrdersCubit cubit =ProviderOrdersCubit.get(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                ProviderBottomNavScreen(
                  checkPage: '0',
                )));
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, 80.h),
              child: CustomAppBar(
                title: '${getLang(context, 'my_requests')}',
              )),

          body:
          BlocConsumer<ProviderOrdersCubit, ProviderOrdersState>(
            listener: (BuildContext context,ProviderOrdersState state) {},
            builder: (BuildContext context, ProviderOrdersState state) {
              if(cubit.myOrdersCurrent!=null){
                if(cubit.myOrdersCurrent!.data!.length==0){
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
                  List<ProviderOrderModelData> data =(cubit.myOrdersCurrent!.data!);
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (BuildContext context)=>OrderDetailsProviderScreen(
                                isAccess: true,
                                providerOrderModelData: data[index],)));
                          },
                        child:
                        Padding(padding:
                        EdgeInsets.only(left: 16.w, right: 16.w,), child:
                        CustomProductMyOrderWidget(
                          providerOrderModelData: data[index] ,),
                        ),

                      );
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                  );
                }
              }else{
                return Center(child: CircularProgressIndicator(),);
              }

            },
          )

      ),
    );
  }
}
