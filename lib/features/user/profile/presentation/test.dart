// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shart/features/user/profile/logic/user_profile_cubit.dart';
//
// class TestHome extends StatelessWidget {
//   const TestHome({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<UserProfileCubit ,UserProfileState>(
//         builder: (BuildContext context ,UserProfileState state){
//           if(state is UserProfileInitial){
//             return Center(child: Text('No Data Now'),);
//           }
//           else if(state is GetUserProfileTestState)
//           {
//             final date = state.userProfileModel;
//             return Center(child: Text('${date.data!.name}'),);
//           }else{
//             return Center(child: Text('Error States'),);
//
//           }
//         },
//       ),
//     );
//   }
// }
