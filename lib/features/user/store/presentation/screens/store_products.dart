import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/routing/routes.dart';
import '../../../menu/presentation/spare_parts/widgets/spare_part_item.dart';
class StoreProductsScreen extends StatelessWidget {
  const StoreProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar(title: 'متجر الثواب',hasBackButton: true),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 9.w,
          mainAxisSpacing: 15.h,
          mainAxisExtent: 300.h,
        ),
        itemBuilder: (
            BuildContext context, int index) {
          return InkWell(
            onTap: () {
              NavigationManager.push(Routes.itemDetails);
            },
            child: SparePartItemWidget(
              brandName: 'اسم الماركة',
              productName: 'اسم المنتج',
              price: 300.toString(),
              image: ImagesManager.tire1,
              id: '', providerName: '',
            ),
          );
        },
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: 6,
        padding: EdgeInsets.all(16.w),
      ),
    );
  }
}
