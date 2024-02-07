import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import '../../core/resources/font_manager.dart';
import '../../features/user/auth/logic/auth_cubit.dart';
import '../../features/user/favorite/logic/favorite_cubit.dart';
import '../../features/user/favorite/presentation/widgets/custom_merchants_widget.dart';
import '../../features/user/favorite/presentation/widgets/custom_products_widget.dart';
import '../../widgets/custom_app_bar.dart';

class CustomFavoriteScreen extends StatelessWidget {
  const CustomFavoriteScreen({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80.h),
          child: CustomAppBar(title: '${getLang(context, 'favorite')}'),
        ),
        body:
        BlocConsumer<FavoriteCubit, FavoriteState>(
          listener: (BuildContext context,FavoriteState state) {},
          builder: (BuildContext context, FavoriteState state) {
            return StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
              return   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 50,
                    child: TabBar(
                      onTap: (int val) {
                        setState(() {
                        });
                      },
                      tabs: <Widget>[
                        Tab(text: '${getLang(context, 'products')}'),
                        Tab(text: '${getLang(context, 'merchants')}'),
                      ],
                      padding: AuthCubit.get(context).localeLanguage==Locale('ar')?EdgeInsets.only(left: 150.w):EdgeInsets.only(right: 100.w),
                      labelStyle:
                      TextStyles.font16BlackColor500WeightTajawal.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontFamily: FontConstants.lateefFont,
                        color: Color(0xff136B79),
                      ),
                      unselectedLabelStyle:TextStyles.font16BlackColor500WeightTajawal.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontFamily: FontConstants.lateefFont,
                        color:Colors.black,
                      ),
                      indicatorColor: Color(0xff136B79),
                      labelColor: Color(0xff136B79),
                      unselectedLabelColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        CustomProductFavouriteWidget(),
                        CustomMerchantsFavouriteWidget(),
                      ],
                    ),
                  ),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
