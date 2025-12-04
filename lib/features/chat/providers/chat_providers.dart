import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/chat.dart';
import '../data/chat_repository.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository();
});

final chatProvider = FutureProvider.family<Chat, String>((ref, chatId) {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.getChat(chatId);
});

final sendMessageProvider =
FutureProvider.family<void, (String chatId, String text)>((ref, args) {
  final (chatId, text) = args;
  final repo = ref.watch(chatRepositoryProvider);
  repo.sendMessage(chatId, text);
  ref.invalidate(chatProvider(chatId));
});
