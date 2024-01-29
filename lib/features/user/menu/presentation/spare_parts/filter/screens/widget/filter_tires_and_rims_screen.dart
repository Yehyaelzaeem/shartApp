import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/features/provider/work_and_products/data/model/size_model.dart';
import 'package:shart/features/provider/work_and_products/logic/work_products_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../../../../widgets/custom_button.dart';
import '../../../../../../../provider/work_and_products/presentation/widgets/custom_dropdown_widget.dart';
import '../../../../../../book_package_service/data/model/brands.dart';
import '../../../../../../book_package_service/logic/book_package_cubit.dart';
import '../../../../../logic/menu_cubit.dart';


class FilterTireAndRimsScreen extends StatelessWidget {
  const FilterTireAndRimsScreen({Key? key, required this.type}) : super(key: key);
  final String type;
   @override
  Widget build(BuildContext context) {
     MenuCubit cubit = MenuCubit.get(context);
     WorkProductsCubit workProductsCubit =WorkProductsCubit.get(context);
     BookPackageCubit cubit2 = BookPackageCubit.get(context);
     cubit.reSite();

     return  Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 25.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('العرض',
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return CustomDropdownWidget(
                  text: '${cubit.width}',
                  items: workProductsCubit.listWidth!.data!.map(( SizeModelData e) {
                    return DropdownMenuItem<String>(
                      value: e.name,
                      child: Text(
                        e.name.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      cubit.width = val!;
                      for (int i =0; i<=workProductsCubit.listWidth!.data!.length;i++) {
                        if ( cubit.width == workProductsCubit.listWidth!.data![i].name) {
                          cubit.widthId = workProductsCubit.listWidth!.data![i].id.toString();
                          break;
                        }
                      }
                    });
                  },
                  iconStyleData:
                  IconStyleData(iconEnabledColor: primaryColor),
                  buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          color: Color(0xffF9F7EE),
                          borderRadius: BorderRadius.circular(8.r))),
                );
              }),
              // DropdownButton2<String>(
              //   isExpanded: true,
              //   underline: const SizedBox.shrink(),
              //   hint: Text('',
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: Theme.of(context).hintColor,
              //     ),
              //   ),
              //   items: <String>['test', 'test', 'test']
              //       .map((String item) => DropdownMenuItem<String>(
              //     value: item,
              //     child: Text(
              //       item,
              //       style: const TextStyle(fontSize: 14),
              //     ),
              //   )).toList(),
              //   onChanged: (String? value) {
              //     setState(() {
              //       // selectedValue = value;
              //     });
              //   },
              //   iconStyleData: IconStyleData(iconEnabledColor: primaryColor),
              //   buttonStyleData: ButtonStyleData(
              //       decoration: BoxDecoration(
              //           color: Color(0xffF9F7EE),
              //           borderRadius: BorderRadius.circular(8.r))),
              // ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('الإرتفاع',
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              // DropdownButton2<String>(
              //   isExpanded: true,
              //   underline: const SizedBox.shrink(),
              //   hint: Text(
              //     'إختر',
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: Theme.of(context).hintColor,
              //     ),
              //   ),
              //   items: <String>['test', 'test', 'test']
              //       .map((String item) => DropdownMenuItem<String>(
              //     value: item,
              //     child: Text(
              //       item,
              //       style: const TextStyle(fontSize: 14),
              //     ),
              //   ))
              //       .toList(),
              //   onChanged: (String? value) {
              //     setState(() {
              //       // selectedValue = value;
              //     });
              //   },
              //   iconStyleData: IconStyleData(iconEnabledColor: primaryColor),
              //   buttonStyleData: ButtonStyleData(
              //
              //       decoration: BoxDecoration(
              //           color: Color(0xffF9F7EE),
              //
              //           borderRadius: BorderRadius.circular(8.r))),
              // ),
              StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return CustomDropdownWidget(
                  text: '${cubit.height}',
                  items: workProductsCubit.listHeight!.data!.map(( SizeModelData e) {
                    return DropdownMenuItem<String>(
                      value: e.name,
                      child: Text(
                        e.name.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      cubit.height = val!;
                      for (int i =0; i<=workProductsCubit.listHeight!.data!.length;i++) {
                        if ( cubit.height == workProductsCubit.listHeight!.data![i].name) {
                          cubit.heightId = workProductsCubit.listHeight!.data![i].id.toString();
                          break;
                        }
                      }

                    });
                  },
                  iconStyleData:
                  IconStyleData(iconEnabledColor: primaryColor),
                  buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          color: Color(0xffF9F7EE),
                          borderRadius: BorderRadius.circular(8.r))),
                );
              }),

            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 25.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('مقاس الجنط',
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return CustomDropdownWidget(
                  text: '${cubit.size}',
                  items: workProductsCubit.listSize!.data!.map((SizeModelData e) {
                    return DropdownMenuItem<String>(
                      value: e.name,
                      child: Text(
                        e.name.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      cubit.size = val!;
                      for (int i =0; i<=workProductsCubit.listSize!.data!.length;i++) {
                        if ( cubit.size == workProductsCubit.listSize!.data![i].name) {
                          cubit.sizeId = workProductsCubit.listSize!.data![i].id.toString();
                          break;
                        }
                      }
                    });
                  },
                  iconStyleData:
                  IconStyleData(iconEnabledColor: primaryColor),
                  buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          color: Color(0xffF9F7EE),
                          borderRadius: BorderRadius.circular(8.r))),
                );
              }),

            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 0.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('الماركة',
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              // DropdownButton2<String>(
              //   isExpanded: true,
              //   underline: const SizedBox.shrink(),
              //   hint: Text(
              //     'إختر',
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: Theme.of(context).hintColor,
              //     ),
              //   ),
              //   items: <String>['test', 'test', 'test']
              //       .map((String item) => DropdownMenuItem<String>(
              //     value: item,
              //     child: Text(
              //       item,
              //       style: const TextStyle(fontSize: 14),
              //     ),
              //   ))
              //       .toList(),
              //   onChanged: (String? value) {
              //     setState(() {
              //       // selectedValue = value;
              //     });
              //   },
              //   iconStyleData: IconStyleData(iconEnabledColor: primaryColor),
              //   buttonStyleData: ButtonStyleData(
              //
              //       decoration: BoxDecoration(
              //           color: Color(0xffF9F7EE),
              //
              //           borderRadius: BorderRadius.circular(8.r))),
              // ),
              StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return CustomDropdownWidget(
                  text: '${cubit.brandSelectedValue}',
                  items: cubit2.brands.map((BrandsData? e) {
                    return DropdownMenuItem<String>(
                      value: e!.name,
                      child: Text(
                        e.name!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      cubit.brandSelectedValue = val!;
                      for (BrandsData? a in cubit2.brands) {
                        if (cubit.brandSelectedValue ==
                            a!.name) {
                          cubit.brandSelectedId =
                              a.id!.toString();
                          break;
                        }
                      }
                    });
                  },
                  iconStyleData:
                  IconStyleData(iconEnabledColor: primaryColor),
                  buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          color: Color(0xffF9F7EE),
                          borderRadius: BorderRadius.circular(8.r))),
                );
              }),

            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 25.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('الحالة',
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              // DropdownButton2<String>(
              //   isExpanded: true,
              //   underline: const SizedBox.shrink(),
              //   hint: Text(
              //     'إختر',
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: Theme.of(context).hintColor,
              //     ),
              //   ),
              //   items: <String>['test',  'test']
              //       .map((String item) => DropdownMenuItem<String>(
              //     value: item,
              //     child: Text(
              //       item,
              //       style: const TextStyle(fontSize: 14),
              //     ),
              //   ))
              //       .toList(),
              //   onChanged: (String? value) {
              //     setState(() {
              //       // selectedValue = value;
              //     });
              //   },
              //   iconStyleData: IconStyleData(iconEnabledColor: primaryColor),
              //   buttonStyleData: ButtonStyleData(
              //
              //       decoration: BoxDecoration(
              //           color: Color(0xffF9F7EE),
              //
              //           borderRadius: BorderRadius.circular(8.r))),
              // ),
              StatefulBuilder(builder: (context,setState){
                return  DropdownButton2<String>(
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  hint: Text(
                    cubit.statusSelectedValue,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: <String>['new', 'used']
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
                      cubit.statusSelectedValue = value!;
                    });
                  },
                  iconStyleData:
                  IconStyleData(iconEnabledColor: primaryColor),
                  buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          color: Color(0xffF9F7EE),
                          borderRadius: BorderRadius.circular(8.r))),
                );

              })

            ],
          ),
        ),
         BlocConsumer<MenuCubit, MenuState>(
         listener: (BuildContext context, MenuState state) {},
         builder: (BuildContext context, MenuState state){
           return    MenuCubit.get(context).isLoading?Container(child: CircularProgressIndicator(),):
           Padding(
             padding: EdgeInsets.symmetric(vertical: 30.h),
             child: CustomElevatedButton(onTap: () {
               cubit.searchProductsRimsAndTires(
                   type: type,
                   heightId: cubit.heightId,
                   widthId: cubit.widthId,
                   brandId: cubit.brandSelectedId,
                   sizeId: cubit.sizeId,
                   productStatus: cubit.statusSelectedValue,
                   name: cubit.productNameSelectedValue,
                   context: context);
             }, buttonText: 'بحث'),
           );
         })
          ],
        );
  }
}
