part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<ChatMessageModel> messages;
  final bool isLoading;
  final bool isTyping;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.isTyping = false,
  });

  ChatState copyWith({
    List<ChatMessageModel>? messages,
    bool? isLoading,
    bool? isTyping,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  List<Object> get props => [messages, isLoading, isTyping];
}

final class ChatInitial extends ChatState {}
