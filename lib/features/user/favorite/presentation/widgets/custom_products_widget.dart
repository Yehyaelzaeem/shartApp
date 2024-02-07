import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../shared_screens/favorite/widgets/custom_favorite_items.dart';
import '../../logic/favorite_cubit.dart';

class CustomProductFavouriteWidget extends StatelessWidget {
  const CustomProductFavouriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteCubit cubit =FavoriteCubit.get(context);

    return Column(
      children: <Widget>[
        if(cubit.favoriteProductsUser!=null)
          if(cubit.favoriteProductsUser!.data!.length==0)
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: Image.asset(ImagesManager.favorite)),
                  SizedBox(height: 16.h,),
                  Text(
                    getLang(context, 'no_item_favorite'),
                    style: TextStyle(
                        fontSize: 20.0,
                        color: blackTextColor,
                        fontFamily: FontConstants.lateefFont,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            )
          else
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 9.w,
                mainAxisSpacing: 15.h,
                mainAxisExtent: 200.h,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CustomFavoriteItem(favoriteProductsUserData: cubit.favoriteProductsUser!.data![index],);
              },
              shrinkWrap: true,
              itemCount: cubit.favoriteProductsUser!.data!.length,
              padding: EdgeInsets.all(16.w),
            )
        else
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100.h),
            child: Center(child: CircularProgressIndicator(),),
          ),
      ],
    );
  }
}
