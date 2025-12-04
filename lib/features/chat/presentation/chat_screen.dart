import 'package:chat_test_app/core/theme/app_text_styles.dart';
import 'package:chat_test_app/features/chat/presentation/widgets/date_separator.dart';
import 'package:chat_test_app/features/chat/presentation/widgets/message_bubble.dart';
import 'package:chat_test_app/features/chat/presentation/widgets/message_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/avatar.dart';
import '../providers/chat_providers.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scroll = ScrollController();

  void _scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scroll.hasClients) {
        _scroll.jumpTo(_scroll.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatAsync = ref.watch(chatProvider(widget.chatId));
    _scrollToEnd();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: chatAsync.when(
          loading: () => const Text("Загрузка..."),
          error: (_, __) => const Text("Ошибка"),
          data: (chat) => Row(
            children: [
              Avatar(size: 50, name: chat.name),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chat.name, style: AppTextStyles.name),
                  const Text("В сети", style: AppTextStyles.status),
                ],
              ),
            ],
          ),
        ),
      ),
      body: chatAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка загрузки')),
        data: (chat) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scroll,
                  reverse: true,
                  itemCount: chat.messages.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemBuilder: (_, index) {
                    final reversedIndex = chat.messages.length - 1 - index;
                    final message = chat.messages[reversedIndex];
                    final prev = reversedIndex < chat.messages.length - 1
                        ? chat.messages[reversedIndex + 1]
                        : null;

                    final showDate =
                        prev == null ||
                        prev.createdAt.day != message.createdAt.day ||
                        prev.createdAt.month != message.createdAt.month ||
                        prev.createdAt.year != message.createdAt.year;

                    return Column(
                      children: [
                        if (showDate) DateSeparator(date: message.createdAt),
                        MessageBubble(message: message),
                      ],
                    );
                  },
                ),
              ),
              MessageInput(chatId: widget.chatId),
            ],
          );
        },
      ),
    );
  }
}
