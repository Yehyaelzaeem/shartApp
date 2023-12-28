import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/widgets/custom_app_bar.dart';

class ProviderProductDetailsScreen extends StatefulWidget {
  const ProviderProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProviderProductDetailsScreen> createState() =>
      _ProviderProductDetailsScreenState();
}

class _ProviderProductDetailsScreenState
    extends State<ProviderProductDetailsScreen> {
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
                    InputDecoration(hintText: 'إطارات و جنوط', enabled: false)),
            SizedBox(height: 25.h),
            Text(
              'اسم المنتج',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            TextField(
                decoration: InputDecoration(hintText: 'إطار', enabled: false)),
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
            Text(
              'العرض',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            TextField(
                decoration: InputDecoration(hintText: '5', enabled: false)),
            SizedBox(height: 25.h),
            Text(
              'الإرتفاع',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            TextField(
                decoration: InputDecoration(hintText: '16', enabled: false)),
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
                    InputDecoration(hintText: 'R14 655/165', enabled: false)),
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
                    InputDecoration(hintText: 'مستعمل', enabled: false)),
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
              'هناك حقيقة مثبتة'
              ' منذ زمن طويل وهي أن المحتوى'
              ' المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص .',
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
                  itemCount: 8,
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
                      child: Image.asset(ImagesManager.car2),
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
              '400 ر.س',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 50,)
          ],
        ),
      )),
    );
  }
}
