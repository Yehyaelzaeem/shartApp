import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/localization/appLocale.dart';
import '../../../../../../../core/resources/assets_menager.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../shared_screens/pachages/package_subscribe_details_screen.dart';
import '../../../../logic/provider_home_cubit.dart';

class CustomBodyPackages extends StatelessWidget {
  const CustomBodyPackages({super.key, this.id, this.description, this.title, this.price, this.index, this.isHistory, this.startDate, this.endDate, this.status});
  final String? id;
  final int? index;
  final List<String>? description;
  final String? title;
  final String? price;
  final String? startDate;
  final String? endDate;
  final String? status;
  final bool? isHistory;


  @override
  Widget build(BuildContext context) {
    // ProviderHomeCubit cubit =ProviderHomeCubit.get(context);
    return           Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ClipRRect(
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: blackColor.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10.r),
          ),
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
              side: BorderSide(color: blackColor.withOpacity(0.5))),
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (BuildContext context)=>SubscribePackagesDetailsScreen(
                  title: title,
                  list: description,
                  id:  id.toString(),
                  price: price.toString(),
                )));
              },
              child: Container(
                margin: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10.h),
                          height: 95.h,
                          width: double.infinity,
                          color: Color(0xffF9F7EE),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:  EdgeInsets.only(right: 16.w),
                                child: Container(
                                  alignment: AlignmentDirectional.topStart,
                                  width:400.w,
                                  height: 20.h,
                                  child: FittedBox(
                                    child: Text(
                                      'صالحة من 26 سبتمبر إلى 26 أكتوبر',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.green,
                                        fontFamily: FontConstants.lateefFont,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  title!,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontFamily: FontConstants.lateefFont,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,

                                ),

                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 77.h, bottom: 10.h),
                          itemBuilder: (BuildContext context, int index2) {
                            return Container(
                              width: double.infinity,
                              height: 32.h,
                              padding:
                              EdgeInsets.symmetric(horizontal: 15.w),
                              decoration: BoxDecoration(
                                  color: index! % 2 != 0 ? whiteColor : Color(0xffF9F7EE)),
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(IconsManager.trueIcon),
                                  SizedBox(width: 8.w),
                                  Text('${description![index2]}',)
                                ],
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: description!.length,
                        ),
                        isHistory==true?
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 30.w,),
                                Text('${getLang(context, 'start_at')}  :  ',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                    fontFamily: FontConstants.lateefFont,
                                    letterSpacing: 0.004200000017881393,
                                    fontWeight: FontWeight.bold
                                ),
                                ),
                                Text('${startDate}',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                    fontFamily: FontConstants.lateefFont,
                                    letterSpacing: 0.004200000017881393,
                                    fontWeight: FontWeight.bold
                                ),
                                  maxLines: 1,
                                  overflow:TextOverflow.ellipsis,

                                ),
                                SizedBox(width: 30.w,),
                                Text('${getLang(context,'end_at')} :  ',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                      fontFamily: FontConstants.lateefFont,
                                      letterSpacing: 0.004200000017881393,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text('${endDate}',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                      fontFamily: FontConstants.lateefFont,
                                      letterSpacing: 0.004200000017881393,
                                      fontWeight: FontWeight.bold
                                  ),
                                  maxLines: 1,
                                  overflow:TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ):SizedBox.shrink(),

                        isHistory==true?
                        Row(
                          children: <Widget>[
                            SizedBox(width: 100.w,),

                            Text('${getLang(context,'status')}  :  ',
                            style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                                fontFamily: FontConstants.lateefFont,
                                letterSpacing: 0.004200000017881393,
                                fontWeight: FontWeight.bold
                            ),
                            ),
                            Text('${status}',style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                                fontFamily: FontConstants.lateefFont,
                                letterSpacing: 0.004200000017881393,
                                fontWeight: FontWeight.bold
                            ),),
                          ],
                        ):SizedBox.shrink(),
                        SizedBox(height: 30.h,),

                      ],
                    ),
                    Positioned(
                      top: 70.h,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CircleAvatar(
                            radius: 44.sp,
                            child: CircleAvatar(
                              radius: 40.sp,
                              backgroundColor: Color(0xffF9F7EE),
                              child: Text(
                                '${price!}\n ${getLang(context, 'rs')}',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeightManager.bold,
                                    fontFamily: FontConstants.lateefFont,
                                    color: blackColor),
                              ),
                            ),
                            backgroundColor: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          textColor: blackColor,
          iconColor: blackColor,
          tilePadding: EdgeInsets.only(left: 16.w),
          title: SizedBox(
            height: 75.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  ImagesManager.car2,
                  width: 134.w,
                  height: 80,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 11.w),
                FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width*0.35,
                        child: Text(
                          title!,
                          style: TextStyle(
                            fontWeight: FontWeightManager.bold,
                            fontSize: 16.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${price!} ${getLang(context, 'rs')}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: 16.sp,
                          color: Color(0xffDB3022),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
