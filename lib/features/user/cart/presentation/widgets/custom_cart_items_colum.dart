import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/cart_cubit.dart';
import 'cart_item_widget.dart';

class CustomCatItemsColumWidget extends StatelessWidget {
  const CustomCatItemsColumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CartCubit cubit =CartCubit.get(context);
    return Column(
      children: <Widget>[
        ...cubit.products.map((e) {
          return Padding(
            padding:  EdgeInsets.only(top: 12.h),
            child: CardItem(e),
          );
        }).toList(),
      ],
    );
  }
}
