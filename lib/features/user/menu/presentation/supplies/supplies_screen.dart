import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/features/user/menu/data/model/check_model.dart';
import 'package:shart/features/user/menu/logic/menu_cubit.dart';
import 'package:shart/features/user/menu/presentation/packages/packages_details/package_details_screen.dart';
import 'package:shart/features/user/menu/presentation/supplies/supplies_details/supplies_details_screen.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../data/model/supplies_model.dart';


class SuppliesPackagesScreen extends StatelessWidget {
  const SuppliesPackagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuCubit cubit =MenuCubit.get(context);
    return RefreshIndicator(child:
    Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 70.h),
            child: CustomAppBar(title: getLang(context, 'packages'),hasBackButton: true)
        ),
        body: BlocConsumer<MenuCubit,MenuState>(
          builder: (BuildContext context ,MenuState state){
            if(cubit.suppliesModel!=null){
              final SuppliesModel data =cubit.suppliesModel!;

              return
                data.data?.length==0?Center(child: Text('No packages now')):
                ListView.builder(
                    itemCount: data.data?.length,
                    itemBuilder: (BuildContext context,int index){
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                              SuppliesPackagesDetailsScreen(suppliesModelData:data.data?[index])));
                        },
                        child:
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
                                      child: Image.network('${data.data?[index].image??''}',
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context,Object error,StackTrace? v){
                                          return Image.asset(ImagesManager.holder,fit: BoxFit.cover,);
                                        },
                                      )),
                                ),
                                SizedBox(width: 20.w,),
                                Text('${data.data![index].name}',
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        fontFamily: FontConstants.lateefFont,
                                        fontWeight: FontWeightManager.bold,
                                        color: blackColor)),
                              ],
                            )
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
                      )
                      );
                    });
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
          listener: (BuildContext context ,MenuState state){},
        )
    ),
        onRefresh: ()async{
         await Future.delayed(Duration(seconds: 1));
         cubit.getSuppliesPackage(context);
        });

  }
}
