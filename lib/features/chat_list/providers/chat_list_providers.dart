import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/chat_list_repository.dart';
import '../../../models/chat.dart';

final chatListRepositoryProvider = Provider((ref) => ChatListRepository());

class ChatListNotifier extends AsyncNotifier<List<Chat>> {
  @override
  Future<List<Chat>> build() async {
    final repo = ref.read(chatListRepositoryProvider);
    return await repo.getChats();
  }
}

final chatListProvider = AsyncNotifierProvider<ChatListNotifier, List<Chat>>(
  ChatListNotifier.new,
);
