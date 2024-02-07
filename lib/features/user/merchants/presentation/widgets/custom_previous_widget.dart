import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shart/features/user/merchants/data/models/mer_works_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_show_image.dart';
import '../../logic/merchants_cubit.dart';
import 'custom_show_image.dart';

class CustomPreviousWorkWidgetTabBar extends StatelessWidget {
  const CustomPreviousWorkWidgetTabBar({super.key});
  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit = MerchantsCubit.get(context);
    return BlocConsumer<MerchantsCubit, MerchantsState>(
      listener: (BuildContext context, MerchantsState state) {},
      builder: (BuildContext context, MerchantsState state) {
        if (cubit.merchantsWorksModel != null) {
          if (cubit.merchantsWorksModel!.data!.length == 0) {
            return Center(child: Text('${getLang(context, 'no_data')}'),);
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 9.w,
                mainAxisSpacing: 15.h,
                // childAspectRatio: 5/6.5
                mainAxisExtent: 110.h,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    showCustomImages(context: context, images:  cubit.merchantsWorksModel!.data!.map((MerchantsWorksModelData e) => e.file!).toList());
                  },
                  child:
                  Container(
                    decoration: BoxDecoration(
                        color: greyColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: greyColor,
                              blurRadius: 1,
                              spreadRadius: 1)
                        ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        cubit.merchantsWorksModel!.data![index].file!,
                        height: 110.h,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (BuildContext context ,Object error,StackTrace? v){
                          return Center(child: CircularProgressIndicator(),);
                        },
                      ),
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              // physics: BouncingScrollPhysics(),
              itemCount: cubit.merchantsWorksModel!.data!.length,
              padding: EdgeInsets.all(16.w),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
