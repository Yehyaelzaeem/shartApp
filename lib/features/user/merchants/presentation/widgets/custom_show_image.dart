import 'package:flutter/material.dart';

import '../../../../../core/resources/assets_menager.dart';

class FullScreenImageDialog extends StatelessWidget {
  final String imageUrl;

  FullScreenImageDialog( {super.key,required this.imageUrl,});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (BuildContext context,Object error,StackTrace? v){
              return Image.asset(ImagesManager.holder,fit: BoxFit.cover,);
            },
          ),
        ),
      ),
    );
  }
}