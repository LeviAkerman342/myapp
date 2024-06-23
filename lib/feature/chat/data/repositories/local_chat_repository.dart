import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../database_helper.dart';

class LocalChatRepository implements ChatRepository {
  final DatabaseHelper databaseHelper;

  LocalChatRepository(this.databaseHelper);

  @override
  Stream<List<ChatMessage>> getMessages() async* {
    yield await databaseHelper.getMessages();
  }

  @override
  Future<void> sendMessage(String text) async {
    final message = ChatMessage(
      text: text,
      userId: 'user123', // Замените на реальный идентификатор пользователя
      createdAt: DateTime.now(),
    );
    await databaseHelper.insertMessage(message);
  }

  @override
  Future<void> sendImage(String imageUrl) async {
    final message = ChatMessage(
      text: '',
      imageUrl: imageUrl,
      userId: 'user123', // Замените на реальный идентификатор пользователя
      createdAt: DateTime.now(),
    );
    await databaseHelper.insertMessage(message);
  }
}
