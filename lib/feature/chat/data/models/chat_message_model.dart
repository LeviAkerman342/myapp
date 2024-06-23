import '../../domain/entities/chat_message.dart';

class ChatMessageModel {
  final int? id;
  final String text;
  final String? imageUrl;
  final String userId;
  final DateTime createdAt;

  ChatMessageModel({
    this.id,
    required this.text,
    this.imageUrl,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'imageUrl': imageUrl,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      id: map['id'],
      text: map['text'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  ChatMessage toEntity() {
    return ChatMessage(
      id: id,
      text: text,
      imageUrl: imageUrl,
      userId: userId,
      createdAt: createdAt,
    );
  }
}
