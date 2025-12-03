import '../../../models/chat.dart';
import 'chat_mocks.dart';

class ChatListRepository {
  List<Chat> getChats() {
    return chatMocks;
  }
}
