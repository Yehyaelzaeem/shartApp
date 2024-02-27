import 'package:flutter/cupertino.dart';

class CustomTitleTabBarWidget extends StatelessWidget {
  const CustomTitleTabBarWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3, // تعديل القيمة حسب عدد الأقسام
        child: Text(title,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
              height: 0.8
          ),
        ),
      ),
    );
  }
}
