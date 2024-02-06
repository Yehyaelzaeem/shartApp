import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/appLocale.dart';
import '../../../../core/resources/color.dart';
import '../../profile/logic/provider_profile_cubit.dart';
import '../../profile/presentation/complete_profile/widgets/custom_complete_body.dart';
import '../../work_and_products/logic/work_products_cubit.dart';
import 'custom_edit_store_body.dart';

class StoreDataWidget extends StatelessWidget {
  const StoreDataWidget({super.key, this.isX});
 final bool? isX;
  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit cubit = ProviderProfileCubit.get(context);

    return SingleChildScrollView(
        child: BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
          listener: (BuildContext context, ProviderProfileState state) {},
          builder: (BuildContext context,ProviderProfileState  state) {
            if(cubit.providerProfileModel!=null)
                 return Column(
              children: [
                if(cubit.providerProfileModel!.data!.profileCompleted==false)
                  CustomCompleteProfileBody(),
                if(cubit.providerProfileModel!.data!.profileCompleted==true)
                  CustomEditStoreBody(),

              ],
            );
            else
              return Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Center(child: CircularProgressIndicator(),),
              );
          },
        ));
  }
}
