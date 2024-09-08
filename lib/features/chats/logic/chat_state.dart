part of 'chat_cubit.dart';

class ChatState2 extends Equatable {
  final BaseState state;
  final List<ChatModel> data;
  const ChatState2({
    this.state = BaseState.initial,
    this.data = const [],
  });

  ChatState2 copyWith({
    BaseState? state,
    List<ChatModel>? data,
  }) {
    //dsfsfsdf
    return ChatState2(
      state: state ?? this.state,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [state, data,];

}
 class IncreaseCountState extends ChatState2 {}
