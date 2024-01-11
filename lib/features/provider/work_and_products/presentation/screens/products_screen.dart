import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../../../core/routing/routes.dart';
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
          var data = cubit.getProductsModel!.data!;
          return Column(
            children: <Widget>[
              CustomTextField(
                  hintText: '${getLang(context, 'my_products1')}',
                  controller: WorkProductsCubit.get(context).searchController,
                  prefixIcon:
                      Icon(Icons.search_sharp, color: Colors.grey.shade400),
                  borderColor: Colors.grey.shade300),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    NavigationManager.push(Routes.providerAddNewProduct);
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
              cubit.isLoadingDelete?LinearProgressIndicator():SizedBox.shrink(),
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
