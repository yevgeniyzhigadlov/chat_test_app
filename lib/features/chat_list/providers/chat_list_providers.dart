import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/chat_list_repository.dart';
import '../../../models/chat.dart';

final chatListRepositoryProvider = Provider((ref) => ChatListRepository());

final chatListProvider = Provider<List<Chat>>((ref) {
  return ref.watch(chatListRepositoryProvider).getChats();
});
