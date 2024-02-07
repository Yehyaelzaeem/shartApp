import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_show_image.dart';

class CustomImageSliderWidget extends StatefulWidget {
  final List<String?> listImage;
  const CustomImageSliderWidget({super.key, required this.listImage,});
  @override
  State<CustomImageSliderWidget> createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomImageSliderWidget> {
  TextEditingController searchController = TextEditingController();
  CarouselController? carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: (){
          showCustomImages(context: context,
              images: widget.listImage);
        },
        child: Column(
          children: <Widget>[
            CarouselSlider(
              carouselController: carouselController,
              items:
              widget.listImage
                  .map((String? e) =>
                  ClipRRect(
                    child: Image.network(
                      e!,
                      fit: BoxFit.cover,
                      width: ScreenUtil().screenWidth ,
                    ),
                  ))
                  .toList(),
              options: CarouselOptions(
                height: 250.h,
                autoPlay: true,
                reverse: true,
                viewportFraction: 1,
                autoPlayAnimationDuration: const Duration(milliseconds: 300),
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              widget.listImage.asMap().entries.map((MapEntry<int, String?> entry) {
                return GestureDetector(
                  onTap: () => carouselController?.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == entry.key
                            ? primaryColor
                            : Colors.black.withOpacity(0.2)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
  }
}
