import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../../user/book_package_service/data/model/brand_model.dart';
import '../../../../user/book_package_service/data/model/brands.dart';
import '../../../../user/book_package_service/logic/book_package_cubit.dart';
import '../../logic/work_products_cubit.dart';
import '../widgets/custom_dropdown_widget.dart';

class ProviderAddNewProduct extends StatelessWidget {
  const ProviderAddNewProduct({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WorkProductsCubit controllerCubit =WorkProductsCubit.get(context);
    controllerCubit.displayTitle(context);
    BookPackageCubit cubit =BookPackageCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: '${getLang(context, 'my_products_adding')}', hasBackButton: true),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body:
      BlocConsumer<WorkProductsCubit ,WorkProductsState>(
        listener: (BuildContext context, WorkProductsState state) {},
        builder: (BuildContext context, WorkProductsState state) {
          return
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                margin: EdgeInsets.only(top: 24.h),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffD0D5DD)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Text(
                        '${getLang(context, 'my_products3')}',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lateef'),
                      ),
                    ),
                    StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                      return  CustomDropdownWidget(text: '${controllerCubit.typeSelectedValue}',
                        items: <String>['${getLang(context, 'my_products_types1')}', '${getLang(context, 'my_products_types2')}', '${getLang(context, 'my_products_types3')}'].map((String item) =>
                          DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 14),
                            ),
                          )).toList(),
                        onChanged: (String? val){
                          setState((){
                            controllerCubit.typeSelectedValue = val!;
                            if(controllerCubit.typeSelectedValue == 'قطع غيار' ||controllerCubit.typeSelectedValue == 'spare parts'){
                              controllerCubit.changeTypeAdd(false);
                            }else{
                              controllerCubit.changeTypeAdd(true);
                            }
                          });
                        },);
                    }),
                    StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                      return  CustomDropdownWidget(
                        text: '${controllerCubit.productNameSelectedValue}',
                        items: <String>['name product ', 'name2 product', 'name3 product'].map((String item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 14),
                              ),
                            )).toList(),
                        onChanged: (String? val){
                          setState((){
                            controllerCubit.productNameSelectedValue = val!;
                          });
                        },);
                    }),
                    StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                      return  CustomDropdownWidget(
                        text: '${controllerCubit.brandSelectedValue}',
                        items:  cubit.brands.map((BrandsData? e) {
                          return DropdownMenuItem<String>(
                            value: e!.name,
                            child: Text(
                              e.name!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? val){
                          setState((){
                            controllerCubit.brandSelectedValue = val!;
                            for(var a in cubit.brands ){
                              if(controllerCubit.brandSelectedValue==a!.name){
                                controllerCubit.brandSelectedId=a.id!.toString();
                                break;
                              }
                            }
                          });

                        },);
                    }),
                    StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                      return  CustomDropdownWidget(
                        text: '${controllerCubit.brandModelSelectedValue}',
                        items: cubit.brandModelList.map((BrandModelData? e){
                          return DropdownMenuItem<String>(
                            value: e!.name,
                            child: Text(
                              e.name!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? val){
                          setState((){
                            controllerCubit.brandModelSelectedValue = val!;
                            for(var a in cubit.brandModelList ){
                              if(controllerCubit.brandModelSelectedValue==a!.name){
                                controllerCubit.brandModelSelectedId=a.id!.toString();
                                break;
                              }
                            }
                          });
                        },);
                    }),
                    controllerCubit.isParts==true? Column(
                      children: <Widget>[
                        StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                          return  CustomDropdownWidget(text: '${controllerCubit.widthSelectedValue}',
                            items: <String>['5', '6', '8','15','20','34','10'].map((String item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                )).toList(),
                            onChanged: (String? val){
                              setState((){
                                controllerCubit.widthSelectedValue = val!;

                              });
                            },);
                        }),
                        StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                          return  CustomDropdownWidget(text: '${controllerCubit.heightSelectedValue}',
                            items:<String>['16', '20', '27','65','75','88','5','11'].map((String item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                )).toList(),
                            onChanged: (String? val){
                              setState((){
                                controllerCubit.heightSelectedValue = val!;

                              });
                            },);
                        }),
                        StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                          return  CustomDropdownWidget(text: '${controllerCubit.sizeSelectedValue}',
                            items: <String>['R14 655/165', 'G15 714/85', 'R7 217/180','L15 257/89','P16 852/49','K95 1002/520',].map((String item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                )).toList(),
                            onChanged: (String? val){
                              setState((){
                                controllerCubit.sizeSelectedValue = val!;

                              });
                            },);
                        }),
                      ],
                    ):SizedBox.shrink(),
                    StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                      return  CustomDropdownWidget(text: '${controllerCubit.stateSelectedValue}',
                        items:<String> ['${getLang(context, 'new')}', '${getLang(context, 'used')}'].map((String item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 14),
                              ),
                            )).toList(),
                        onChanged: (String? val){
                          setState((){
                            controllerCubit.stateSelectedValue = val!;

                          });
                        },);
                    }),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 25.h),
                        child: CustomTextField(
                            maxLines: 4,
                            hintText: '${getLang(context, 'des')}',
                            controller: controllerCubit.desController,
                            hintColor: Colors.black)),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 25.h),
                      child: CustomTextField(
                          textInputType: TextInputType.number,
                          hintText: controllerCubit.isParts==false?
                          '${getLang(context, 'unit_price')}':'${getLang(context, 'rim_price')}',
                          controller: controllerCubit.priceController,
                          hintColor: Colors.black),
                    ),
                    controllerCubit.x==true?InkWell(
                        onTap: (){
                          controllerCubit.changeType2Add(false);
                        },
                        child: Icon(Icons.highlight_remove_sharp,color: Colors.black26,)):SizedBox.shrink(),
                    controllerCubit.x==false? InkWell(
                      onTap: ()async{
                        controllerCubit.changeType2Add(true);
                      },
                      child: CustomTextField(
                          enabled: false,
                          prefixIcon: Icon(Icons.camera_alt_outlined),
                          hintText: controllerCubit.isParts==false?
                          '${getLang(context, 'unit_image')}':'${getLang(context, 'rim_image')}',
                          controller: TextEditingController(),
                          hintColor: Colors.black),
                    ):Container(
                      height: MediaQuery.of(context).size.height*0.25,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: MultiImagePickerView(
                        controller: controllerCubit.multiImagePickerController,
                        padding: const EdgeInsets.all(10),
                      ),
                    ),
                controllerCubit.isLoading?Center(child: CircularProgressIndicator(),): Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: CustomElevatedButton(
                          onTap: () {
                            if(
                            controllerCubit.typeSelectedValue != '${getLang(context, 'type')}'&&
                            controllerCubit.productNameSelectedValue != '${getLang(context, 'product_name')}'&&
                            controllerCubit.brandSelectedValue != '${getLang(context, 'brand')}'&&
                            controllerCubit.brandModelSelectedValue != '${getLang(context, 'model')}'&&
                            controllerCubit.stateSelectedValue != '${getLang(context, 'status')}'&&
                            controllerCubit.multiImagePickerController.images.isNotEmpty
                            ){
                              print('dfs : ${controllerCubit.typeSelectedValue}');
                              if(controllerCubit.typeSelectedValue != 'قطع غيار' && controllerCubit.typeSelectedValue != 'spare parts'){
                                if( controllerCubit.widthSelectedValue != '${getLang(context, 'width')}'&&
                                    controllerCubit.heightSelectedValue != '${getLang(context, 'height')}'&&
                                    controllerCubit.sizeSelectedValue != '${getLang(context, 'size')}')
                                {
                                  controllerCubit.addProduct(context);
                                }
                                else{
                                  showToast(text: 'check your complete data',
                                      state: ToastStates.error,
                                      context: context);
                                }
                            }
                              else{
                                controllerCubit.addProduct(context);
                              }
                            }
                            else{
                              showToast(text: 'check your complete data',
                                  state: ToastStates.error,
                                  context: context);
                            }
                            // print('path / ${controllerCubit.image!.path}');
                          }, buttonText: '${getLang(context, 'my_business_save')}'),
                    ),
                    SizedBox(height: 30.h,)
                  ],
                ),
              ));
        },
      ),
    );
  }
}
