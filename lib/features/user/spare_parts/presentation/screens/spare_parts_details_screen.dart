import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../widgets/spare_part_item.dart';

class SparePartsDetailsScreen extends StatefulWidget {
  const SparePartsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SparePartsDetailsScreen> createState() =>
      _SparePartsDetailsScreenState();
}

class _SparePartsDetailsScreenState extends State<SparePartsDetailsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(title: 'قطع الغيار',hasBackButton: true),
          preferredSize: Size(double.infinity, 80.h)),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                CustomTextField(
                    hintText: 'عن ماذا تبحث؟',
                    controller: searchController,
                    prefixIcon: Icon(Icons.search_sharp, color: greyColor)),
                Container(
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r)),
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(IconsManager.filterIcon),
                    onPressed: () {
                      NavigationManager.push(Routes.sparePartsFilter);
                    },
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 9.w,
                  mainAxisSpacing: 15.h,
                  mainAxisExtent: 300.h,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      NavigationManager.push(Routes.productDetails);

                    },
                    child: SparePartItemWidget(brandName: 'اسم الماركة',
                    image: ImagesManager.tire2,
                    price: 40,
                      productName: 'اسم المنتج',
                    ),
                  );
                },
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 12,
                padding: EdgeInsets.symmetric(horizontal: 16.w)),
          ),
        ],
      ),
    );
  }
}
