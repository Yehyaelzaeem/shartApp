import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/features/user/myorders/logic/my_orders_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../data/model/myorder_model.dart';
class InvoiceScreen extends StatefulWidget {
  final MyOrdersModelData myOrdersModelData ;
  const InvoiceScreen({Key? key, required this.myOrdersModelData}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  void initState() {
    MyOrdersCubit cubit =MyOrdersCubit.get(context);
    cubit.getProductData(widget.myOrdersModelData);
    cubit.getInvoice(widget.myOrdersModelData);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    MyOrdersCubit cubit =MyOrdersCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70.h),
          child: CustomAppBar(title: getLang(context, 'bill'), hasBackButton: true)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
                    child: BlocConsumer<MyOrdersCubit, MyOrdersState>(
              listener: (BuildContext context,MyOrdersState state) {},
              builder: (BuildContext context,MyOrdersState state) {
                return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text('#${widget.myOrdersModelData.id}',
                                style:
                                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Align(
                                child: Image.asset(ImagesManager.logoCircle),
                                alignment: Alignment.centerLeft),
                          ),
                          SizedBox(height: 21.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(getLang(context, 'by'),
                                          style: TextStyle(
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                      Padding(
                                        padding: EdgeInsets.only(top: 14.h, bottom: 8.h),
                                        child: Text('${widget.myOrdersModelData.provider!.name}',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff6E6D71))),
                                      ),
                                      Text('${widget.myOrdersModelData.provider!.mainAddress}',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff6E6D71)),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,

                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(getLang(context, 'to'),
                                          style: TextStyle(
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                      Padding(
                                        padding: EdgeInsets.only(top: 14.h, bottom: 8.h),
                                        child: Text('${widget.myOrdersModelData.user!.name}',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff6E6D71))),
                                      ),
                                      Text('${widget.myOrdersModelData.userAddress!.address}',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff6E6D71)),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    children: <Widget>[
                                      Text(getLang(context, 'total_price'),
                                          style: TextStyle(
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                      SizedBox(height: 14.h),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          '${widget.myOrdersModelData.totalPrice} ${getLang(context, 'rs')}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Lateef',
                                            height: 0.8,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff136B79),
                                            minimumSize: Size(75.w, 40.h),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:   EdgeInsets.only(top: 50.h,bottom: 15.h),
                            child: SfDataGrid(
                              verticalScrollPhysics: NeverScrollableScrollPhysics(),
                              horizontalScrollPhysics: BouncingScrollPhysics(),
                              source:cubit.productDataSource!,
                              shrinkWrapRows: true,
                              columnWidthMode: ColumnWidthMode.fill,
                              rowHeight: 80.h,
                              columns: <GridColumn>[
                                GridColumn(
                                    columnName: 'name',
                                    label: Container(
                                        color: primaryColor,
                                        alignment: Alignment.center,
                                        child: Text(getLang(context, 'element'), style: TextStyle(fontFamily: 'Tajawal'),))),
                                GridColumn(
                                    columnName: 'description',
                                    label: Container(
                                        color: primaryColor,
                                        alignment: Alignment.center,
                                        child: Text(getLang(context, 'des'),
                                            style: TextStyle(fontFamily: 'Tajawal')))),
                                GridColumn(
                                    columnName: 'price',
                                    label: Container(
                                        color: primaryColor,
                                        alignment: Alignment.center,
                                        child: Text(getLang(context, 'the_cost'),
                                            style: TextStyle(fontFamily: 'Tajawal')))),
                                GridColumn(
                                    columnName: 'quantity',
                                    label: Container(
                                        color: primaryColor,
                                        alignment: Alignment.center,
                                        child: Text(getLang(context, 'qty2'),
                                            style: TextStyle(fontFamily: 'Tajawal')))),
                                GridColumn(
                                    columnName: 'total',
                                    label: Container(
                                      color: primaryColor,
                                      alignment: Alignment.center,
                                      child: Text(getLang(context, 'total_price'),
                                          style: TextStyle(fontFamily: 'Tajawal')),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding:   EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[

                                Expanded(child:
                                Text('${getLang(context, 'all_price')}',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Color(0xff6E6D71)),textAlign: TextAlign.center,),
                                ),
                                SizedBox(width: 16.w),

                                Text('${getLang(context, 'total')}\n${getLang(context, 'required')}',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Color(0xff6E6D71)),textAlign: TextAlign.center,),
                                SizedBox(width: 16.w),
                                Text('${widget.myOrdersModelData!.totalPrice!}\n ${getLang(context, 'rs')}',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Color(0xff6E6D71)),textAlign: TextAlign.center,),
                              ],
                            ),
                          ),

                          SizedBox(height: 35.h,),
                        ],
                      ),
                    );
              },
            ),
      ),
    );
  }
}




