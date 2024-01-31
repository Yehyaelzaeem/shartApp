import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button.dart';
import '../../logic/cart_cubit.dart';

import '../widgets/custom_cart_items_colum.dart';
import '../widgets/custom_steo3_body.dart';
import '../widgets/custom_step1_body.dart';
import '../widgets/custom_step2_body.dart';

class CompleteOrder extends StatelessWidget {
  const CompleteOrder({super.key});

  @override
  Widget build(BuildContext context) {
      CartCubit cubit =CartCubit.get(context);
       cubit.getLocation(context);
     return BlocConsumer<CartCubit,CartState>(builder: (context,state){
       if(cubit.products.isNotEmpty){
         return
           Scaffold(
               appBar: PreferredSize(
                 preferredSize: Size(double.infinity, 80.h),
                 child:
                 cubit.currentStep!=2?
                 CustomAppBar(title: '${getLang(context, 'confirmation')}',hasBackButton: true,
                   onTap: (){
                     // if(CartCubit.get(context).isAddingAddress==true){
                     //   cubit.changeAddingAddress(false);
                     // }else{
                     //   Navigator.of(context).pop();
                     // }
                   },
                 ):
                 CustomAppBar(title: '${getLang(context, 'payment_method')}',hasBackButton: true,),
               ),
               body: Theme(
                   data: ThemeData(
                       primaryColor: Color(0xff136B79)
                   ),
                   child:
                   Stepper(
                     type: StepperType.horizontal,
                     currentStep: cubit.currentStep,
                     elevation: 0,
                     onStepTapped: (int step) {
                       cubit.changeStep(step);
                     },
                     steps: <Step>[
                       Step(
                         title: SizedBox.shrink(),
                         content: CustomStepBody1Widget(),
                         isActive:cubit.currentStep >=0 ,
                         state:  cubit.currentStep >=0 ? StepState.complete : StepState.indexed,
                       ),
                       Step(
                         title: SizedBox.shrink(),
                         content: CustomStep2BodyWidget(),
                         isActive: cubit.currentStep >=1 ,
                         state:  cubit.currentStep >=1 ? StepState.complete : StepState.indexed,
                       ),
                       Step(
                         title:  SizedBox.shrink(),
                         content: CustomStep3BodyWidget(),
                         isActive: cubit.currentStep >=2,
                         state:  cubit.currentStep >=2 ? StepState.complete : StepState.indexed,
                       ),
                     ],
                     controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
                       return SizedBox.shrink(); // Return an empty container to hide the buttons
                     },
                   )
               )

           );
       }
       else{
         return Center(child: CircularProgressIndicator(),);
       }
     }, listener: (context,state){});
  }
}

