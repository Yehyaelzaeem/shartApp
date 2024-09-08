import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';

import '../../../../../../core/functions/date_formatter.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/routing/navigation_services.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../shared_screens/visitor_screen/widget/visitor_dailog.dart';
import '../../../../book_package_service/presentation/screens/book_package_service_screen.dart';
import '../../../data/model/supplies_model.dart';
import '../../../logic/menu_cubit.dart';


class  SuppliesPackagesDetailsScreen extends StatelessWidget {
   SuppliesPackagesDetailsScreen({Key? key, this.suppliesModelData}) : super(key: key);
  final SuppliesModelData? suppliesModelData;
int  paymentMethod =0;
  @override
  Widget build(BuildContext context) {
    MenuCubit cubit =MenuCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar( title:  getLang(context, 'package_details'),hasBackButton: true)
      ),
      body:
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: packagesColor,
                    border: Border.all(color: Color.fromRGBO(161, 161, 161, 0.20)),
                    borderRadius: BorderRadius.circular(10.r)),
                // padding: EdgeInsets.all(16.w),
                // margin: EdgeInsets.all(16.sp),
                child:
                Row(
                  children: [
                    Container(
                      height: 100.h,
                      width: 130.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network('${suppliesModelData?.image??''}',
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,Object error,StackTrace? v){
                              return Image.asset(ImagesManager.holder,fit: BoxFit.cover,);
                            },
                          )),
                    ),
                    SizedBox(width: 20.w,),
                    Text('${suppliesModelData?.name??''}',
                        style: TextStyle(
                            fontSize: 24.sp,
                            fontFamily: FontConstants.lateefFont,
                            fontWeight: FontWeightManager.bold,
                            color: blackColor)),

                  ],
                ),


              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Text('${data.data![index].name}',
              //         style: TextStyle(
              //             fontSize: 24.sp,
              //             fontFamily: FontConstants.lateefFont,
              //             fontWeight: FontWeightManager.bold,
              //             color: blackColor)),
              //     Text(
              //      '${data.data![index].description}',
              //       style: TextStyle(
              //           fontSize: 16.sp,
              //           fontWeight: FontWeightManager.regular,
              //           color: Color(0xff414141)),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.only(bottom: 12.h, top: 9.h),
              //       child: Align(
              //           alignment: Alignment.center,
              //           child: Container(
              //             height: 200.h,
              //             width: 300.w,
              //             child: ClipRRect(
              //                 borderRadius: BorderRadius.all(Radius.circular(10)),
              //                 child: Image.network('${data.data?[index].image??''}',
              //                   fit: BoxFit.cover,
              //                   errorBuilder: (BuildContext context,Object error,StackTrace? v){
              //                     return Image.asset(ImagesManager.holder,fit: BoxFit.cover,);
              //                   },
              //                 )),
              //           )),
              //     ),
              //     Align(
              //       alignment: Alignment.centerLeft,
              //       child: ElevatedButton(
              //         child: Text(
              //           getLang(context, 'more_details'),
              //           style: TextStyle(
              //               fontSize: 15.sp,
              //               fontFamily: FontConstants.lateefFont,
              //               fontWeight: FontWeightManager.bold,
              //               color:  Colors.black
              //           ),
              //         ),
              //         onPressed: () {
              //
              //           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
              //               SuppliesPackagesDetailsScreen(suppliesModelData:data.data?[index])));
              //           // NavigationManager.push(Routes.checkingPackagesDetails);
              //         },
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: primaryColor,
              //           elevation: 0,
              //           padding: EdgeInsets.symmetric(
              //               vertical: 12.h, horizontal: 18.w),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(12.r),
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ),
            SizedBox(height: 16.h,),
            Text(
              '${getLang(context, 'des')}',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeightManager.bold,
                  color: Color(0xff414141)),
            ),
            Text(
              '${suppliesModelData?.description??''}',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeightManager.regular,
                  color: Color(0xff414141)),
            ),
            SizedBox(height: 16.h,),
            Row(
              children: [
               Expanded(
                 flex: 1,
                 child:  Text(
                 '${getLang(context, 'package_duration')}',
                 style: TextStyle(
                     fontSize: 14.sp,
                     fontWeight: FontWeightManager.bold,
                     color:Colors.black),
               ),),
               Expanded(
                 flex: 2,
                 child:  Text(
                 '${getLang(context, 'from')} ${DateFormatter.formatDayMonthDate(suppliesModelData?.createdAt??'',context)} ${getLang(context, 'to')} ${DateFormatter.formatDayMonthDateWithTime(suppliesModelData?.createdAt??'', suppliesModelData?.duration??'',context)}',
                 style: TextStyle(
                     fontSize: 14.sp,
                     fontWeight: FontWeightManager.medium,
                     color: Color(0xff414141)),
               ),)
              ],
            ),
            SizedBox(height: 16.h,),

            Row(
              children: [
               Expanded(
                 flex: 1,
                 child:  Text(
                 '${getLang(context, 'package_price')}',
                 style: TextStyle(
                     fontSize: 14.sp,
                     fontWeight: FontWeightManager.bold,
                     color:Colors.black),
               ),),
               Expanded(
                 flex: 2,
                 child:  Text(
                   '${suppliesModelData?.price??''} ${getLang(context, 'rs')}',
                 style: TextStyle(
                     fontSize: 14.sp,
                     fontWeight: FontWeightManager.medium,
                     color: Colors.red),
               ),)
              ],
            ),SizedBox(height: 200,),
           BlocConsumer<MenuCubit ,MenuState>(builder: (context,state){
             return  CustomElevatedButton(
                 isLoading: state is StoreSuppliesLoadingState,
                 onTap: (){
                   if(AuthCubit.get(context).token.isNotEmpty){
                     showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         return AlertDialog(
                           content: Container(
                             height: 300.h,
                             width: 343.w,
                             child:
                             Column(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: <Widget>[
                                 Align(
                                   alignment: AlignmentDirectional.topEnd,
                                   child: IconButton(
                                     icon: Icon(Icons.clear),
                                     onPressed: (){
                                       Navigator.of(context).pop();
                                     },
                                   ),),
                                 Text(
                                   getLang(context, 'payment_method'),
                                   style:
                                   TextStyle(
                                       fontFamily: FontConstants.lateefFont,
                                       fontSize: 30.sp,
                                       color: blackTextColor,
                                       fontWeight: FontWeight.w500
                                   ),
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   textAlign: TextAlign.start,
                                 ),
                                 StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState)
                                 {
                                   return Column(
                                     children: <Widget>[
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: <Widget>[
                                           Row(
                                             children: <Widget>[
                                               Image.asset(ImagesManager.visa),
                                               SizedBox(width: 5.w,),
                                               Text(getLang(context, 'visa'),
                                                 style:   TextStyle(
                                                     fontFamily: FontConstants.lateefFont,
                                                     fontSize: 20,
                                                     color: blackTextColor,
                                                     fontWeight: FontWeight.w400
                                                 ),
                                               ),
                                             ],
                                           ),
                                           Spacer(),
                                           Radio<int>(
                                             value: 0,
                                             groupValue: paymentMethod,
                                             onChanged: (int? value) {
                                               setState(() {
                                                 paymentMethod = value!;
                                               });
                                             },
                                           ),
                                         ],
                                       ),
                                       //payment
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: <Widget>[
                                           Row(
                                             children: <Widget>[
                                               Image.asset(ImagesManager.card2),
                                               SizedBox(width: 5.w,),
                                               Text(getLang(context, 'master_card'),
                                                 style:   TextStyle(
                                                     fontFamily: FontConstants.lateefFont,
                                                     fontSize: 20,
                                                     color: blackTextColor,
                                                     fontWeight: FontWeight.w400
                                                 ),
                                               ),
                                             ],
                                           ),
                                           Spacer(),
                                           Radio<int>(
                                             value: 1,
                                             groupValue: paymentMethod,
                                             onChanged: (int? value) {
                                               setState(() {
                                                 paymentMethod = value!;
                                               });
                                             },
                                           ),
                                         ],
                                       ),
                                       BlocConsumer<MenuCubit, MenuState>(
                                         listener: (BuildContext context, MenuState state) {},
                                         builder: (BuildContext context, MenuState state)
                                         {
                                           return Column(
                                             children: <Widget>[
                                               cubit.isLoading?Padding(
                                                 padding: EdgeInsets.symmetric(vertical: 30.h),
                                                 child: Center(child: CircularProgressIndicator(),),
                                               ):
                                               CustomElevatedButton(
                                                   onTap: (){
                                                     // Navigator.pop(context);
                                                     cubit.storeSupplies(suppliesModelData?.id??0, context);
                                                   },
                                                   buttonText: getLang(context, 'ok'))
                                             ],
                                           );
                                         },
                                       )
                                     ],
                                   );
                                 }),

                               ],
                             )
                             ,
                           ),

                         );
                       },

                     );
                   }else{
                     visitorDialog(context);
                     // showToast(text: getLang(context, 'Log_in_first'),state: ToastStates.error, context: context);
                   }
                 }, buttonText: '${getLang(context, 'book_now')}');
           }, listener:  (context,state){})

            // Container(
            //   margin: EdgeInsets.all(16.sp),
            //   decoration: BoxDecoration(
            //     color: whiteColor,
            //     borderRadius: BorderRadius.circular(10.r),
            //     boxShadow: <BoxShadow>[
            //       BoxShadow(
            //         color: Colors.black12.withOpacity(0.2),
            //         spreadRadius: 1,
            //         blurRadius: 1,
            //       ),
            //     ],
            //   ),
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: <Widget>[
            //       SingleChildScrollView(
            //         child: Column(
            //           children:
            //           <Widget>[
            //
            //             Container(
            //               height: 95.h,
            //               width: double.infinity,
            //               color: Color(0xffF9F7EE),
            //               child: Center(
            //                   child: FittedBox(
            //                     child: Text('${suppliesModelData?.name??''}',
            //                       style: TextStyle(
            //                         fontSize: 24.sp,
            //                         fontFamily: FontConstants.lateefFont,
            //                         fontWeight: FontWeightManager.bold,
            //                       ),
            //                     ),
            //                   )),
            //             ),
            //             ListView.builder(
            //               physics: NeverScrollableScrollPhysics(),
            //               padding: EdgeInsets.only(top: 77.h, bottom: 100.h),
            //               itemBuilder: (BuildContext context, int i) {
            //                 return Container(
            //                   width: double.infinity,
            //                   height: 32.h,
            //                   padding: EdgeInsets.symmetric(horizontal: 15.w),
            //                   decoration: BoxDecoration(
            //                       color:
            //                       i % 2 != 0 ? whiteColor : Color(0xffF9F7EE)),
            //                   child: Row(
            //                     children: <Widget>[
            //                       SvgPicture.asset(IconsManager.trueIcon),
            //                       SizedBox(width: 8.w),
            //                       Text('${suppliesModelData?.description??''}')
            //                     ],
            //                   ),
            //                 );
            //               },
            //               shrinkWrap: true,
            //               itemCount: 1,
            //             ),
            //             SizedBox(height: 80.h,),
            //             Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 16.w),
            //               child: CustomElevatedButton(
            //                   onTap: () {
            //                     if(AuthCubit.get(context).token.isNotEmpty){
            //                       // Navigator.push(context,
            //                       // MaterialPageRoute(builder: (BuildContext context)=>
            //                       //     UserBookPackageServiceScreen(packageId: data.data![index!].id.toString(),)));
            //                     }else{
            //                       visitorDialog(context);
            //                     }
            //                     // NavigationManager.push(Routes.bookPackageService);
            //                   },
            //                   buttonText: getLang(context, 'subscribe_now')),
            //             ),
            //             SizedBox(height: 80.h,)
            //           ],
            //         ),
            //       ),
            //       Positioned(
            //         top: 70.h,
            //         child: SizedBox(
            //           width: MediaQuery.of(context).size.width,
            //           child: Center(
            //             child: CircleAvatar(
            //               radius: 44.sp,
            //               child: CircleAvatar(
            //                 radius: 40.sp,
            //                 backgroundColor: Color(0xffF9F7EE),
            //                 child: Text(
            //                   '${suppliesModelData?.price??''}\n ${getLang(context, 'rs')}',
            //                   style: TextStyle(
            //                     fontSize: 20.sp,
            //                     fontWeight: FontWeightManager.bold,
            //                     fontFamily: FontConstants.lateefFont,
            //                     color: blackColor,
            //                   ),
            //                 ),
            //               ),
            //               backgroundColor: whiteColor,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      )

    );
  }
}
