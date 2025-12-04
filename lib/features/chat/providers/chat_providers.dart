import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/chat.dart';
import '../data/chat_repository.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository());

final chatProvider = Provider.family<Chat, String>((ref, chatId) {
  return ref.watch(chatRepositoryProvider).getChat(chatId);
});

final sendMessageProvider = Provider.family<void, (String chatId, String text)>(
  (ref, args) {
    final (chatId, text) = args;
    ref.read(chatRepositoryProvider).sendMessage(chatId, text);
    ref.invalidate(chatProvider(chatId));
  },
);
