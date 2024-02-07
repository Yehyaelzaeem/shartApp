import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../logic/merchants_cubit.dart';
import 'custom_product_details.dart';

class CustomProductsListViewWidget extends StatelessWidget {
  const CustomProductsListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MerchantsCubit cubit=MerchantsCubit.get(context);
    return
    cubit.productsModel!=null?
     Container(
      height:110.h ,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:  cubit.productsModel!.data!.length,
          itemBuilder: (BuildContext context,int index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (BuildContext context)=>CustomProductDetails(productModelData: cubit.productsModel!.data![index],isCart: true,),),);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 110.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[BoxShadow(color: Colors.black38,blurRadius: 2)],
                      borderRadius: BorderRadius.circular(5)
                  ),
                  width: 80.w,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)
                          ),
                          child: Image.network(
                              cubit.productsModel!.data![index].images![0].image!,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context ,Object error,StackTrace? v){
                                  return Center( child: CircularProgressIndicator(),);
                                },
                              ),
                        ),
                      ),
                      Container(
                        height:25.h,
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Center(
                          child: Text(cubit.productsModel!.data![index].title!,
                            style:TextStyles.font12BlackColor700WeightTajawal,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            );
          }),
    ):
     Center(child: CircularProgressIndicator(),);
  }
}
