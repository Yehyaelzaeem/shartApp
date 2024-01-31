// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shart/core/localization/appLocale.dart';
// import '../../core/resources/assets_menager.dart';
// import '../../core/resources/color.dart';
// import '../../widgets/custom_app_bar.dart';
// import '../../widgets/custom_text_field.dart';
//
// class CustomMessagesScreen extends StatelessWidget {
//   const CustomMessagesScreen({super.key, required this.type});
//   final String type;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xffF5F3F3),
//         appBar: PreferredSize(
//           preferredSize: Size(double.infinity, 80.h),
//           child: CustomAppBar(title: '${getLang(context, 'messages')}'),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.only(top: 20, right: 10, left: 10),
//           child: Column(
//             children: <Widget>[
//               ListView.separated(
//                 separatorBuilder: (BuildContext c, int i) {
//                   return SizedBox(height: 20);
//                 },
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (BuildContext ctx, int index) {
//                   return Row(
//                     children: <Widget>[
//                       CircleAvatar(
//                         backgroundImage: AssetImage(ImagesManager.logoCircle),
//                       ),
//                       SizedBox(width: 8),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           SizedBox(
//                             width: ScreenUtil().screenWidth * 0.8,
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text('أحمد محمد'),
//                                 Text(
//                                   'الجمعة 2:20pm',
//                                   style: TextStyle(
//                                       color: Colors.grey.withOpacity(0.5)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(top: 2),
//                             padding: EdgeInsets.only(right: 10.w),
//                             decoration: BoxDecoration(
//                                 color: Color(0xff136B79),
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8),
//                                   bottomLeft: Radius.circular(8),
//                                   bottomRight: Radius.circular(8),
//                                 )),
//                             height: 44.h,
//                             width: MediaQuery.of(context).size.width * 0.8,
//                             child: Align(
//                               alignment: Alignment.centerRight,
//                               child: FittedBox(
//                                 child: Text(
//                                   'أريد صيانة سيارتي في أقرب وقت !',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16.sp,
//                                       fontFamily: 'Lateef'),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   );
//                 },
//                 itemCount: 1,
//                 shrinkWrap: true,
//               ),
//               SizedBox(height: 15.h),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: 0,vertical: 30.h),
//           child: Row(
//             children: <Widget>[
//               SizedBox(width: 20.w),
//               Expanded(
//                 child: CustomTextField(
//                   hintText: '${getLang(context, 'write_message')}',
//                   controller: TextEditingController(),
//                   borderRadius: 30,
//                   borderColor: primaryColor,
//                   prefixIcon: Icon(Icons.attachment_rounded,
//                       color: Colors.grey.withOpacity(0.5)),
//                 ),
//               ),
//               SizedBox(width: 16.w),
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text('${getLang(context, 'send')}',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xffFFDF58),
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                     minimumSize: Size(111.w, 50.h)),
//               ),
//               SizedBox(width: 21.w),
//             ],
//           ),
//         ));
//   }
// }
