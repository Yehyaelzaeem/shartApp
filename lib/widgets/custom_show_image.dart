import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'custom_video_player.dart';

void showCustomImages({required BuildContext context, required List<String?> images}){
  Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
        PageController imagePageController =
        PageController();
        return Stack(
          children: [
            PhotoViewGallery.builder(
              pageController: imagePageController,
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider( images[index]!),
                  initialScale: PhotoViewComputedScale.covered,
                  heroAttributes: PhotoViewHeroAttributes(
                      tag: images[index]!),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered,
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    // Return a custom widget to display when image loading fails
                    return Material(
                      child:
                      VideoPlayerWidget(videoUrl: images[index]!)
                      // Image.asset(
                      //   AppImages.video,
                      //   width: double.infinity,
                      //   height: double.infinity,// Path to your custom error image
                      // ),
                    );
                  },
                );
              },
              itemCount:  images.length,
              loadingBuilder: (BuildContext context, ImageChunkEvent? event) => Center(
                child:

                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.asset(ImagesManager.holder,fit: BoxFit.cover,),
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: event == null ? 0 : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: imagePageController,
                count:  images.length,
                effect: SlideEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.white,
                    dotColor:
                    Colors.white.withOpacity(0.3)),
                onDotClicked: (int index) =>
                    imagePageController.animateToPage(
                        index,
                        duration:
                        Duration(milliseconds: 250),
                        curve: Curves.ease),
              ),
            ),
          ],
        );
      }));
}
