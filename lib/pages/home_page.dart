import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini_with_bloc/bloc/chat_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../models/chat_user_model.dart';

class HomePage extends StatelessWidget {
  final ChatUserModel currentUser = ChatUserModel(id: '0', firstName: 'User');

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text("Gemini Chat")),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return DashChat(
              currentUser: currentUser.toChatUser(),
              onSend: (ChatMessage message) {
                context.read<ChatBloc>().add(SendTextMessage(message));
              },
              messages: state.messages.map((m) => m.toChatMessage()).toList(),
              inputOptions: InputOptions(
                trailing: [
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () => _sendMediaMessage(context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _sendMediaMessage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      final message = ChatMessage(
        user: currentUser.toChatUser(),
        createdAt: DateTime.now(),
        text: "deskripsikan gambar tersebut",
        medias: [
          ChatMedia(url: file.path, type: MediaType.image, fileName: file.name)
        ],
      );

      context.read<ChatBloc>().add(SendImageMessage(message));
    }
  }
}
