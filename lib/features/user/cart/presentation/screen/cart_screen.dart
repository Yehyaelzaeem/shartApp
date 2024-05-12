import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/features/user/cart/data/model/cart_model.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../shared_screens/visitor_screen/widget/visitor_dailog.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../../../menu/presentation/spare_parts/screens/spare_parts_screen.dart';
import '../../logic/cart_cubit.dart';
import '../widgets/cart_item_widget.dart';
import 'complete_order.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //blueColor
    CartCubit cubit =CartCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar(title: '${getLang(context, 'cart')}',hasBackButton: true,
        onTap: (){
          if(CartCubit.get(context).isAddingAddress==true){
            cubit.changeAddingAddress(false);
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => UserBottomNavScreen(
                  checkPage: '0',
                )));
          }
        },
        ),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (BuildContext context,CartState state) {},
        builder: (BuildContext context,CartState state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: <Widget>[
                    if(cubit.products.isNotEmpty)
                   Padding(
                     padding:  EdgeInsets.only(left: 16.w,right: 16.w,top: 0.h),
                     child: SingleChildScrollView(
                       child: Column(
                         mainAxisSize: MainAxisSize.max,
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           ...cubit.products.map((Cart e) {
                             return Padding(
                               padding:  EdgeInsets.only(top: 12.h),
                               child: CardItem(e),
                             );
                           }).toList(),
                           SizedBox(height: 30.h,),
                           Padding(
                             padding:  EdgeInsets.only(left: 16.w,right: 16.w),
                             child: Divider(color: dividerColor,thickness: 1,),
                           ),
                           SizedBox(height: 15.h,),
                           Padding(
                             padding:  EdgeInsets.only(right: 30.w,left: 16.w),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text(
                                   getLang(context, 'total_price'),
                                   style:
                                   TextStyle(
                                       fontFamily: FontConstants.Tajawal,
                                       fontSize: 24,
                                       color: blackTextColor,
                                       fontWeight: FontWeight.w700
                                   ),
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   textAlign: TextAlign.start,
                                 ),
                                 Text(
                                   '${CartCubit.get(context).totalPrice()} ${getLang(context, 'rs')}',
                                   style:
                                   TextStyle(
                                       fontFamily: FontConstants.Tajawal,
                                       fontSize: 24,
                                       color: blackTextColor,
                                       fontWeight: FontWeight.w700
                                   ),
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   textAlign: TextAlign.start,
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(height: 150.h,),

                         ],
                       ),
                     ),
                   ),
                    if(cubit.products.isNotEmpty)
                      Positioned(
                      right: 16.w,
                      left: 16.w,
                      bottom: 20.h,
                      child:
                      cubit.isLoadingCart?
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Center(child: CircularProgressIndicator(),),
                      ):
                      CustomElevatedButton(
                          onTap: (){
                            if(AuthCubit.get(context).token.isNotEmpty){
                              CartCubit.get(context).changeStep(0);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context)=>CompleteOrder()));
                            }else{
                              visitorDialog(context);
                              // showToast(text: getLang(context, 'Log_in_first'),state: ToastStates.error, context: context);
                            }

                          },
                          buttonText: getLang(context, 'confirmation'))
                    ),
                    if(cubit.products.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      ),
                    if(cubit.products.isEmpty)
                      Positioned(
                        right: 16.w,
                        left: 16.w,
                        bottom: 20.h,
                        child:
                        CustomElevatedButton(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SparePartsScreen()));
                            },
                            buttonText: getLang(context, 'go_shopping')),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

