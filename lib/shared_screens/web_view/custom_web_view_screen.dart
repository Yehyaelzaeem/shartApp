import 'package:flutter/material.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/localization/appLocale.dart';
import '../../features/user/bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../../features/user/myorders/logic/my_orders_cubit.dart';

class CustomWebView extends StatefulWidget {
  final String title;
  final String selectedUrl;


  CustomWebView({super.key,
    required this.title,
    required this.selectedUrl,
  });

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  // Create a webview controller
  late WebViewController _controller;
 @override
  void initState() {
    _controller = WebViewController()
     ..setJavaScriptMode(JavaScriptMode.unrestricted)
     ..setNavigationDelegate(
       NavigationDelegate(
         onProgress: (int progress) {
           debugPrint('Loading: $progress%');
         },
         onPageStarted: (String url) {
         },
         onPageFinished: (String url)async {
           Map<String, String> responseParams = Uri.parse(url).queryParameters;
           if (responseParams.toString().contains('Successful')) {
             MyOrdersCubit.get(context).getMyOrder(context);
             Navigator.pushAndRemoveUntil(context,
               MaterialPageRoute(builder: (BuildContext context)=>UserBottomNavScreen(checkPage: '2',)), (Route route) => false,);
             showToast(text:getLang(context,'payment_successful'), state: ToastStates.success, context: context);
           }
             debugPrint(' onPageFinished url: $responseParams %');
           },
         onWebResourceError: (WebResourceError error) {},
         onNavigationRequest: (NavigationRequest request) {
           return NavigationDecision.navigate;
         },
       ),
     )
     ..loadRequest(Uri.parse(widget.selectedUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.title,
        style: TextStyles.font12BlackColor700WeightTajawal.copyWith(
          fontFamily: FontConstants.lateefFont,
          fontSize: 25
        ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
          width: double.infinity,
          child:
        WebViewWidget(
        controller: _controller,
      )),

    );
  }
}
