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

import '../../../auth/logic/auth_cubit.dart';
import '../../data/model/check_car_model.dart';
import '../widgets/cutom_text_booking_widget.dart';

class UserBookPackageServiceScreen extends StatelessWidget {
  final String packageId;
  const UserBookPackageServiceScreen({Key? key, required this.packageId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    BookPackageCubit cubit =BookPackageCubit.get(context);
    cubit.getBrands( context: context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80.h),
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

                            CustomTextTitleBookingWidget(text: '${getLang(context, 'color')} *',topPadding: 25,),
                            StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                              return DropdownButton2<String>(
                                isExpanded: true,
                                underline: const SizedBox.shrink(),
                                hint: Text('${cubit.colorSelectedValue}', style: TextStyle(fontSize: 14, color: Colors.black),),
                                items: cubit.brandColorsList.map((BrandColorsData? e) =>
                                    DropdownMenuItem<String>(
                                      value: e!.name,
                                      child: Text(
                                        e.name!,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    )).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    cubit.colorSelectedValue = value!;
                                    for(BrandColorsData? a in cubit.brandColorsList ){
                                      if(cubit.colorSelectedValue==a!.name){
                                        cubit.brandId=a.id!;
                                        cubit.colorSelectedId =a.id!.toString();
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
                                textInputType: TextInputType.number,
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
                           cubit.isLoading?Padding(
                             padding: EdgeInsets.symmetric(vertical: 30.h),
                             child: Center(child: CircularProgressIndicator(),),
                           ):
                           Padding(
                              padding: EdgeInsets.symmetric(vertical: 30.h),
                              child: CustomElevatedButton(onTap: () {
                                if(AuthCubit.get(context).token.isNotEmpty){

                                  if(packageId.isNotEmpty&&cubit.brandSelectedId.isNotEmpty &&
                                      cubit.brandModelSelectedId.isNotEmpty && cubit.colorSelectedId.isNotEmpty&&
                                      cubit.yearSelectedValue.text.isNotEmpty&&cubit.chassisController.text.isNotEmpty&&
                                      cubit. descriptionController.text.isNotEmpty)
                                  {
                                    CheckCarModel checkCarModel =CheckCarModel(
                                      packageId:packageId ,
                                      brandId: cubit.brandSelectedId,
                                      modelId: cubit.brandModelSelectedId,
                                      colorId: cubit.colorSelectedId,
                                      year:cubit.yearSelectedValue.text,
                                      chassis_no:cubit.chassisController.text ,
                                      description:cubit.descriptionController.text ,
                                    );
                                    BookPackageCubit.get(context).sendCheckCar(checkCarModel, context);
                                  }else{
                                    showToast(text: 'complete data', state: ToastStates.error, context: context);
                                  }
                                }else{
                                  showToast(text: getLang(context, 'Log_in_first'),state: ToastStates.error, context: context);
                                }




                              }, buttonText:  getLang(context, 'sure')),
                            ),
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
