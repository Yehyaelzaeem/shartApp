// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
//
//
// class Test extends StatefulWidget {
//   const Test({super.key});
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<Test> {
//   List<FocusNode>? focusNodes;
//   List<TextEditingController>? controllers;
//   int currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize focus nodes and controllers
//     focusNodes = List.generate(4, (index) => FocusNode());
//     controllers = List.generate(4, (index) => TextEditingController());
//
//     // Add listener to each controller to detect changes
//     for (int i = 0; i < controllers!.length; i++) {
//       controllers![i].addListener(() {
//         // Check if the current controller is not empty
//         if (controllers![i].text.isNotEmpty) {
//           // Move focus to the next TextField if available
//           if (i < controllers!.length - 1) {
//             FocusScope.of(context).requestFocus(focusNodes![i + 1]);
//           }
//         }
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     // Dispose of controllers and focus nodes to avoid memory leaks
//     for (int i = 0; i < controllers!.length; i++) {
//       controllers![i].dispose();
//       focusNodes![i].dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Auto-play OTP TextField'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: PinCodeTextField(
//
//             appContext: context,
//             length: 6,
//             onChanged: (value) {
//               // Handle OTP input changes
//             },
//             onCompleted: (value) {
//               // Handle OTP input when completed
//             },
//             // You can customize other properties as needed
//             // See the package documentation for more options
//           ),
//         ),
//       ),
//     );
//   }
// }