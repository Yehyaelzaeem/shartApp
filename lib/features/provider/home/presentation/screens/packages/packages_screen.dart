import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/provider/home/data/model/history_packages_model.dart';
import 'package:shart/features/provider/home/data/model/packages_model.dart';
import 'package:shart/features/provider/home/logic/provider_home_cubit.dart';
import 'package:shart/features/provider/home/presentation/screens/packages/widget/custom_body_packages.dart';
import '../../../../../../core/localization/appLocale.dart';
import '../../../../../../widgets/custom_app_bar.dart';
class ProviderPackagesScreen extends StatelessWidget {
  const ProviderPackagesScreen({Key? key, this.isHistory}) : super(key: key);
  final bool? isHistory;
  @override
  Widget build(BuildContext context) {
    ProviderHomeCubit cubit =ProviderHomeCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: getLang(context, 'register_packages'),hasBackButton: true,
        ),
      ),
      body:
      isHistory==true?
      BlocConsumer<ProviderHomeCubit, ProviderHomeState>(
          listener: (BuildContext context, ProviderHomeState state) {},
          builder: (BuildContext context, ProviderHomeState state) {
            print("historyPackages => ${isHistory} ");
            if(cubit.historyPackages!=null){
              return
                ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  HistoryPackagesData data =cubit.historyPackages!.data![index];
                  return CustomBodyPackages(
                    id: data.id.toString() ,
                    description: data.subscription!.description,
                    price: data.subscription!.price.toString(),
                    index:index ,
                    title:data.subscription!.title ,
                    startDate:data.startsAt ,
                    endDate: data.endsAt,
                    status: data.status,
                    isHistory: true,
                  );
                },
                physics: BouncingScrollPhysics(),
                itemCount: cubit.historyPackages!.data!.length ,
                padding: EdgeInsets.all(16.w),
                shrinkWrap: true,
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
  },
):
      BlocConsumer<ProviderHomeCubit, ProviderHomeState>(
          listener: (BuildContext context, ProviderHomeState state) {},
          builder: (BuildContext context, ProviderHomeState state) {

            if(cubit.packagesModel!=null){
              return
                ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  PackagesModelData data =cubit.packagesModel!.data![index];
                  return CustomBodyPackages(
                    id: data.id.toString() ,
                    description: data.description,
                    price: data.price.toString(),
                    index:index ,
                    title:data.title ,
                    isHistory: false,
                  );
                },
                physics: BouncingScrollPhysics(),
                itemCount: cubit.packagesModel!.data!.length ,
                padding: EdgeInsets.all(16.w),
                shrinkWrap: true,
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
  },
),
    );
   }
}
