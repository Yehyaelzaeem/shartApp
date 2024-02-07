import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../data/models/mer_model.dart';
import '../../logic/merchants_cubit.dart';
import '../widgets/custom_mer_image_title.dart';
import '../widgets/custom_mer_location_row.dart';
import '../widgets/custom_product_list_view.dart';
import '../widgets/custom_works_product_widget.dart';

class CustomMerDetailsScreen extends StatelessWidget {
  const CustomMerDetailsScreen({super.key, required this.merchantsModelData});
  final MerchantsModelData merchantsModelData;

  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit=MerchantsCubit.get(context);
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: getLang(context, 'merchant_details'),hasBackButton: true),
        ),
        body: BlocConsumer<MerchantsCubit, MerchantsState>(
        listener: (BuildContext context,MerchantsState state) {},
        builder: (BuildContext context,MerchantsState state) {
          return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomMerImageTitleWidget(merchantsModelData: merchantsModelData,),
                      SizedBox(height: 24.h,),
                      Text(
                        getLang(context, 'number_products'),
                        style:
                        TextStyles.font16BlackColor500WeightTajawal
                      ),
                      Text('${merchantsModelData.productsCount} ${getLang(context, 'product')}',
                        style:
                        TextStyles.font16BlackColor500WeightTajawal.copyWith(
                          fontWeight: FontWeight.w400,
                          color: textGeryColor
                        )
                      ),
                      SizedBox(height: 16 .h,),
                      Divider(color: dividerColor,),
                      SizedBox(height: 16.h,),
                      Text('${getLang(context, 'products')}',
                        style:  TextStyles.font16BlackColor500WeightTajawal
                      ),
                      cubit.productsModel!=null?
                      CustomProductsListViewWidget():
                      Center(child: CircularProgressIndicator(),),
                      SizedBox(height: 24.h,),
                      Divider(color: dividerColor,),
                      SizedBox(height: 24.h,),
                      Text('${getLang(context, 'business_photos')}',
                        style:
                        TextStyles.font16BlackColor500WeightTajawal
                      ),
                      cubit.merchantsWorksModel!=null?
                      CustomWorksAndProductWidget():
                      Center(child: CircularProgressIndicator(),),
                      SizedBox(height: 24.h,),
                      Divider(color: dividerColor,),
                      SizedBox(height: 24.h,),
                      Text('${getLang(context, 'branch_addresses')}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontConstants.Tajawal,
                            fontSize: 16,
                            color: blackTextColor
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      cubit.merchantsAddressModel!=null?
                          Column(children: [
                            ...cubit.merchantsAddressModel!.data!.map((e) => Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomMerLocationRow(merchantsAddressModelData: e,),
                            )),
                          ],):
                          Center(child: CircularProgressIndicator(),),
                      SizedBox(height: 40.h,),
                    ],
                  ),
                ),
              );
        },
      ),
    );
  }
}
