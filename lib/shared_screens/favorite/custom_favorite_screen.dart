import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/shared_screens/favorite/widgets/custom_favorite_items.dart';
import '../../core/resources/assets_menager.dart';
import '../../core/resources/color.dart';
import '../../core/resources/font_manager.dart';
import '../../features/user/favorite/logic/favorite_cubit.dart';
import '../../widgets/custom_app_bar.dart';

class CustomFavoriteScreen extends StatelessWidget {
  const CustomFavoriteScreen({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    FavoriteCubit cubit =FavoriteCubit.get(context);
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: '${getLang(context, 'favorite')}'),
      ),
      body:
      BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (BuildContext context,FavoriteState state) {},
        builder: (BuildContext context, FavoriteState state) {

          if(cubit.favoriteProductsUser!=null){
            if(cubit.favoriteProductsUser!.data!.length==0){
            return
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
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 9.w,
                mainAxisSpacing: 15.h,
                mainAxisExtent: 220.h,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CustomFavoriteItem(favoriteProductsUserData: cubit.favoriteProductsUser!.data![index],);
              },
              shrinkWrap: true,
              itemCount: cubit.favoriteProductsUser!.data!.length,
              padding: EdgeInsets.all(16.w),
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
