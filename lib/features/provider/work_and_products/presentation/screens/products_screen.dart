import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/provider/work_and_products/data/model/get_products_list_model.dart';
import 'package:shart/widgets/custom_text_field.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/routing/routes.dart';
import '../../../profile/logic/provider_profile_cubit.dart';
import '../../logic/work_products_cubit.dart';
import '../widgets/custom_product_widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkProductsCubit cubit =WorkProductsCubit.get(context);
    return BlocConsumer<WorkProductsCubit, WorkProductsState>(
      listener: (BuildContext context, WorkProductsState state) {},
      builder: (BuildContext context, WorkProductsState state) {
        if (cubit.getProductsModel !=null) {
          List<GetProductsModelData> data = cubit.getProductsModel!.data!;
          return Padding(
            padding: const EdgeInsets.only(bottom: 45.0),
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    CustomTextField(
                        hintText: '${getLang(context, 'my_products1')}',
                        controller: cubit.searchController,
                        prefixIcon:
                        Icon(Icons.search_sharp, color: Colors.grey.shade400),
                        onChanged: (String value){
                          if(value.isNotEmpty){
                            cubit.changeSearchStart(true);
                            cubit.getSearchProducts(value, context);
                          }else{
                            cubit.changeSearchStart(false);
                          }
                        },
                        borderColor: Colors.grey.shade300),
                    cubit.isSearchStart==true?
                    Positioned(
                      left: 5,
                      top: 3,
                      bottom: 3,
                      child:
                      Container(
                        width: 30.w,
                        color: Colors.white,
                        child: Center(
                          child: IconButton(
                            onPressed: (){
                              cubit.searchController.text='';
                              cubit.changeSearchStart(false);
                            },
                            icon: Icon(Icons.clear,
                              color: blueColor,
                            ),
                          ),
                        ),
                      ),
                    ):SizedBox.shrink(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      if(ProviderProfileCubit.get(context).providerProfileModel!=null){
                        if(ProviderProfileCubit.get(context).providerProfileModel!.data!.profileCompleted==false){
                          showToast(text:'${getLang(context, 'complete_mes')}', state: ToastStates.error, context: context);
                        }else{
                          NavigationManager.push(Routes.providerAddNewProduct);
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.add, color: Color(0xff136B79)),
                        Text('${getLang(context, 'my_products2')}',
                            style: TextStyle(
                                color: Color(0xff136B79),
                                fontFamily: 'Lateef',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                cubit.isSearchStart==true?
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      cubit.isLoadingDelete?LinearProgressIndicator():SizedBox.shrink(),
                      cubit.getProductsSearchModel!=null?
                      cubit.getProductsSearchModel!.data!.length==0?
                      Padding(
                        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                        child: Center(child: Text(getLang(context, 'no_product_found'),style:
                        TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25.sp,
                          fontFamily: 'Lateef',
                        )
                          ,),),
                      ):
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.h, bottom: 60.h),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 220.h),
                            itemBuilder: (BuildContext context, int index) {
                              return CustomProductsDisplayWidget(
                                getProductsModelData: cubit.getProductsSearchModel!.data![index],
                              );
                            },
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: cubit.getProductsSearchModel!.data!.length,
                          ),
                        ),
                      ):
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Center(child: CircularProgressIndicator(),),
                      ),
                    ],
                  ),
                ):
                Expanded(
                  child: Column(
                    children: <Widget>[
                      cubit.isLoadingDelete?LinearProgressIndicator():SizedBox.shrink(),
                      cubit.getProductsModel!.data!.length==0?
                      Padding(
                        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                        child: Center(child:
                        Text(getLang(context, 'There_products_currently'),style:
                        TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25.sp,
                          fontFamily: 'Lateef',
                        )
                          ,),),
                      ):
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.h, bottom: 60.h),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 220.h),
                            itemBuilder: (BuildContext context, int index) {
                              return CustomProductsDisplayWidget(
                                getProductsModelData: data[index],
                              );
                            },
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: data.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
