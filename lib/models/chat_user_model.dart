import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:equatable/equatable.dart';

class ChatUserModel extends Equatable {
  final String id;
  final String firstName;
  final String? lastName;
  final String? profileImage;

  const ChatUserModel({
    required this.id,
    required this.firstName,
    this.lastName,
    this.profileImage,
  });

  factory ChatUserModel.fromChatUser(ChatUser user) {
    return ChatUserModel(
      id: user.id,
      firstName: user.firstName ?? '',
      lastName: user.lastName,
      profileImage: user.profileImage,
    );
  }

  ChatUser toChatUser() {
    return ChatUser(
      id: id,
      firstName: firstName,
      lastName: lastName,
      profileImage: profileImage,
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, profileImage];
}
