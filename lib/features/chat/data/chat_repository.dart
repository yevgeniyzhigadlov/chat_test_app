import 'package:chat_test_app/features/chat_list/data/chat_mocks.dart';

import '../../../models/chat.dart';
import '../../../models/message.dart';

class ChatRepository {
  Future<Chat> getChat(String chatId) async {
    //Loading delay
    //await Future.delayed(const Duration(milliseconds: 500));
    return chatMocks.firstWhere((c) => c.id == chatId);
  }

  void sendMessage(String chatId, String text) {
    final index = chatMocks.indexWhere((c) => c.id == chatId);
    if (index == -1) return;

    final chat = chatMocks[index];
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      createdAt: DateTime.now(),
      isMe: true,
    );

    chatMocks[index] = chat.copyWith(messages: [...chat.messages, newMessage]);
  }
}
