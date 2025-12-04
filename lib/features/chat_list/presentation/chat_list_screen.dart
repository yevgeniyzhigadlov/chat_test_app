import 'package:chat_test_app/core/widgets/message_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../providers/chat_list_providers.dart';
import 'widgets/chat_list_item.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsAsync = ref.watch(filteredChatListProvider);
    final search = ref.read(searchQueryProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 14, 20, 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Чаты", style: AppTextStyles.title),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.chatGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.search, width: 24, height: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        onChanged: search.set,
                        decoration: const InputDecoration(
                          hintText: 'Поиск',
                          hintStyle: AppTextStyles.search,
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: AppTextStyles.searchFilled,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const MessageDivider(),

            Expanded(
              child: chatsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Ошибка загрузки')),
                data: (chats) => ListView.separated(
                  itemCount: chats.length,
                  separatorBuilder: (_, __) => const Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                    child: MessageDivider(),
                  ),
                  itemBuilder: (_, index) {
                    final chat = chats[index];

                    final isLast = index == chats.length - 1;

                    return Column(
                      children: [
                        ChatListItem(chat: chat),
                        if (isLast)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: MessageDivider(),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
