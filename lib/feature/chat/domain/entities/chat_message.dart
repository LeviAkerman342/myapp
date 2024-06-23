class ChatMessage {
  final int? id;
  final String text;
  final String? imageUrl;
  final String userId;
  final DateTime createdAt;

  ChatMessage({
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

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      text: map['text'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
