import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_gemini_with_bloc/models/chat_message_model.dart';
import 'package:flutter_gemini_with_bloc/models/chat_user_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Gemini gemini = Gemini.instance;

  ChatBloc() : super(ChatState()) {
    on<SendTextMessage>(_onSendTextMessage);
    on<SendImageMessage>(_onSendImageMessage);
  }

  void _onSendTextMessage(
      SendTextMessage event, Emitter<ChatState> emit) async {
    final messageModel = ChatMessageModel.fromChatMessage(event.message);
    emit(state.copyWith(messages: [messageModel, ...state.messages]));
    await _generateResponse(messageModel.text, emit);
  }

  void _onSendImageMessage(
      SendImageMessage event, Emitter<ChatState> emit) async {
    final messageModel = ChatMessageModel.fromChatMessage(event.message);
    emit(state.copyWith(messages: [messageModel, ...state.messages]));
    final imageBytes = File(messageModel.medias!.first.url).readAsBytesSync();
    await _generateResponse(messageModel.text, emit, imageBytes: [imageBytes]);
  }

  Future<void> _generateResponse(String text, Emitter<ChatState> emit,
      {List<Uint8List>? imageBytes}) async {
    emit(state.copyWith(isLoading: true));

    final responseStream = imageBytes != null
        ? gemini.streamGenerateContent(text, images: imageBytes)
        : gemini.streamGenerateContent(text);

    await for (final event in responseStream) {
      final responseText = event.content?.parts?.fold(
            '',
            (previousValue, element) => previousValue + (element.text ?? ''),
          ) ??
          '';

      final updatedMessages = List<ChatMessageModel>.from(state.messages);
      if (updatedMessages.isNotEmpty && updatedMessages.first.user.id == '1') {
        updatedMessages[0] = ChatMessageModel(
          text: updatedMessages[0].text + responseText,
          createdAt: DateTime.now(),
          user: ChatUserModel(id: '1', firstName: 'Gemini').toChatUser(),
        );
      } else {
        updatedMessages.insert(
          0,
          ChatMessageModel(
            text: responseText,
            createdAt: DateTime.now(),
            user: ChatUserModel(id: '1', firstName: 'Gemini').toChatUser(),
          ),
        );
      }

      emit(state.copyWith(messages: updatedMessages, isLoading: false));
    }
  }
}
