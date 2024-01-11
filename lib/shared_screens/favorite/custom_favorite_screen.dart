import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/shared_screens/favorite/widgets/custom_favorite_items.dart';
import '../../widgets/custom_app_bar.dart';

class CustomFavoriteScreen extends StatelessWidget {
  const CustomFavoriteScreen({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: '${getLang(context, 'favorite')}'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 9.w,
          mainAxisSpacing: 15.h,
          mainAxisExtent: 220.h,
        ),
        itemBuilder: (BuildContext context, int index) {
          return CustomFavoriteItem();
        },
        shrinkWrap: true,
        itemCount: 6,
        padding: EdgeInsets.all(16.w),
      ),
    );
  }
}
