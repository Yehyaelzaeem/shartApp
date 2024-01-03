import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../../../core/routing/routes.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTextField(
            hintText: 'أدخل اسم المنتج',
            controller: searchController,
            prefixIcon: Icon(Icons.search_sharp, color: Colors.grey.shade400),
            borderColor: Colors.grey.shade300),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: () {
              NavigationManager.push(Routes.providerAddNewProduct);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.add, color: Color(0xff136B79)),
                Text('أضف منتج جديد',
                    style: TextStyle(
                        color: Color(0xff136B79),
                        fontFamily: 'Lateef',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 60.h),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 220.h),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () =>
                      NavigationManager.push(Routes.providerProductDetails),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 130.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: Color(0xffF9F7EE),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/product1.png'))),
                          padding: EdgeInsets.all(10.w),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                  child: CircleAvatar(
                                      radius: 17,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                          Icons.restore_from_trash_outlined,
                                          size: 20,
                                          color: Color(0xffFF3535))),
                                  top: 0,
                                  left: 0),
                              Positioned(
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.edit,
                                        size: 20, color: Color(0xff136B79)),
                                  ),
                                  top: 0,
                                  right: 0),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 16.h, bottom: 5, right: 10, left: 10),
                          child: Text('أسم الماركة',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: Color(0xff6E6D71))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('أسم المنتج',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('300 ر.س',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: Color(0xffDB3022)))),
                        ),
                      ],
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: 8,
            ),
          ),
        )
      ],
    );
  }
}
