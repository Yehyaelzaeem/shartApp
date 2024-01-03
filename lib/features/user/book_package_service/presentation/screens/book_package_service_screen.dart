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

import '../widgets/cutom_text_booking_widget.dart';

class UserBookPackageServiceScreen extends StatefulWidget {
  const UserBookPackageServiceScreen({Key? key}) : super(key: key);

  @override
  State<UserBookPackageServiceScreen> createState() =>
      _UserBookPackageServiceScreenState();
}

class _UserBookPackageServiceScreenState
    extends State<UserBookPackageServiceScreen> {
  var brandSelectedValue ='';
  var brandModelSelectedValue ='';
  var brandColorSelectedValue ='';
  @override
  Widget build(BuildContext context) {
    BookPackageCubit cubit =BookPackageCubit.get(context);
    cubit.getBrands(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80.h),
          child: CustomAppBar(title: getLang(context, 'booking_details'), hasBackButton: true)),
      body: SingleChildScrollView(
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
                    CustomTextTitleBookingWidget(text:'${getLang(context, 'car_model')} *',topPadding: 25,),
                    DropdownButton2<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: Text('${brandModelSelectedValue}', style: TextStyle(fontSize: 14, color: Colors.black),),
                      items: cubit.brandModelList.map((BrandModelData? e) =>
                          DropdownMenuItem<String>(
                            value: e!.name,
                            child: Text(
                              e.name!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          )).toList(),

                      // <String>['test', 'test', 'test'].map((String item) =>
                      //     DropdownMenuItem<String>(
                      //   value: item,
                      //   child: Text(
                      //     item,
                      //     style: const TextStyle(fontSize: 14),
                      //   ),
                      // )).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          brandModelSelectedValue = value!;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(8.r))),
                    ),
                    CustomTextTitleBookingWidget(text:'${getLang(context, 'brand')} *',topPadding: 25,),
                    DropdownButton2<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: Text('${brandSelectedValue}', style: TextStyle(fontSize: 14, color: Colors.black),),
                      items: cubit.brands.map((BrandsData? e) =>
                      DropdownMenuItem<String>(
                        value: e!.name,
                        child: Text(
                           e.name!,
                          style: const TextStyle(fontSize: 14),
                        ),
                      )).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          brandSelectedValue = value!;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(8.r))),
                    ),
                    CustomTextTitleBookingWidget(text: '${getLang(context, 'manufacturing_year')} *',topPadding: 25,),
                    DropdownButton2<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: Text(
                        '',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      items: <String>['test', 'test', 'test']
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          // selectedValue = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(8.r))),
                    ),
                    CustomTextTitleBookingWidget(text: '${getLang(context, 'color')} *',topPadding: 25,),
                    DropdownButton2<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: Text('${brandColorSelectedValue}', style: TextStyle(fontSize: 14, color: Colors.black),),
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
                          brandColorSelectedValue = value!;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(8.r))),
                    ),
                    CustomTextTitleBookingWidget(text: '${getLang(context, 'chassis_chassis_number')} *',topPadding: 25,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.h),
                      child: CustomTextField(
                          hintText: '',
                          hintColor: Colors.black,
                          controller: TextEditingController()),
                    ),
                    CustomTextTitleBookingWidget(text: getLang(context, 'comment',), topPadding: 5,),
                    CustomTextField(
                        maxLines: 3,
                        hintText: '',
                        controller: TextEditingController(),
                        hintColor: Colors.black),
                    SizedBox(height: 50.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: CustomElevatedButton(onTap: () {}, buttonText:  getLang(context, 'sure')),
                    ),
                    SizedBox(height: 40.h,),

                  ],
                );
              },
              listener: (BuildContext context ,BookPackageState state){},
            )
          )
      ),
    );
  }
}
