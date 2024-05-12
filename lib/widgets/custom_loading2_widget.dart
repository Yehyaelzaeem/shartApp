import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/resources/color.dart';

class CustomLoading2Widget extends StatelessWidget {
  final Color? color;
  const CustomLoading2Widget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return   SpinKitCircle(
      color:color?? whiteColor,
      size: 50.0,
    );
  }
}
