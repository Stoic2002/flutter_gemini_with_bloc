part of 'chat_bloc.dart';

class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendTextMessage extends ChatEvent {
  final ChatMessage message;

  const SendTextMessage(this.message);

  @override
  List<Object> get props => [message];
}

class SendImageMessage extends ChatEvent {
  final ChatMessage message;

  const SendImageMessage(this.message);

  @override
  List<Object> get props => [message];
}
