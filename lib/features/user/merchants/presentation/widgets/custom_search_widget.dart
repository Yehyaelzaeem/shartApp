import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../logic/merchants_cubit.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit = MerchantsCubit.get(context);

    return BlocConsumer<MerchantsCubit, MerchantsState>(
      listener: (BuildContext context,MerchantsState state) {},
      builder: (BuildContext context,MerchantsState state) {
        return Padding(
          padding: EdgeInsets.only(top: 16.h, right: 16.w, left: 16.w,),
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              CustomTextField(
                hintText: '  ${getLang(context, 'hit_message')}',
                controller: cubit.searchController,
                textInputAction: TextInputAction.search,
                prefixIcon: Icon(Icons.search_sharp, color: greyColor),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    cubit.changeSearch(true);
                   cubit.getSearchMerchants(value,context);
                  } else {
                    cubit.changeSearch(false);
                  }
                },
                onFieldSubmitted: (String val) {
                  cubit.changeSearch(true);
                  cubit.getSearchMerchants(val,context);
                },
              ),
              cubit.isSearching == true ?
              Positioned(
                  left: 10,
                  top: 3,
                  bottom: 3,
                  child: Container(
                    width: 30.w,
                    color: Colors.white,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          cubit.searchController.text = '';
                          cubit.changeSearch(false);
                        },
                        icon: Icon(Icons.clear,
                          color: blueColor,
                        ),
                      ),
                    ),
                  )) :
              SizedBox.shrink(),
              // Container(
              //   decoration: BoxDecoration(
              //     color: blueColor,
              //     borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(10.r),
              //         bottomLeft: Radius.circular(10.r)),
              //   ),
              //   child: IconButton(
              //     icon: SvgPicture.asset(IconsManager.filterIcon),
              //     onPressed: () {
              //       // cubit.changeLoadingSearch(true);
              //       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SparePartsFilterScreen(type: type,)));
              //       // NavigationManager.push(Routes.sparePartsFilter);
              //     },
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
