import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/chats/presentation/widgets/user_details_widget.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/helper/my_date_util.dart';
import '../../data/models/chat_user.dart';
import '../../logic/chat_cubit.dart';


class ChatAppBarWidget extends StatelessWidget {
  final ChatUser? user;
  const ChatAppBarWidget({super.key,  this.user});

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit =ChatCubit.get();
    var mq =MediaQuery.of(context).size;
    return SafeArea(
      child:
      user!=null?
      StreamBuilder(
          stream: cubit.getUserInfoAppBar(user!.id.toString()),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            final List<QueryDocumentSnapshot<Map<String, dynamic>>>? data = snapshot.data?.docs;
            final List<ChatUser> list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
            if(list.isNotEmpty){
              return InkWell(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      UserDetails userDetails =UserDetails(
                        image: list[0].image??'', name: list[0].name??'',
                        phone:list[0].phone??'',
                        status:   list.isNotEmpty
                            ? list[0].isOnline
                            ? 'Online'
                            : MyDateUtil.getLastActiveTime(
                            context: context,
                            lastActive: list[0].lastActive)
                            : MyDateUtil.getLastActiveTime(
                            context: context,
                            lastActive:list[0].lastActive),
                      );
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        backgroundColor: Colors.white,
                        shadowColor:Colors.white,
                        content:Container(
                          height: 500,
                          child:  UserDetailsWidget(userDetails: userDetails),
                        ),
                        // actions: <Widget>[
                        //   TextButton(
                        //     onPressed: () {
                        //       Navigator.pop(context);
                        //     },
                        //     child: const Text('Close'),
                        //   ),
                        // ],
                      );                  },
                  );
                },
                child: Row(
                  children: [
                    //back button
                    IconButton(
                        onPressed: ()  {
                          Navigator.pop(context);
                          cubit.getChatRoomName('');
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded,
                            color: Colors.black54)),

                    //user profile picture
                    Hero(
                      tag: list.isNotEmpty ?list[0].image:user?.image??'',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height * .03),
                        child: CachedNetworkImage(
                          width: mq.height * .05,
                          height: mq.height * .05,
                          fit: BoxFit.cover,
                          imageUrl:
                          list.isNotEmpty ? list[0].image :'',
                          errorWidget: (BuildContext context, String url, Object error) =>
                              CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  radius: 500,
                                  child: Icon(CupertinoIcons.person)),
                        ),
                      ),
                    ),

                    //for adding some space
                    const SizedBox(width: 10),

                    //user name & last seen time
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //user name
                        Text(list.isNotEmpty ? list[0].name : user!.name,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),

                        //for adding some space
                        const SizedBox(height: 2),

                        //last seen time of user
                        Text(
                            list.isNotEmpty
                                ? list[0].isOnline
                                ? 'Online'
                                : MyDateUtil.getLastActiveTime(
                                context: context,
                                lastActive: list[0].lastActive)
                                : MyDateUtil.getLastActiveTime(
                                context: context,
                                lastActive: user!.lastActive),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black54)),
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: InkWell(
                        onTap: (){
                          launchCallPhone(list.isNotEmpty?list[0].phone:user?.phone??'',context);
                        },
                        child: Icon(Icons.call),
                      ),
                    ),
                    SizedBox(width: 20.w,)
                  ],
                ),
              );
            }else{
              return SizedBox();
            }

          }):
          SizedBox(width: 50,)
    );
  }
  Future<void> launchCallPhone(String phoneNumber,context) async {
    Uri telephoneUrl = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(telephoneUrl)) {
      await launchUrl(telephoneUrl);
    } else {
      showToast(text: 'حدث خطأ أثناء الاتصال بالرقم', state: ToastStates.error, context: context);
    }
  }
}
