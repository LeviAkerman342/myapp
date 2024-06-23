import '../repositories/chat_repository.dart';

class SendImage {
  final ChatRepository repository;

  SendImage(this.repository);

  Future<void> call(String imageUrl) async {
    await repository.sendImage(imageUrl);
  }
}
