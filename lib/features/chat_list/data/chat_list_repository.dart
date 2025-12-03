import 'package:chat_test_app/features/chat_list/data/chat_mocks.dart';

import '../../../models/chat.dart';

class ChatListRepository {
  Future<List<Chat>> getChats() async {
    await Future.delayed(const Duration(seconds: 2));
    return chatMocks;
  }
}
