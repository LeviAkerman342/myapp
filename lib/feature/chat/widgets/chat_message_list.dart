import 'package:flutter/material.dart';
import 'package:myapp/feature/chat/domain/entities/chat_message.dart';
import 'package:myapp/feature/chat/domain/usecases/get_messages.dart';

class ChatMessageList extends StatelessWidget {
  final GetMessages getMessages;

  const ChatMessageList({required this.getMessages});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatMessage>>(
      stream: getMessages.call(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No messages yet.'));
        }
        final messages = snapshot.data!;
        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return ListTile(
              leading: message.imageUrl != null
                  ? Image.network(message.imageUrl!)
                  : null,
              title: Text(message.text),
              subtitle: Text(message.userId),
            );
          },
        );
      },
    );
  }
}
