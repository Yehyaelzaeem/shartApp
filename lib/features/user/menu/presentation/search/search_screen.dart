import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/features/user/menu/data/model/product_model.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../../provider/work_and_products/data/model/product_model.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../favorite/logic/favorite_cubit.dart';
import '../../../products/presentation/screens/product_details_screen.dart';
import '../../logic/menu_cubit.dart';
import '../spare_parts/widgets/spare_part_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MenuCubit cubit = MenuCubit.get(context);
    return Scaffold(
        body: BlocConsumer<MenuCubit, MenuState>(
          listener: (BuildContext context,MenuState state) {},
          builder: (BuildContext context,MenuState state) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 70.h,),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: CustomTextField(
                      borderColor: greyColor,
                      hintText: getLang(context, 'hit_message'),
                      hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: greyColor
                      ),
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (String v){
                        cubit.searchProducts(name :cubit.searchControllerHome.text,context: context);
                      },
                      prefixIcon: const Icon(Icons.search, color: greyColor,),
                      controller: cubit.searchControllerHome,
                      onChanged: (String value) {
                        if(value.isNotEmpty){
                          cubit.changeSearchStart(true);
                          cubit.searchProducts(name :value,context: context);
                        }else{
                          cubit.changeSearchStart(false);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  cubit.isSearchStart?
                  Column(
                    children: <Widget>[
                      cubit.searchProductModel!=null?
                      cubit.searchProductModel!.data!.length!=0?
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 9.w,
                            mainAxisSpacing: 15.h,
                            mainAxisExtent: 300.h,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var data2 = cubit.searchProductModel!.data![index];
                            return Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                     var data = cubit.searchProductModel!.data![index];
                                    List<String> list= [];
                                    for(var a in data.images!){
                                      list.add(a.image.toString());
                                    }
                                    Navigator.push(context, MaterialPageRoute(builder:
                                        (BuildContext context)=>ProductDetailsScreen(
                                      title: data.title,
                                      price: data.price.toString() ,
                                      brandName:data.brand!=null?data.brand!.name:'',
                                      width:'${data.width!=null?data.width!.name:''}',
                                      height:'${data.height!=null?data.height!.name:''}',
                                      images: list,
                                      size:'${data.size!=null?data.size!.name:''}',
                                      productStatus: data.productStatus,
                                      description:data.description ,
                                      cartProduct: Cart(
                                          id: data2.id,
                                          productId: data2.id.toString(),
                                          productName: data2.title,
                                          productPrice: data2.price,
                                          description: data2.description,
                                          image: data2.images![0].image,
                                          type: data2.type,
                                          productState: data2.productStatus,
                                          providerId: data2.provider!.id!.toString(),
                                          count: 1,
                                          productBrand: data2.brand!=null?data2.brand!.name:''),

                                    )));
                                    // NavigationManager.push(Routes.productDetails);
                                  },
                                  child:
                                  SparePartItemWidget(brandName: '${cubit.searchProductModel!.data![index].brand!=null?cubit.searchProductModel!.data![index].brand!.name:''}',
                                    image: '${cubit.searchProductModel!.data![index].images![0].image}',
                                    price: cubit.searchProductModel!.data![index].price.toString(),
                                    productName: '${cubit.searchProductModel!.data![index].title}',
                                    id: '${cubit.searchProductModel!.data![index].id}',
                                    isFav: cubit.searchProductModel!.data![index].isFav,
                                    cartProduct: Cart(
                                        id: data2.id,
                                        productId: data2.id.toString(),
                                        productName: data2.title,
                                        productPrice: data2.price,
                                        description: data2.description,
                                        image: data2.images![0].image,
                                        type: data2.type,
                                        productState: data2.productStatus,
                                        providerId: data2.provider!.id!.toString(),
                                        count: 1,
                                        productBrand: data2.brand!=null?data2.brand!.name:''),
                                    providerName: data2.provider!.name!,

                                  ),
                                ),
                                Positioned(
                                    top: 8.h,
                                    right: 16.w,
                                    child:
                                    StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                                      return  data2.isFav==true?
                                      InkWell(
                                        onTap: (){
                                          if(AuthCubit.get(context).token.isNotEmpty){
                                            setState(() {
                                              data2.isFav=false;
                                            });
                                            FavoriteCubit.get(context).addAndRemoveFavoriteProducts(data2.id.toString(),AuthCubit.get(context).token,context);

                                          }else{
                                            showToast(text: getLang(context, 'Log_in_first'), state: ToastStates.error, context: context);
                                          }
                                        },
                                        child: CircleAvatar(
                                            minRadius: 12.sp,
                                            backgroundColor: whiteColor,
                                            child:
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 15.sp,
                                            )
                                        ),
                                      ) :
                                      InkWell(
                                        onTap: (){
                                          if(AuthCubit.get(context).token.isNotEmpty){
                                            setState(() {
                                              data2.isFav=true;
                                            });
                                            FavoriteCubit.get(context).addAndRemoveFavoriteProducts(data2.id.toString(),AuthCubit.get(context).token,context);
                                          }else{
                                            showToast(text: getLang(context, 'Log_in_first'), state: ToastStates.error, context: context);
                                          }
                                        },
                                        child: CircleAvatar(
                                          minRadius: 12.sp,
                                          backgroundColor: whiteColor,
                                          child:
                                          Icon(
                                            Icons.favorite_border_rounded,
                                            color: Colors.grey,
                                            size: 15.sp,
                                          ),
                                        ),
                                      );
                                    })
                                ),
                              ],
                            );
                          },
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: cubit.searchProductModel!.data!.length,
                          padding: EdgeInsets.symmetric(horizontal: 16.w)):
                      Padding(
                        padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.3),
                        child: Center(child: Text(getLang(context, 'no_product_found'),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),),
                      ) :
                          Padding(
                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.32),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                    ],
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 150.h,),
                      Image.asset(ImagesManager.favorite),
                      SizedBox(height: 25.h,),
                      Text(getLang(context, 'search_no'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: geryTextColor,
                              fontFamily: 'Cairo'
                          )
                      ),
                    ],
                  ),


                ],
              ),
            );
          },
        )
    );
  }
}
