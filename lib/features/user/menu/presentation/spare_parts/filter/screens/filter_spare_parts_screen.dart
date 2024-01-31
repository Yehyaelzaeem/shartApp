import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/features/user/menu/logic/menu_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../../../widgets/custom_button.dart';
import '../../../../../../provider/work_and_products/presentation/widgets/custom_dropdown_widget.dart';
import '../../../../../book_package_service/data/model/brand_model.dart';
import '../../../../../book_package_service/data/model/brands.dart';
import '../../../../../book_package_service/logic/book_package_cubit.dart';
import '../../../../data/model/product_model.dart';
import 'widget/filter_tires_and_rims_screen.dart';

class SparePartsFilterScreen extends StatelessWidget {
  const SparePartsFilterScreen({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  Widget build(BuildContext context) {
    BookPackageCubit cubit = BookPackageCubit.get(context);
    MenuCubit cubitController = MenuCubit.get(context);
    cubitController.reSite();
      return WillPopScope(
      onWillPop: () {
        cubitController.changeLoadingSearch(false);
        cubitController.searchController.text='';
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80.h),
          child: CustomAppBar(title: getLang(context, 'select_search'),hasBackButton: true,
          onTap: (){
            cubitController.searchController.text='';
            cubitController.changeLoadingSearch(false);
            Navigator.of(context).pop();
          },),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child:
            type!='spare_parts'?
            FilterTireAndRimsScreen(type: type,):
            Column(
              children: <Widget>[
                SizedBox(height: 20.h,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(getLang(context, 'car_brand'),
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      StatefulBuilder(builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return CustomDropdownWidget(
                          text: '${cubitController.brandSelectedValue}',
                          items: cubit.brands.map((BrandsData? e) {
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
                              cubitController.brandSelectedValue = val!;
                              for (BrandsData? a in cubit.brands) {
                                if (cubitController.brandSelectedValue ==
                                    a!.name) {
                                  cubitController.brandSelectedId =
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
                SizedBox(height: 20.h,),

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
                      Text(getLang(context, 'car_model'),
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      StatefulBuilder(builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return CustomDropdownWidget(
                          text: '${cubitController.brandModelSelectedValue}',
                          items: cubit.brandModelList.map((BrandModelData? e) {
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
                              cubitController.brandModelSelectedValue = val!;
                              for (BrandModelData? a in cubit.brandModelList) {
                                if (cubitController.brandModelSelectedValue ==
                                    a!.name) {
                                  cubitController.brandModelSelectedId =
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
                SizedBox(height: 25.h,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5).withOpacity(0.5))),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(getLang(context, 'car_status'),
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16.h),
                      StatefulBuilder(builder: (context,setState){
                        return  DropdownButton2<String>(
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          hint: Text(
                            cubitController.statusSelectedValue,
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
                              cubitController.statusSelectedValue = value!;
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
                      Text(getLang(context, 'provider'),
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      StatefulBuilder(builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return CustomDropdownWidget(
                          text: '${cubitController.providerSelectedValue}',
                          items: cubitController.providerList.map((ProductModelProvider? e) {
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
                              cubitController.providerSelectedValue = val!;
                              for (ProductModelProvider? a in cubitController.providerList) {
                                if (cubitController.providerSelectedValue == a!.name) {
                                  cubitController.providerId = a.id!.toString();
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

                BlocConsumer<MenuCubit, MenuState>(
                  listener: (BuildContext context, MenuState state) {},
                  builder: (BuildContext context, MenuState state) {
                    return
                      cubitController.isLoading?Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: Center(child: CircularProgressIndicator(),),
                      ):Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: CustomElevatedButton(
                          onTap: () {
                             cubitController.searchProducts(
                                    type: 'spare_parts',
                                    providerId: cubitController.providerId,
                                    brandId: cubitController.brandSelectedId,
                                    modelId: cubitController.brandModelSelectedId,
                                    productStatus: cubitController.statusSelectedValue,
                                    name: cubitController.productNameSelectedValue,
                                    context: context);
                          },
                          buttonText: getLang(context, 'search')),
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
