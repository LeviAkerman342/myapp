import '../entities/chat_message.dart';

abstract class ChatRepository {
  Stream<List<ChatMessage>> getMessages();
  Future<void> sendMessage(String text);
  Future<void> sendImage(String imageUrl);
}
