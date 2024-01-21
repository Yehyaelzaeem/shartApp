import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../user/book_package_service/data/model/brand_model.dart';
import '../../../../user/book_package_service/data/model/brands.dart';
import '../../../../user/book_package_service/logic/book_package_cubit.dart';
import '../../data/model/get_products_list_model.dart';
import '../../logic/work_products_cubit.dart';

class ProviderEditProductScreen extends StatefulWidget {
  final GetProductsModelData getProductsModelData;
  const ProviderEditProductScreen({Key? key, required this.getProductsModelData}) : super(key: key);

  @override
  State<ProviderEditProductScreen> createState() => _ProviderAddNewProductState();
}

class _ProviderAddNewProductState extends State<ProviderEditProductScreen> {

  @override
  void initState() {
    WorkProductsCubit controllerCubit =WorkProductsCubit.get(context);
    if(widget.getProductsModelData.type=='spare_parts'){
      controllerCubit.changeTypeAdd(false);
      controllerCubit.typeSelectedValue=widget.getProductsModelData.type!??'';
      controllerCubit.productNameSelectedValue=widget.getProductsModelData.title!??'';
      controllerCubit.brandSelectedId=widget.getProductsModelData.brand!.id!.toString()??'';
      controllerCubit.brandSelectedValue=widget.getProductsModelData.brand!.name!??'';
      // controllerCubit.brandModelSelectedValue=widget.getProductsModelData.modal!??'';
      controllerCubit.brandModelSelectedId=widget.getProductsModelData.modalId!.toString()??'';
      controllerCubit.stateSelectedValue=widget.getProductsModelData.productStatus!??'';
      controllerCubit.priceController.text=widget.getProductsModelData.price!.toString()??'';
      controllerCubit.desController.text=widget.getProductsModelData.description!.toString()??'';

    }else{
      controllerCubit.changeTypeAdd(true);
      controllerCubit.typeSelectedValue=widget.getProductsModelData.type!??'';
      controllerCubit.productNameSelectedValue=widget.getProductsModelData.title!??'';
      controllerCubit.stateSelectedValue=widget.getProductsModelData.productStatus!??'';
      controllerCubit.widthSelectedValue=widget.getProductsModelData.width!.toString()??'';
      controllerCubit.heightSelectedValue=widget.getProductsModelData.height!.toString()??'';
      controllerCubit.sizeSelectedValue=widget.getProductsModelData.size!.toString()??'';
      // controllerCubit.brandModelSelectedId=widget.getProductsModelData.modalId!.toString()??'';
      // controllerCubit.brandSelectedId=widget.getProductsModelData.brandId!.toString()??'';
      controllerCubit.priceController.text=widget.getProductsModelData.price!.toString()??'';
      controllerCubit.desController.text=widget.getProductsModelData.description!.toString()??'';

    }

    super.initState();
  }
  bool x=false;
  // final MultiImagePickerController controller = MultiImagePickerController(
  //     maxImages: 300,
  //     picker: (bool allowMultiple) async {
  //       return await pickImagesUsingImagePicker(allowMultiple);
  //     });
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    WorkProductsCubit controllerCubit =WorkProductsCubit.get(context);
    BookPackageCubit cubit =BookPackageCubit.get(context);

    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: '${getLang(context, 'edit_product')}', hasBackButton: true),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body:
      BlocConsumer<WorkProductsCubit ,WorkProductsState>(
        listener: (BuildContext context, WorkProductsState state) {},
        builder: (BuildContext context, WorkProductsState state) {
          return SingleChildScrollView(
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
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        hint: Text(
                          '${controllerCubit.typeSelectedValue}',
                          style: TextStyle( fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: <String>['${getLang(context, 'my_products_types1')}', '${getLang(context, 'my_products_types2')}', '${getLang(context, 'my_products_types3')}']
                            .map((String item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            controllerCubit.typeSelectedValue = value!;
                            if(controllerCubit.typeSelectedValue == 'قطع غيار' ||controllerCubit.typeSelectedValue == 'spare parts'){
                              controllerCubit.isParts=false;
                            }else{
                              controllerCubit.isParts=true;
                            }

                          });
                        },
                        buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(8.r))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        hint: Text(
                          '${controllerCubit.productNameSelectedValue}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: <String>['name product ', 'name2 product', 'name3 product']
                            .map((String item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            controllerCubit.productNameSelectedValue = value!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(

                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(8.r))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        hint: Text(
                          '${controllerCubit.brandSelectedValue}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: cubit.brands.map((BrandsData? e) {
                          return DropdownMenuItem<String>(
                            value: e!.name,
                            child: Text(
                              e.name!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            controllerCubit.brandSelectedValue = value!;
                            for(var a in cubit.brands ){
                              if(controllerCubit.brandSelectedValue==a!.name){
                                controllerCubit.brandSelectedId=a.id!.toString();
                                break;
                              }
                            }
                            // brandSelectedValue = e;
                          });
                        },
                        buttonStyleData: ButtonStyleData(

                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(8.r))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: DropdownButton2<String>(

                        isExpanded: true,

                        underline: const SizedBox.shrink(),
                        hint: Text(
                          '${controllerCubit.brandModelSelectedValue}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items:
                        cubit.brandModelList.map((BrandModelData? e){
                          return DropdownMenuItem<String>(
                            value: e!.name,
                            child: Text(
                              e.name!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            controllerCubit.brandModelSelectedValue = value!;
                            for(var a in cubit.brandModelList ){
                              if(controllerCubit.brandModelSelectedValue==a!.name){
                                controllerCubit.brandModelSelectedId=a.id!.toString();
                                break;
                              }
                            }                          });
                        },
                        buttonStyleData: ButtonStyleData(

                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(8.r))),
                      ),
                    ),
                    controllerCubit.isParts==true?
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 25.h),
                          child: DropdownButton2<String>(

                            isExpanded: true,

                            underline: const SizedBox.shrink(),
                            hint: Text(
                              '${controllerCubit.widthSelectedValue}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),
                            items: <String>['16', '20', '27','65','75','88','5','11']
                                .map((String item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ))
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                controllerCubit.widthSelectedValue = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(

                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(8.r))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25.h),
                          child: DropdownButton2<String>(

                            isExpanded: true,

                            underline: const SizedBox.shrink(),
                            hint: Text(
                              '${controllerCubit.heightSelectedValue}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),
                            items: <String>['16', '20', '27','75','88','5','11']
                                .map((String item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ))
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                controllerCubit.heightSelectedValue = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(

                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(8.r))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25.h),
                          child: DropdownButton2<String>(

                            isExpanded: true,

                            underline: const SizedBox.shrink(),
                            hint: Text(
                              '${controllerCubit.sizeSelectedValue}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),
                            items: <String>['R14 655/165', 'G15 714/85', 'R7 217/180','L15 257/89','P16 852/49','K95 1002/520',]
                                .map((String item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ))
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                controllerCubit.sizeSelectedValue = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(

                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(8.r))),
                          ),
                        ),
                      ],
                    ):
                    SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        hint: Text(
                          '${controllerCubit.stateSelectedValue}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: <String>['${getLang(context, 'new')}', '${getLang(context, 'used')}']
                            .map((String item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            controllerCubit.stateSelectedValue = value!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(

                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(8.r))),
                      ),
                    ),
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
                    x==true?InkWell(
                        onTap: (){
                          setState(() {
                            x=false;
                          });
                        },
                        child: Icon(Icons.highlight_remove_sharp,color: Colors.black26,)):SizedBox.shrink(),

                    Text(
                      '${getLang(context, 'rim_image')}',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Lateef',
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.getProductsModelData.images!.length,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin:
                              EdgeInsets.symmetric(horizontal: index != 0 ? 4 : 0),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Image.network('${widget.getProductsModelData.images![index].image}'),
                            );
                          }),
                    ),
                    SizedBox(height: 10,),
                    x==false? InkWell(
                      onTap: ()async{
                        setState(() {
                          x=true;
                        });
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

                    SizedBox(height: 20.h,),
                    controllerCubit.isLoading?
                    Center(child: CircularProgressIndicator(),):Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: CustomElevatedButton(
                          onTap: () {
                            WorkProductsCubit.get(context).editProduct(widget.getProductsModelData.id.toString(), context);
                          }, buttonText:  '${getLang(context, 'my_business_save')}'),
                    ),
                    SizedBox(height: 30.h,),

                  ],
                ),
              ));
        },
      ),
    );
  }
}
