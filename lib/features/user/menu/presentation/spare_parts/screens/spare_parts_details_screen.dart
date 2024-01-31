import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/features/user/menu/data/model/product_model.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../../../../core/localization/appLocale.dart';
import '../../../../../../widgets/show_toast_widget.dart';
import '../../../../auth/logic/auth_cubit.dart';
import '../../../../cart/data/model/cart_model.dart';
import '../../../../favorite/logic/favorite_cubit.dart';
import '../../../../products/presentation/screens/product_details_screen.dart';
import '../../../logic/menu_cubit.dart';
import '../filter/screens/filter_spare_parts_screen.dart';
import '../widgets/spare_part_item.dart';

class SparePartsDetailsScreen extends StatelessWidget {
  const SparePartsDetailsScreen({Key? key, required this.type}) : super(key: key);
 final String type;
  @override
  Widget build(BuildContext context) {
    MenuCubit cubit =MenuCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(title:getLang(context, type), hasBackButton: true,hasCartButton: true,),
          preferredSize: Size(double.infinity, 80.h)),
      body:
      BlocConsumer<MenuCubit, MenuState>(
        listener: (BuildContext context,MenuState state) {},
        builder: (BuildContext context,MenuState state) {
          if(cubit.productModel!=null){
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: <Widget>[
                      CustomTextField(
                          hintText: '  ${getLang(context, 'hit_message')}',
                          controller: cubit.searchController,
                          textInputAction: TextInputAction.search,
                          prefixIcon: Icon(Icons.search_sharp, color: greyColor),
                         onFieldSubmitted: (String val){
                           cubit.changeLoadingSearch(true);
                           type=='spare_parts'?
                            cubit.searchProducts(name:cubit.searchController.text.trim(),type:'spare_parts',context: context):
                           cubit.searchProductsRimsAndTires(name:cubit.searchController.text.trim(),type:type,context: context);
                         },
                      ),
                     cubit.isSearching==true?
                     Positioned(
                           right: 10,
                           top: 3,
                            bottom: 3,
                          child: Container(
                            width: 30.w,
                            color: Colors.white,
                            child: Center(
                              child: IconButton(
                              onPressed: (){
                                cubit.searchController.text='';
                                cubit.changeLoadingSearch(false);
                              },
                              icon: Icon(Icons.clear,
                              color: blueColor,
                              ),
                                                      ),
                            ),
                          )):SizedBox.shrink(),
                      Container(
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r)),
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(IconsManager.filterIcon),
                          onPressed: () {
                            cubit.changeLoadingSearch(true);
                             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SparePartsFilterScreen(type: type,)));
                            // NavigationManager.push(Routes.sparePartsFilter);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if(cubit.isSearching==false)
                 Flexible(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 9.w,
                        mainAxisSpacing: 15.h,
                        mainAxisExtent: 300.h,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        ProductModelData data2 = cubit.productModel!.data![index];
                        return Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                final ProductModelData data = cubit.productModel!.data![index];
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
                                          providerId: data2.provider!=null?data2.provider!.id!.toString():'',
                                          count: 1,
                                          productBrand: data2.brand!=null?data2.brand!.name:''),

                                 )));
                                // NavigationManager.push(Routes.productDetails);
                              },
                              child: SparePartItemWidget(brandName: '${cubit.productModel!.data![index].brand!=null?cubit.productModel!.data![index].brand!.name:''}',
                                image: '${cubit.productModel!.data![index].images![0].image}',
                                price: cubit.productModel!.data![index].price.toString(),
                                productName: '${cubit.productModel!.data![index].title}',
                                id: '${cubit.productModel!.data![index].id}',
                                isFav: cubit.productModel!.data![index].isFav,
                                cartProduct: Cart(
                                    id: data2.id,
                                    productId: data2.id.toString(),
                                    productName: data2.title,
                                    productPrice: data2.price,
                                    description: data2.description,
                                    image: data2.images![0].image,
                                    type: data2.type,
                                    productState: data2.productStatus,
                                    providerId: data2.provider!=null?data2.provider!.id!.toString():'',
                                    count: 1,
                                    productBrand: data2.brand!=null?data2.brand!.name:''),
                                    providerName: data2.provider!=null?data2.provider!.name!:'',

                              ),
                            ),
                            Positioned(
                              top: 8.h,
                              right: 16.w,
                              child:
                             StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                               return  cubit.productModel!.data![index].isFav==true?
                               InkWell(
                                 onTap: (){
                                   if(AuthCubit.get(context).token.isNotEmpty){
                                     setState(() {
                                       cubit.productModel!.data![index].isFav=false;
                                     });
                                     FavoriteCubit.get(context).addAndRemoveFavoriteProducts(cubit.productModel!.data![index].id.toString(),AuthCubit.get(context).token,context);

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
                                       cubit.productModel!.data![index].isFav=true;
                                     });
                                     FavoriteCubit.get(context).addAndRemoveFavoriteProducts(cubit.productModel!.data![index].id.toString(),AuthCubit.get(context).token,context);
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
                      itemCount:
                      cubit.productModel!.data!.length,
                      padding: EdgeInsets.symmetric(horizontal: 16.w)),
                ),
                if(cubit.isSearching==true)
                  cubit.searchProductModel!=null?
                  cubit.searchProductModel!.data!.length!=0?
                  Flexible(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 9.w,
                          mainAxisSpacing: 15.h,
                          mainAxisExtent: 300.h,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          ProductModelData data2 =
                          cubit.searchProductModel!.data![index];
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  final ProductModelData data = cubit.searchProductModel!.data![index];

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
                                            providerId: data2.provider!=null?data2.provider!.id!.toString():'',
                                            count: 1,
                                            productBrand: data2.brand!=null?data2.brand!.name:''),

                                  )));
                                  // NavigationManager.push(Routes.productDetails);
                                },
                                child: SparePartItemWidget(brandName: '${cubit.searchProductModel!.data![index].brand!=null?cubit.searchProductModel!.data![index].brand!.name:''}',
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
                                      providerId: data2.provider!=null?data2.provider!.id!.toString():'',
                                      count: 1,
                                      productBrand: data2.brand!=null?data2.brand!.name:''),
                                  providerName: data2.provider!=null?data2.provider!.name!:'',

                                ),
                              ),
                              Positioned(
                                  top: 8.h,
                                  right: 16.w,
                                  child:
                                  StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                                    return  cubit.productModel!.data![index].isFav==true?
                                    InkWell(
                                      onTap: (){
                                        if(AuthCubit.get(context).token.isNotEmpty){
                                          setState(() {
                                            cubit.productModel!.data![index].isFav=false;
                                          });
                                          FavoriteCubit.get(context).addAndRemoveFavoriteProducts(cubit.productModel!.data![index].id.toString(),AuthCubit.get(context).token,context);

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
                                            cubit.productModel!.data![index].isFav=true;
                                          });
                                          FavoriteCubit.get(context).addAndRemoveFavoriteProducts(cubit.productModel!.data![index].id.toString(),AuthCubit.get(context).token,context);
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
                        padding: EdgeInsets.symmetric(horizontal: 16.w)),
                  ):
                  Padding(
                      padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.3),
                      child: Center(child: Text(getLang(context, 'no_product_found'),
                      style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                      ),),),
                      ) :
                  Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.3),
                    child: Center(
                      child: CircularProgressIndicator(),
                    //   child:
                    //
                    // Text(getLang(context, 'hit_message'),
                    // style: TextStyle(
                    //   color: Colors.black,
                    //   fontWeight: FontWeight.bold
                    // ),),
                    ),
                  ),
              ],
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
