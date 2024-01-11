import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/resources/color.dart';
import '../features/user/menu/logic/menu_cubit.dart';

class CustomSliderWidget extends StatefulWidget {
  const CustomSliderWidget({super.key,});
  @override
  State<CustomSliderWidget> createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  TextEditingController searchController = TextEditingController();
  CarouselController? carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit,MenuState>(builder:
        (BuildContext context ,MenuState state){
      MenuCubit c =MenuCubit.get(context);
      if(MenuCubit.get(context).listBanners.isNotEmpty){
        return  Column(
          children: <Widget>[
            CarouselSlider(
              carouselController: carouselController,
              items:
              MenuCubit.get(context).listBanners
                  .map((String e) =>
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      e,
                      fit: BoxFit.fill,
                      width: ScreenUtil().screenWidth - 50,
                    ),
                  ))
                  .toList(),
              options: CarouselOptions(
                height: 163.h,
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
              MenuCubit.get(context).listBanners.asMap().entries.map((MapEntry<int, String> entry) {
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
        );
      }else{
        return Padding(
          padding:  EdgeInsets.all(60.h),
          child: Center(child: CircularProgressIndicator(),),
        );
      }
    },
        listener:  (BuildContext context ,MenuState state){});
  }
}
