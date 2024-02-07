import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_text_field.dart';
import 'merchants_details_screen.dart';

class MerchantsScreen extends StatelessWidget {
  const MerchantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: getLang(context, 'merchants'),hasBackButton: true),
      ),
      body:
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h,right: 16.w,left: 16.w,),
            child: Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                CustomTextField(
                  hintText: '  ${getLang(context, 'hit_message')}',
                  controller: TextEditingController(),
                  textInputAction: TextInputAction.search,
                  prefixIcon: Icon(Icons.search_sharp, color: greyColor),
                  onFieldSubmitted: (String val){
                    // cubit.changeLoadingSearch(true);
                    // type=='spare_parts'?
                    // cubit.searchProducts(name:cubit.searchController.text.trim(),type:'spare_parts',context: context):
                    // cubit.searchProductsRimsAndTires(name:cubit.searchController.text.trim(),type:type,context: context);
                  },
                ),
                // cubit.isSearching==true?
                // Positioned(
                //     right: 10,
                //     top: 3,
                //     bottom: 3,
                //     child: Container(
                //       width: 30.w,
                //       color: Colors.white,
                //       child: Center(
                //         child: IconButton(
                //           onPressed: (){
                //             cubit.searchController.text='';
                //             cubit.changeLoadingSearch(false);
                //           },
                //           icon: Icon(Icons.clear,
                //             color: blueColor,
                //           ),
                //         ),
                //       ),
                //     )):SizedBox.shrink(),
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
                      // cubit.changeLoadingSearch(true);
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SparePartsFilterScreen(type: type,)));
                      // NavigationManager.push(Routes.sparePartsFilter);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 9.w,
                mainAxisSpacing: 15.h,
                // childAspectRatio: 5/6.5
                mainAxisExtent: 250.h,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>MerchantsDetailsScreen()));
                  },
                  child: Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: whiteColor,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: greyColor.withOpacity(0.3),
                              blurRadius: 1,
                              spreadRadius: 1)
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(

                          decoration: BoxDecoration(
                            color: greyColor.withOpacity(0.4),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                                topLeft: Radius.circular(10.r)),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Image.asset(ImagesManager.sawabImg,
                                height: 150.h, fit: BoxFit.fill,width: double.infinity,),
                              Positioned(
                                top: 8.h,
                                right: 16.w,
                                child: CircleAvatar(
                                  backgroundColor: whiteColor,
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Color(0xff818181),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Text(
                            'الثواب لقطع الغيار',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.bold,
                            ),
                            textAlign:TextAlign.center,

                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              // physics: BouncingScrollPhysics(),
              itemCount: 6,
              padding: EdgeInsets.all(16.w),
            ),
          ),
        ],
      ),
    );
  }
}
