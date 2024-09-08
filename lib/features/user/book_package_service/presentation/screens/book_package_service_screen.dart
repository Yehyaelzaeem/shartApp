import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/user/book_package_service/data/model/brand_color_model.dart';
import 'package:shart/features/user/book_package_service/data/model/brand_model.dart';
import 'package:shart/features/user/book_package_service/data/model/brands.dart';
import 'package:shart/features/user/book_package_service/logic/book_package_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';
import 'package:shart/widgets/show_toast_widget.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../shared_screens/visitor_screen/widget/visitor_dailog.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../menu/logic/menu_cubit.dart';
import '../../data/model/check_car_model.dart';
import '../widgets/cutom_text_booking_widget.dart';

class UserBookPackageServiceScreen extends StatelessWidget {
  final String packageId;
   UserBookPackageServiceScreen({Key? key, required this.packageId}) : super(key: key);

  int paymentMethod =0;
  @override
  Widget build(BuildContext context) {
    BookPackageCubit cubit =BookPackageCubit.get(context);
    MenuCubit menuCubit =MenuCubit.get(context);
    cubit.getBrands( context: context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70.h),
          child: CustomAppBar(title: getLang(context, 'booking_details'), hasBackButton: true)),
      body: BlocConsumer<BookPackageCubit, BookPackageState>(
          listener: (BuildContext context, BookPackageState state) {},
          builder: (BuildContext context, BookPackageState state) {
            return SingleChildScrollView(
                  child:Container(
                    padding: EdgeInsets.only( left: 16.w, right: 16.w),
                    margin: EdgeInsets.only(top: 24.h),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffD0D5DD)
                        ),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                    ),
                    child:  BlocConsumer<BookPackageCubit ,BookPackageState>(
                      builder: (BuildContext context ,BookPackageState state){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomTextTitleBookingWidget(text:'${getLang(context, 'brand')} *',topPadding: 25,),
                            StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                              return DropdownButton2<String>(
                                isExpanded: true,
                                underline: const SizedBox.shrink(),
                                hint: Text('${cubit.brandSelectedValue}', style: TextStyle(fontSize: 14, color: Colors.black),),
                                items:
                                cubit.brands.map((BrandsData? e) =>
                                    DropdownMenuItem<String>(
                                      value: e!.name,
                                      child: Text(
                                        e.name!,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    )).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    cubit.brandSelectedValue = value!;
                                    cubit.brandModelSelectedValue='';
                                    for(BrandsData? a in cubit.brands ){
                                      if(cubit.brandSelectedValue==a!.name){
                                        cubit.brandId=a.id!;
                                        cubit.brandSelectedId =a.id!.toString();
                                        cubit.getBrandModel(context);
                                        break;
                                      }
                                    }
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(8.r))),
                              );
                            }),
                            CustomTextTitleBookingWidget(text:'${getLang(context, 'car_model')} *',topPadding: 25,),
                            StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                              return DropdownButton2<String>(
                                isExpanded: true,
                                underline: const SizedBox.shrink(),
                                hint: Text('${cubit.brandModelSelectedValue}', style: TextStyle(fontSize: 14, color: Colors.black),),
                                items: cubit.brandModelList.map((BrandModelData? e) =>
                                    DropdownMenuItem<String>(
                                      value: e!.name,
                                      child: Text(
                                        e.name!,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    )).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    cubit.brandModelSelectedValue = value!;
                                    for(BrandModelData? a in cubit.brandModelList ){
                                      if(cubit.brandModelSelectedValue==a!.name){
                                        cubit.brandModelSelectedId =a.id!.toString();
                                        break;
                                      }
                                    }
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(8.r))),
                              );
                            }),

                            CustomTextTitleBookingWidget(text: '${getLang(context, 'color')} *',
                              topPadding: 25,),
                            // StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                            //   return DropdownButton2<String>(
                            //     isExpanded: true,
                            //     underline: const SizedBox.shrink(),
                            //     hint: Text('${cubit.colorSelectedValue}', style: TextStyle(fontSize: 14, color: Colors.black),),
                            //     items: cubit.brandColorsList.map((BrandColorsData? e) =>
                            //         DropdownMenuItem<String>(
                            //           value: e!.name,
                            //           child: Text(
                            //             e.name!,
                            //             style: const TextStyle(fontSize: 14),
                            //           ),
                            //         )).toList(),
                            //     onChanged: (String? value) {
                            //       setState(() {
                            //         cubit.colorSelectedValue = value!;
                            //         for(BrandColorsData? a in cubit.brandColorsList ){
                            //           if(cubit.colorSelectedValue==a!.name){
                            //             cubit.brandId=a.id!;
                            //             cubit.colorSelectedId =a.id!.toString();
                            //             break;
                            //           }
                            //         }
                            //       });
                            //     },
                            //     buttonStyleData: ButtonStyleData(
                            //         decoration: BoxDecoration(
                            //             border: Border.all(color: Colors.grey.withOpacity(0.5)),
                            //             borderRadius: BorderRadius.circular(8.r))),
                            //   );
                            // }),
                            Padding(
                              padding: EdgeInsets.only(bottom: 0.h),
                              child: CustomTextField(
                                // textInputType: TextInputType.number,
                                  hintText: '',
                                  onChanged: (String value){
                                    cubit.colorSelectedId =value;
                                  },
                                  hintColor: Colors.black,
                                  controller: cubit.colorController),
                            ),

                            CustomTextTitleBookingWidget(text: '${getLang(context, 'manufacturing_year')} *',topPadding: 25,),
                            // StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                            //   return DropdownButton2<String>(
                            //     isExpanded: true,
                            //     underline: const SizedBox.shrink(),
                            //     hint: Text(
                            //       '${cubit.yearSelectedValue}',
                            //       style: TextStyle(fontSize: 14, color: Colors.black),
                            //     ),
                            //     items: <String>['2019', '2022', '2023','2024']
                            //         .map((String item) => DropdownMenuItem<String>(
                            //       value: item,
                            //       child: Text(
                            //         item,
                            //         style: const TextStyle(fontSize: 14),
                            //       ),
                            //     ))
                            //         .toList(),
                            //     onChanged: (String? value) {
                            //       setState(() {
                            //         cubit.yearSelectedValue = value!;
                            //       });
                            //     },
                            //     buttonStyleData: ButtonStyleData(
                            //         decoration: BoxDecoration(
                            //             border: Border.all(
                            //                 color: Colors.grey.withOpacity(0.5)),
                            //             borderRadius: BorderRadius.circular(8.r))),
                            //   );
                            // }),
                            Padding(
                              padding: EdgeInsets.only(bottom: 0.h),
                              child: CustomTextField(
                                  textInputType: TextInputType.number,
                                  hintText: '',
                                  hintColor: Colors.black,
                                  controller: cubit.yearSelectedValue),
                            ),
                            CustomTextTitleBookingWidget(
                              text: '${getLang(context, 'chassis_chassis_number')} *',topPadding: 25,),
                            Padding(
                              padding: EdgeInsets.only(bottom: 25.h),
                              child: CustomTextField(
                                // textInputType: TextInputType.number,
                                  hintText: '',
                                  hintColor: Colors.black,
                                  controller: cubit.chassisController),
                            ),
                            CustomTextTitleBookingWidget(text: getLang(context, 'comment',),
                              topPadding: 5,),
                            CustomTextField(
                                maxLines: 3,
                                hintText: '',
                                controller: cubit.descriptionController,
                                hintColor: Colors.black),
                            SizedBox(height: 50.h,),
                            menuCubit.paymentVisibilityModel!=null?
                            menuCubit.paymentVisibilityModel!.data!.visibility==1?
                           // cubit.isLoading?Padding(
                           //   padding: EdgeInsets.symmetric(vertical: 30.h),
                           //   child: Center(child: CircularProgressIndicator(),),
                           // ):
                           Padding(
                              padding: EdgeInsets.symmetric(vertical: 30.h),
                              child: CustomElevatedButton(
                                  onTap: () {
                                if(AuthCubit.get(context).token.isNotEmpty){
                                  if(packageId.isNotEmpty&&cubit.brandSelectedId.isNotEmpty &&
                                      cubit.brandModelSelectedId.isNotEmpty && cubit.colorSelectedId.isNotEmpty&&
                                      cubit.yearSelectedValue.text.isNotEmpty&&cubit.chassisController.text.isNotEmpty)
                                  {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: 300.h,
                                            width: 343.w,
                                            child:
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Align(
                                                  alignment: AlignmentDirectional.topEnd,
                                                  child: IconButton(
                                                    icon: Icon(Icons.clear),
                                                    onPressed: (){
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),),
                                                Text(
                                                  getLang(context, 'payment_method'),
                                                  style:
                                                  TextStyle(
                                                      fontFamily: FontConstants.lateefFont,
                                                      fontSize: 30.sp,
                                                      color: blackTextColor,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                ),
                                                StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState)
                                                {
                                                  return Column(
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Image.asset(ImagesManager.visa),
                                                              SizedBox(width: 5.w,),
                                                              Text(getLang(context, 'visa'),
                                                                style:   TextStyle(
                                                                    fontFamily: FontConstants.lateefFont,
                                                                    fontSize: 20,
                                                                    color: blackTextColor,
                                                                    fontWeight: FontWeight.w400
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Radio<int>(
                                                            value: 0,
                                                            groupValue: paymentMethod,
                                                            onChanged: (int? value) {
                                                              setState(() {
                                                                paymentMethod = value!;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      //payment
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Image.asset(ImagesManager.card2),
                                                              SizedBox(width: 5.w,),
                                                              Text(getLang(context, 'master_card'),
                                                                style:   TextStyle(
                                                                    fontFamily: FontConstants.lateefFont,
                                                                    fontSize: 20,
                                                                    color: blackTextColor,
                                                                    fontWeight: FontWeight.w400
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Radio<int>(
                                                            value: 1,
                                                            groupValue: paymentMethod,
                                                            onChanged: (int? value) {
                                                              setState(() {
                                                                paymentMethod = value!;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      BlocConsumer<BookPackageCubit, BookPackageState>(
                                                                      listener: (BuildContext context, BookPackageState state) {},
                                                                      builder: (BuildContext context, BookPackageState state)
                                                                      {
                                                                        return Column(
                                                                              children: <Widget>[
                                                                                cubit.isLoading?Padding(
                                                                                  padding: EdgeInsets.symmetric(vertical: 30.h),
                                                                                  child: Center(child: CircularProgressIndicator(),),
                                                                                ):
                                                                                CustomElevatedButton(
                                                                                    onTap: (){
                                                                                      // Navigator.pop(context);
                                                                                      CheckCarModel checkCarModel =CheckCarModel(
                                                                                        packageId:packageId ,
                                                                                        brandId: cubit.brandSelectedId,
                                                                                        modelId: cubit.brandModelSelectedId,
                                                                                        colorId: cubit.colorController.text,
                                                                                        year:cubit.yearSelectedValue.text,
                                                                                        chassis_no:cubit.chassisController.text ,
                                                                                        description:cubit.descriptionController.text ,
                                                                                      );
                                                                                      BookPackageCubit.get(context).sendCheckCar(checkCarModel, context).then((value) {});
                                                                                    },
                                                                                    buttonText: getLang(context, 'ok'))
                                                                              ],
                                                                            );
                                                                      },
                                                                    )
                                                    ],
                                                  );
                                                }),

                                              ],
                                            )
                                            ,
                                          ),

                                        );
                                      },

                                    );

                                    }
                                  else{
                                    showToast(text: getLang(context, 'complete_data'), state: ToastStates.error, context: context);
                                  }
                                }else{
                                  visitorDialog(context);
                                  // showToast(text: getLang(context, 'Log_in_first'),state: ToastStates.error, context: context);
                                }




                              }, buttonText:  getLang(context, 'sure')),
                            ):SizedBox.shrink():SizedBox.shrink(),
                            SizedBox(height: 40.h,),

                          ],
                        );
                      },
                      listener: (BuildContext context ,BookPackageState state){},
                    )
                  )
              );
          },
        ),
    );
  }
}
