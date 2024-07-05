import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:equatable/equatable.dart';

class ChatMessageModel extends Equatable {
  final String text;
  final DateTime createdAt;
  final ChatUser user;
  final List<ChatMedia>? medias;

  const ChatMessageModel({
    required this.text,
    required this.createdAt,
    required this.user,
    this.medias,
  });

  factory ChatMessageModel.fromChatMessage(ChatMessage message) {
    return ChatMessageModel(
      text: message.text,
      createdAt: message.createdAt,
      user: message.user,
      medias: message.medias,
    );
  }

  ChatMessage toChatMessage() {
    return ChatMessage(
      text: text,
      createdAt: createdAt,
      user: user,
      medias: medias,
    );
  }

  @override
  List<Object?> get props => [text, createdAt, user, medias];
}
