import 'package:chat_test_app/features/chat_list/data/chat_mocks.dart';

import '../../../models/chat.dart';

class ChatListRepository {
  Future<List<Chat>> getChats() async {
    //Loading delay
    //await Future.delayed(const Duration(milliseconds: 500));
    return chatMocks;
  }
}
