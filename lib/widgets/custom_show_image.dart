import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                );
              },
              itemCount:  images.length,
              loadingBuilder: (BuildContext context, ImageChunkEvent? event) => Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null ? 0 : event.cumulativeBytesLoaded /
                        event.expectedTotalBytes!,
                  ),
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
