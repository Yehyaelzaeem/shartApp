import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/get_products_list_model.dart';
import '../../logic/work_products_cubit.dart';
import '../screens/edit_product_screen.dart';
import '../screens/product_details_screen.dart';

class CustomProductsDisplayWidget extends StatelessWidget {
  final GetProductsModelData getProductsModelData;
  const CustomProductsDisplayWidget({super.key, required this.getProductsModelData});
  @override
  Widget build(BuildContext context) {
    WorkProductsCubit cubit = WorkProductsCubit.get(context);
    return  GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProviderProductDetailsScreen(getProductsModelData: getProductsModelData,))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              )
            ]),
        height: 220.h,
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Color(0xffF9F7EE),
                image: DecorationImage(
                  image:
                  NetworkImage('${getProductsModelData.images![0].image}'),
                ),
              ),
              padding: EdgeInsets.all(10.w),
              child: Stack(
                children: <Widget>[
                  // Positioned(
                  //     child: InkWell(
                  //       onTap:(){
                  //         cubit.deleteProduct(getProductsModelData.id.toString(), context);
                  //       },
                  //       child: CircleAvatar(
                  //           radius: 17,
                  //           backgroundColor: Colors.white,
                  //           child: Icon(
                  //               Icons.restore_from_trash_outlined,
                  //               size: 20,
                  //               color: Color(0xffFF3535))),
                  //     ),
                  //     top: 0,
                  //     left: 0),
                  Positioned(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProviderEditProductScreen(getProductsModelData:  getProductsModelData,)));
                        },
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.edit,
                              size: 20, color: Color(0xff136B79)),
                        ),
                      ),
                      top: 0,
                      right: 0),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 16.h, bottom: 5, right: 10, left: 10),
              child: Text('${getProductsModelData.type}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Color(0xff6E6D71))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('${getProductsModelData.title}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${getProductsModelData.price}  ر.س ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: Color(0xffDB3022)))),
            ),
          ],
        ),
      ),
    );
  }
}
