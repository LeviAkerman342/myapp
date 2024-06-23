import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/feature/chat/domain/usecases/send_image.dart';
import 'dart:io';

import 'package:myapp/feature/chat/domain/usecases/send_message.dart';


class SendMessageForm extends StatefulWidget {
  final SendMessage sendMessage;
  final SendImage sendImage;

  const SendMessageForm({super.key, 
    required this.sendMessage,
    required this.sendImage,
  });

  @override
  _SendMessageFormState createState() => _SendMessageFormState();
}

class _SendMessageFormState extends State<SendMessageForm> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: () async {
              final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                final file = File(pickedFile.path);
                await widget.sendImage(file.path);
              }
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Написать...'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              await widget.sendMessage(_controller.text);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
