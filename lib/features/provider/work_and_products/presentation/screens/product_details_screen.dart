import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../data/model/get_products_list_model.dart';

class ProviderProductDetailsScreen extends StatelessWidget {
  const ProviderProductDetailsScreen({Key? key, required this.getProductsModelData}) : super(key: key);
  final GetProductsModelData getProductsModelData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(
          title: 'تفاصيل المنتج',
          hasBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
        margin: EdgeInsets.only(top: 24.h),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffD0D5DD)),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'النوع',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            TextField(
                decoration:
                    InputDecoration(hintText: '${getProductsModelData.type}', enabled: false)),
            SizedBox(height: 25.h),
            Text(
              'اسم المنتج',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            TextField(
                decoration: InputDecoration(hintText: '${getProductsModelData.title}', enabled: false)),
            SizedBox(height: 25.h),
            Text(
              'الماركة',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            TextField(
                decoration: InputDecoration(hintText: 'CEAT', enabled: false)),
            SizedBox(height: 25.h),
            getProductsModelData.type!='spare_parts'?
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 'العرض',
                 style: TextStyle(
                     fontSize: 14.sp,
                     fontFamily: 'Lateef',
                     fontWeight: FontWeight.w500),
               ),
               TextField(
                   decoration: InputDecoration(hintText: '${getProductsModelData.width}', enabled: false)),
               SizedBox(height: 25.h),
               Text(
                 'الإرتفاع',
                 style: TextStyle(
                     fontSize: 14.sp,
                     fontFamily: 'Lateef',
                     fontWeight: FontWeight.w500),
               ),
               TextField(
                   decoration: InputDecoration(hintText: '${getProductsModelData.height}', enabled: false)),
               SizedBox(height: 25.h),
               Text(
                 'المقاس',
                 style: TextStyle(
                     fontSize: 14.sp,
                     fontFamily: 'Lateef',
                     fontWeight: FontWeight.w500),
               ),
               TextField(
                   decoration:
                   InputDecoration(hintText: '${getProductsModelData.size}', enabled: false)),
             ],
           ):SizedBox.shrink(),
            SizedBox(height: 25.h),
            Text(
              'الحالة',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            TextField(
                decoration:
                    InputDecoration(hintText: '${getProductsModelData.productStatus}', enabled: false)),
            Padding(
              padding: EdgeInsets.only(top: 25.h, bottom: 10.h),
              child: Text(
                'الوصف',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
             '${getProductsModelData.description}',
              style: TextStyle(
                color: Color(0xff4B4B4B),
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              'صور الجنط',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                  itemCount: getProductsModelData.images!.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: index != 0 ? 4 : 0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Image.network('${getProductsModelData.images![index].image}'),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.h, bottom: 10.h),
              child: Text(
                'سعر الجنط',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              '${getProductsModelData.price}  ر.س',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 50,)
          ],
        ),
      )),
    );
  }
}
