import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../widgets/custom_show_image.dart';
import '../../logic/merchants_cubit.dart';

class CustomWorksAndProductWidget extends StatelessWidget {
  const CustomWorksAndProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit=MerchantsCubit.get(context);

    return
      cubit.merchantsWorksModel!=null?
      Container(
      height:130.h ,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cubit.merchantsWorksModel!.data!.length,
          itemBuilder: (BuildContext context,int index){
            return InkWell(
              onTap: (){
                showCustomImages(context: context, images:  cubit.merchantsWorksModel!.data!.map((e) => e.file!).toList());
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black38,blurRadius: 2)],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: 135.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.network(
                      cubit.merchantsWorksModel!.data![index].file!,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context ,Object error,StackTrace? v){
                        return Center( child: CircularProgressIndicator(),);
                      },),
                  ),
                ),
              ),
            );
          }),
    ):
     Center(child: CircularProgressIndicator(),);
  }
}
