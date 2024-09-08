import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../data/model/myorder_model.dart';
import '../screens/invoice_screen.dart';
import '../screens/order_details.dart';

InkWell buildCurrentOrder(List<Items> item,MyOrdersModelData myOrdersModelData ,String status,BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context)=>OrderDetailsScreen(myOrdersModelData: myOrdersModelData,)));
      // NavigationManager.push(Routes.orderDetails);
    },
    child: Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10),),
            child: Container(
                padding: const EdgeInsets.all(8.0),
                width: 134.w,
                height: 115.h,
                decoration: BoxDecoration(color: packagesColor,
                  borderRadius: BorderRadius.all(Radius.circular(10),),
                ),
                child: Image.network(myOrdersModelData.items?[0].providerProduct?.images!=null&&myOrdersModelData.items?[0].providerProduct?.images!.length !=0 && myOrdersModelData.items?[0].providerProduct?.images![0].image!=null?
                myOrdersModelData.items![0].providerProduct!.images![0].image!:'',
                  errorBuilder: (BuildContext context,Object error ,StackTrace? v){
                    return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10),),
                        child: Image.asset(ImagesManager.holder));
                  },
                )
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5.h,),
                Row(
                  children: <Widget>[
                    Text('${getLang(context, 'order_number')} : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${myOrdersModelData.id!.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: blackTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('${getLang(context, 'store_name')} : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${myOrdersModelData.provider!=null?myOrdersModelData.provider!.name!:''}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: blackTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('${getLang(context, 'status')} : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${getLang(context, '${myOrdersModelData.status!}')}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: blackTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('${getLang(context, 'total_price')} : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${myOrdersModelData.totalPrice!} ${getLang(context, 'rs')}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: Colors.red,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if(status=='accepted'&&myOrdersModelData.paymentStatus=='paid')
                  Row(
                    children: <Widget>[
                      Spacer(),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '${getLang(context, 'paid')}',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: FontConstants.lateefFont,
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                        alignment: AuthCubit.get(context).localeLanguage==Locale('en')?Alignment.bottomRight:Alignment.bottomLeft,
                        child:
                        InkWell(
                          onTap: (){

                          },
                          child: Card(
                            margin: EdgeInsets.zero,
                            color: primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8,right: 8,top: 0,bottom: 0),
                              child: Text(
                                '${getLang(context, '${status}')}',
                                style: TextStyle(
                                  fontFamily: FontConstants.lateefFont,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                            ),
                          ),
                        )

                    ),
                  ),
                SizedBox(height: 5.h,),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

InkWell buildOrderWithInvoice(List<Items> item,MyOrdersModelData myOrdersModelData,String status,BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context)=>OrderDetailsScreen(myOrdersModelData: myOrdersModelData,)));
    },
    child: Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10),),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 134.w,
                  height: 115.h,
                  decoration: BoxDecoration(color: packagesColor,
                    borderRadius: BorderRadius.all(Radius.circular(10),),
                  ),
                  child: Image.network(myOrdersModelData.items![0].providerProduct!.images![0].image!=null?
                  myOrdersModelData.items![0].providerProduct!.images![0].image!:'',
                    errorBuilder: (BuildContext context,Object error ,StackTrace? v){
                    return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10),),
                        child: Image.asset(ImagesManager.holder));
                    },
                  )
                ),
              ),
              SizedBox(width: 5.w),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('${getLang(context, 'order_number')} : ',
                          style: TextStyle(
                            fontWeight: FontWeightManager.light,
                            fontSize: 12.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${myOrdersModelData.id!.toString()}',
                            style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: 12.sp,
                              color: blackTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('${getLang(context, 'store_name')} : ',
                          style: TextStyle(
                            fontWeight: FontWeightManager.light,
                            fontSize: 12.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${myOrdersModelData.provider!=null?myOrdersModelData.provider!.name!:''}',
                            style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: 12.sp,
                              color: blackTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('${getLang(context, 'status')} : ',
                          style: TextStyle(
                            fontWeight: FontWeightManager.light,
                            fontSize: 12.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${getLang(context, '${myOrdersModelData.status!}')}',
                            style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: 12.sp,
                              color: blackTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('${getLang(context, 'total_price')} : ',
                          style: TextStyle(
                            fontWeight: FontWeightManager.light,
                            fontSize: 12.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${myOrdersModelData.totalPrice!} ${getLang(context, 'rs')}',
                            style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: 12.sp,
                              color: Colors.red,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(
              //         item[0].providerProduct!.brand!=null?item[0].providerProduct!.brand!.name!:'',
              //         style: TextStyle(
              //           fontWeight: FontWeightManager.light,
              //           fontSize: 12.sp,
              //           color: Colors.grey.shade700,
              //         ),
              //         maxLines: 1,
              //         overflow: TextOverflow.ellipsis,
              //       ),
              //       Text(
              //         item[0].providerProduct!.title!,
              //         style: TextStyle(
              //           fontWeight: FontWeightManager.bold,
              //           fontSize: 16.sp,
              //         ),
              //         maxLines: 3,
              //         overflow: TextOverflow.ellipsis,
              //       ),
              //       Text(
              //         item[0].provider!.name!,
              //         style: TextStyle(
              //           fontWeight: FontWeightManager.regular,
              //           fontSize: 16.sp,
              //         ),
              //         maxLines: 1,
              //         overflow: TextOverflow.ellipsis,
              //       ),
              //       SizedBox(height: 10),
              //       Text(
              //         '${item[0].providerProduct!.price!} ${getLang(context, 'rs')}',
              //         style: TextStyle(
              //           fontWeight: FontWeightManager.regular,
              //           fontSize: 16.sp,
              //           color: Color(0xffDB3022),
              //         ),
              //       )
              //     ],
              //   ),
              // ),



            ],
          ),
          AuthCubit.get(context).localeLanguage==Locale('en')?
          Positioned(
            right: 10,
            bottom: 10,
            child:
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>InvoiceScreen(myOrdersModelData: myOrdersModelData,)));
                    // NavigationManager.push(Routes.invoice);
                  },
                  child: Text('${getLang(context, 'view_invoice')}',
                      style: TextStyle(fontSize: 12)),
                ),
                Container(
                    width: 80.w,
                    height: 1,
                    color: Colors.black,
                    margin: EdgeInsets.only(top: 5, bottom: 30)),
                Card(
                  margin: EdgeInsets.zero,
                  color: Color(0xff136B79).withOpacity(0.5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 5),
                    child: Center(
                      child: Text(
                        '${getLang(context, '${status}')}',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ):
          Positioned(
            left: 10,
            bottom: 10,
            child:
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>InvoiceScreen(myOrdersModelData: myOrdersModelData,)));

                    // NavigationManager.push(Routes.invoice);
                  },
                  child: Text('${getLang(context, 'view_invoice')}',
                      style: TextStyle(fontSize: 12)),
                ),
                Container(
                    width: 80.w,
                    height: 1,
                    color: Colors.black,
                    margin: EdgeInsets.only(top: 5, bottom: 30)),
                Card(
                  margin: EdgeInsets.zero,
                  color: Color(0xff136B79).withOpacity(0.7),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 3,bottom: 2),
                    child: Center(
                      child: Text(
                        '${getLang(context, '${status}')}',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   child: Container(
          //     margin: EdgeInsets.only(left: 10.w, right: 16.w, top: 50.h),
          //     child:
          //     Column(
          //       children: <Widget>[
          //         InkWell(
          //           onTap: () {
          //             NavigationManager.push(Routes.invoice);
          //           },
          //           child: Text('مشاهدة الفاتورة',
          //               style: TextStyle(fontSize: 12)),
          //         ),
          //         Container(
          //             width: 80.w,
          //             height: 1,
          //             color: Colors.black,
          //             margin: EdgeInsets.only(top: 5, bottom: 30)),
          //         Card(
          //           margin: EdgeInsets.zero,
          //           color: Color(0xff136B79),
          //           elevation: 0,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(50.r)),
          //           child: Padding(
          //             padding: const EdgeInsets.only(left: 8,right: 8),
          //             child: Text(
          //               'تم التوصيل',
          //               style: TextStyle(
          //                 color: whiteColor,
          //                 fontSize: 12.sp,
          //                 fontWeight: FontWeightManager.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   left: 0,
          //   bottom: 15,
          // )
        ],
      ),
    ),
  );
}

InkWell buildCancelledOrder(List<Items> item,MyOrdersModelData myOrdersModelData,String status,BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context)=>OrderDetailsScreen(myOrdersModelData: myOrdersModelData,)));
      // NavigationManager.push(Routes.orderDetails);
    },
    child: Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10),),
            child: Container(
                padding: const EdgeInsets.all(8.0),
                width: 134.w,
                height: 115.h,
                decoration: BoxDecoration(color: packagesColor,
                  borderRadius: BorderRadius.all(Radius.circular(10),),
                ),
                child: Image.network(myOrdersModelData.items![0].providerProduct!.images![0].image!=null?
                myOrdersModelData.items![0].providerProduct!.images![0].image!:'',
                  errorBuilder: (BuildContext context,Object error ,StackTrace? v){
                    return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10),),
                        child: Image.asset(ImagesManager.holder));
                  },
                )
            ),
          ),

          SizedBox(width: 5.w),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('${getLang(context, 'order_number')} : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${myOrdersModelData.id!.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: blackTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('${getLang(context, 'store_name')} : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${myOrdersModelData.provider!=null?myOrdersModelData.provider!.name!:''}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: blackTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('${getLang(context, 'status')} : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${getLang(context, '${myOrdersModelData.status!}')}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: blackTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('${getLang(context, 'total')} : ',
                      style: TextStyle(
                        fontWeight: FontWeightManager.light,
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${myOrdersModelData.totalPrice!} ${getLang(context, 'rs')}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12.sp,
                          color: Colors.red,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
               Padding(
                 padding:EdgeInsets.symmetric(horizontal: 10.0),
                 child: Container(
                   alignment: AuthCubit.get(context).localeLanguage==Locale('en')?Alignment.bottomRight:Alignment.bottomLeft,
                   child:
                   Card(
                     margin: EdgeInsets.zero,
                     color: Color(0xffFF0000),
                     elevation: 0,
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(50.r)),
                     child: Padding(
                       padding: const EdgeInsets.only(left: 8,right: 8,top: 0,bottom: 0),
                       child: Text(
                         '${getLang(context, '${status}')}',
                         style: TextStyle(
                           color: whiteColor,
                           fontFamily: FontConstants.lateefFont,
                           fontSize: 15.sp,
                           fontWeight: FontWeightManager.bold,
                         ),
                       ),
                     ),
                   )
                 ),
               )
              ],
            ),
          ),

        ],
      ),
    ),
  );
}