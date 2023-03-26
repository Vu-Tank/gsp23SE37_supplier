part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatFailed extends ChatState {
  final String msg;
  const ChatFailed(this.msg);
  @override
  List<Object> get props => [msg];
}

class ChatSuccess extends ChatState {
  final RoomChat roomChat;
  const ChatSuccess(this.roomChat);
  @override
  // TODO: implement props
  List<Object> get props => [roomChat];
}
