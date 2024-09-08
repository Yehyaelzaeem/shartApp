import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/features/chats/presentation/widgets/chat_app_bar.dart';
import 'package:shart/features/chats/presentation/widgets/message_card.dart';
import 'package:shart/features/provider/profile/data/model/user_profile_model.dart';
import 'package:shart/features/provider/profile/logic/provider_profile_cubit.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/features/user/profile/logic/user_profile_cubit.dart';
import 'package:shart/widgets/custom_text_field.dart';

import '../../../core/helper/app_dialogs.dart';
import '../../../widgets/custom_loading_widget.dart';
import '../../user/profile/data/model/user_profile_model.dart';
import '../data/models/chat_user.dart';
import '../data/models/message_model.dart';
import '../logic/chat_cubit.dart';


class ChatScreen extends StatefulWidget  {
   ChatUser receiverData;
  final bool isUser;
   ChatScreen({Key? key, required this.receiverData, required this.isUser}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  Timer? timer;
  ChatCubit cubit =ChatCubit.get();

  ChatUser? my;
  @override
  void initState() {
    super.initState();
    cubit.showEmoji=false;
    getUserProfile(widget.receiverData.id);
    cubit.createChat(widget.receiverData);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(widget.isUser){
        UserProfileModel userModel =  BlocProvider.of<UserProfileCubit>(context, listen: false).userProfileModel!;
        ChatUser user=ChatUser(
            image: userModel.data?.image??'',
            about: '',
            name: userModel.data?.name??'',
            createdAt: '',
            isOnline: true,
            id: userModel.data?.id.toString()??'0',
            lastActive: '',
            phone: userModel.data?.phone??'',
            pushToken: '');
            my=user;
           cubit.getSelfInfo(user);
      }else{
        ProviderGetProfileModel providerUserModel =  BlocProvider.of<ProviderProfileCubit>(context, listen: false).providerProfileModel!;
        ChatUser user=ChatUser(
            image: providerUserModel.data?.image??'',
            about: '',
            name: providerUserModel.data?.name??'',
            createdAt: '',
            isOnline: true,
            id: providerUserModel.data?.id.toString()??'0',
            lastActive: '',
            phone: providerUserModel.data?.phone??'',
            pushToken: '');
        cubit.getSelfInfo(user);
        my=user;
      }
    });
  }

  @override
  void dispose() {
    // if (timer != null) timer!.cancel();
    super.dispose();
  }
  ChatUser? receiver;

  void getUserProfile(String id)async{
    receiver=await cubit.getUserInfo(id);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    ChatCubit cubit =ChatCubit.get();
    cubit.getChatRoomName(receiver?.name??widget.receiverData.name??'');
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar:AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace:
        ChatAppBarWidget(user:receiver??widget.receiverData,)
      ),
      body:
     PopScope(
       canPop: true,
       onPopInvoked: (val){
         cubit.getChatRoomName('');
       },
       child:  BlocConsumer<ChatCubit, ChatState2>(
         listener: (BuildContext context, ChatState2 state) {},
         builder: (BuildContext context, ChatState2 state) {
           if(cubit.profile!=null){
             return SafeArea(
               child: Column(
                 children: <Widget>[
                   Expanded(child: _buildMessageList(context)),
                   if (cubit.showEmoji) _buildEmojiPicker(),
                   _buildInputArea(context),
                 ],
               ),
             );
           }else{
             return CustomLoadingWidget();
           }

         },
       ),
     )

    );
  }

  Widget _buildMessageList(BuildContext context) {
   return
     StreamBuilder(
     stream: cubit.getAllMessages(receiver?.id??widget.receiverData.id),
     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
       switch (snapshot.connectionState) {
         case ConnectionState.waiting:
         case ConnectionState.none:
           return CustomLoadingWidget();
         case ConnectionState.active:
         case ConnectionState.done:
           final List<QueryDocumentSnapshot<Map<String, dynamic>>>? data = snapshot.data?.docs;
           cubit.messagesList = data?.map((QueryDocumentSnapshot<Map<String, dynamic>> e) =>
               Message.fromJson(e.data())).toList() ?? <Message>[];
           if (cubit.messagesList.isNotEmpty) {
             return ListView.builder(
                 reverse: true,
                 itemCount: cubit.messagesList.length,
                 padding: EdgeInsets.only(top: 10,left: 10),
                 physics: const BouncingScrollPhysics(),
                 itemBuilder: (BuildContext context, int index) {
                   // return Text('ss');
                   return MessageCard(message: cubit.messagesList[index], isMe:cubit.messagesList[index].fromId == my!.id,);
                 });
           }
           else {
             return const Center(
               child: Text('Say Hii! 👋',
                   style: TextStyle(fontSize: 20)),
             );
           }
       }
     },
   );
  }

  Widget _buildEmojiPicker() {
    return  SizedBox(
      height: 350.h,
      child: EmojiPicker(
        textEditingController: cubit.textController,
        config: const Config(),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return   Padding(
        padding: const EdgeInsets.only(top: 8,bottom: 0),
        child:
        Container(
          color: primaryColor.withOpacity(0.2),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: <Widget>[
              SizedBox(width: 5.0),
              InkWell(
                onTap: (){
                  FocusScope.of(context).unfocus();
                  setState(() => cubit.showEmoji = !cubit.showEmoji);
                },
                child: Icon(Icons.emoji_emotions_outlined,
                  size: 28,
                  color: Colors.grey.shade700,),
              ),
              SizedBox(width: 5.0),
              Expanded(child:
              CustomTextField(
                 onTap: (){
                   cubit.showEmoji=false;
                 },
                  hintText: 'Type a message',
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (String value) {
                    if (cubit.messagesList.isEmpty) {
                      cubit.sendFirstMessage(receiver??widget.receiverData, cubit.textController.text, TypeMessage.text);
                    } else {
                      cubit.sendMessageFirebase(receiver??widget.receiverData, cubit.textController.text, TypeMessage.text);
                    }
                    cubit.textController.text = '';
                  },
                  controller: cubit.textController)),

              SizedBox(width: 8.0),
              InkWell(
                onTap: (){

                  if (cubit.messagesList.isEmpty) {
                    cubit.sendFirstMessage(
                        receiver??widget.receiverData, cubit.textController.text, TypeMessage.text);
                  } else {
                    cubit.sendMessageFirebase(receiver??widget.receiverData, cubit.textController.text, TypeMessage.text);}
                  cubit.textController.text = '';
                },
                child: Icon(Icons.send),
              ),
              SizedBox(width: 5.0),

              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 150,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration:  BoxDecoration(
                            color: primaryColor,
                            boxShadow: [BoxShadow(
                                color: Colors.black45,blurRadius: 7
                            )],
                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                            border: Border.all(color: primaryColor,width: 2),
                          ),
                          height: 25,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 15,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                    onTap:_actionCamera,
                                    child:  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                          border: Border.all(color: primaryColor,width: 2),
                                          boxShadow: [BoxShadow(
                                              color: Colors.black45,blurRadius: 7
                                          )]
                                      ),
                                      height: 100.h,
                                      width: 120.w,
                                      child: Icon(Icons.camera_alt,color: primaryColor,size: 60,),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:_actionGallery ,
                                    child:  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                          border: Border.all(color: primaryColor,width: 2),
                                          boxShadow: [BoxShadow(
                                              color: Colors.black45,blurRadius: 7
                                          )]
                                      ),
                                      height: 100.h,
                                      width: 120.w,
                                      child: Icon(Icons.image,color: primaryColor,size: 60,),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.camera_alt),
              ),
              SizedBox(width: 5.0),

              InkWell(
                onTap: () async {
                  bool status = await AppDialogs().confirm(context, message: getLang(context, 'share_location'));

                  if (status) {
                    LocationPermission checkPermission = await Geolocator.checkPermission();
                    if (checkPermission == LocationPermission.whileInUse || checkPermission == LocationPermission.always) {
                      _getCurrentLocation();
                    } else if (checkPermission == LocationPermission.deniedForever) {
                      AppSnackbar.show(
                        context: context,
                        message: getLang(context, 'location_permission_denied'),
                      );
                    } else {
                      LocationPermission locationPermission = await Geolocator.requestPermission();
                      if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
                        AppSnackbar.show(
                          context: context,
                          message:getLang(context, 'location_permission_denied'),
                        );
                      } else {
                        _getCurrentLocation();
                      }
                    }
                  }
                },
                child: Icon(Icons.location_on),
              ),
              SizedBox(width: 5.0),
            ],
          ),
        )
    );
  }

  void _actionCamera() async {
    Navigator.pop(context);
    XFile? pickedFile = await (ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 10));
    if (pickedFile != null) {
      await cubit.sendChatImage(receiver??widget.receiverData, File(pickedFile.path));
    }
    }

  void _actionGallery() async {
    Navigator.pop(context);
    XFile? pickedFile = await (ImagePicker().pickImage(imageQuality: 10,source:ImageSource.gallery ));
    if (pickedFile != null) {
      await cubit.sendChatImage(receiver??widget.receiverData, File(pickedFile.path));
    }
  }



  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    if (cubit.messagesList.isEmpty) {
      cubit.sendFirstMessage(receiver??widget.receiverData, cubit.textController.text, TypeMessage.location);
    } else {
      cubit.sendMessageFirebase(receiver??widget.receiverData, cubit.textController.text, TypeMessage.text);
    }
    cubit.textController.text = '';
     cubit.sendLocationFirebase(receiver??widget.receiverData,position.latitude.toString(),position.longitude.toString());

  }
}

//delivego-47c93