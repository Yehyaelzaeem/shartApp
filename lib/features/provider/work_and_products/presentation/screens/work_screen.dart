import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shart/core/resources/assets_menager.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({Key? key}) : super(key: key);

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'صور و فيديوهات المتجر',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                fontFamily: 'Lateef',
              ),
            ),
            InkWell(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.add, color: Color(0xff136B79)),
                  Text('أضف عمل أخر',
                      style: TextStyle(
                          color: Color(0xff136B79),
                          fontFamily: 'Lateef',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 65.h),
            child: GridView.builder(
              itemCount: 5,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext context, int index) => Container(
                  width: 81.w,
                  height: 69.h,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImagesManager.sawabImg),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      margin: EdgeInsets.only(top: 8, left: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(Icons.restore_from_trash_outlined,
                              size: 25, color: Color(0xffFF3535))))),
            ),
          ),
        ),
      ],
    );
  }
}
