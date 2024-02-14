import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../data/models/mer_model.dart';
import '../widgets/custom_branch_widget.dart';
import '../widgets/custom_previous_widget.dart';
import '../widgets/custom_product_widget.dart';
import '../widgets/custom_top_merchants_details.dart';

class MerchantsDetailsScreen extends StatefulWidget {
  const MerchantsDetailsScreen({super.key, required this.merchantsModelData});
  final MerchantsModelData merchantsModelData;

  @override
  State<MerchantsDetailsScreen> createState() => _MerchantsDetailsScreenState();
}

class _MerchantsDetailsScreenState extends State<MerchantsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80.h),
          child: CustomAppBar(title: getLang(context, 'merchant_details'),hasBackButton: true,hasCartButton: true,),
        ),
        body:
        Column(
          children: <Widget>[
            CustomTopMerchantsDetails(merchantsModelData: widget.merchantsModelData,),
            TabBar(
              onTap: (int val) {
                setState(() {});
              },
              tabs: <Widget>[
                Tab(text: '${getLang(context, 'products')}'),
                Tab(text: '${getLang(context, 'previous_work')}'),
                Tab(text: '${getLang(context, 'branch_addresses')}'),
              ],
              labelStyle: TextStyles.font15BlueColor500WeightTajawal,
              unselectedLabelStyle: TextStyles.font15BlueColor500WeightTajawal.copyWith(
                color: blackTextColor
              ),
              indicatorColor:blueColor,
              labelColor: blueColor,
              indicatorPadding: EdgeInsets.zero,
              unselectedLabelColor: blackTextColor,
            ),
             Expanded(
              child: TabBarView(
                children: <Widget>[
                  CustomProductsWidgetTabBar(),
                  CustomPreviousWorkWidgetTabBar(),
                  CustomBranchAddressesWidgetTabBar(),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
