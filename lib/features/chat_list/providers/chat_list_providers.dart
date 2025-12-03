import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/chat.dart';
import '../data/chat_list_repository.dart';

final chatListRepositoryProvider = Provider((ref) {
  return ChatListRepository();
});

class ChatListNotifier extends AsyncNotifier<List<Chat>> {
  @override
  Future<List<Chat>> build() async {
    final repo = ref.read(chatListRepositoryProvider);
    return repo.getChats();
  }
}

final chatListProvider = AsyncNotifierProvider<ChatListNotifier, List<Chat>>(
  ChatListNotifier.new,
);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void set(String val) => state = val;
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

final filteredChatListProvider = Provider<AsyncValue<List<Chat>>>((ref) {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final chats = ref.watch(chatListProvider);

  return chats.whenData((chats) {
    if (query.isEmpty) return chats;

    return chats.where((c) {
      final nameMatch = c.name.toLowerCase().contains(query);

      final messagesMatch = c.messages.any(
        (m) => m.text.toLowerCase().contains(query),
      );

      return nameMatch || messagesMatch;
    }).toList();
  });
});
