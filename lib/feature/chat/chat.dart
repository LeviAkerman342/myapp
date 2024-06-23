import 'package:flutter/material.dart';
import 'package:myapp/feature/chat/domain/usecases/get_messages.dart';
import 'package:myapp/feature/chat/domain/usecases/send_image.dart';
import 'package:myapp/feature/chat/domain/usecases/send_message.dart';
import 'package:myapp/feature/chat/widgets/chat_message_list.dart';
import 'package:myapp/feature/chat/widgets/send_message_form.dart';
import 'package:provider/provider.dart';

import 'data/repositories/local_chat_repository.dart';

class ChatScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  ChatScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    print('Building ChatScreen');

    final repository = Provider.of<LocalChatRepository>(context, listen: false);
    if (repository == null) {
      print('LocalChatRepository is null');
    } else {
      print('LocalChatRepository is available: $repository');
    }

    final getMessages = GetMessages(repository);
    final sendMessage = SendMessage(repository);
    final sendImage = SendImage(repository);

    return Scaffold(
      appBar: AppBar(
        title: Text('Чат с ${user['name']}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessageList(getMessages: getMessages),
          ),
          SendMessageForm(
            sendMessage: sendMessage,
            sendImage: sendImage,
          ),
        ],
      ),
    );
  }
}
