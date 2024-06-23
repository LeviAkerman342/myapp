import '../repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<void> call(String text) async {
    await repository.sendMessage(text);
  }
}
