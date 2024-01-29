import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/show_toast_widget.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_button.dart';
import '../../logic/cart_cubit.dart';
import 'custom_address-user_widget.dart';
import 'custom_cart_items_colum.dart';

class CustomStepBody1Widget extends StatelessWidget {
  const CustomStepBody1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    CartCubit cubit =CartCubit.get(context);
    return
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomCatItemsColumWidget(),
            SizedBox(height: 32.h,),
            CustomAddressUserWidget(),
            CustomElevatedButton(
                onTap: (){
                  if(cubit.addressController.text.isNotEmpty&& cubit.addressLocationModel!=null&&
                  cubit.addressStreetController.text.isNotEmpty&&cubit.addressNuHouseController.text.isNotEmpty&&
                  cubit.addressMarkController.text.isNotEmpty){
                    CartCubit.get(context).changeStep(1);
                  }else{
                    showToast(text: 'complete address data', state: ToastStates.error, context: context);
                  }
                },
                buttonText: getLang(context, 'next')),
            SizedBox(height: 20.h,),

          ],
        ),
      );
  }
}
