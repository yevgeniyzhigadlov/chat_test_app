import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../models/chat.dart';
import '../../../chat/presentation/chat_screen.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;

  const ChatListItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final lastMessage = chat.lastMessage;

    void openChat() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ChatScreen(chatId: chat.id)),
      );
    }

    return InkWell(
      onTap: openChat,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Avatar(size: 50, name: chat.name),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chat.name, style: AppTextStyles.name),
                  Row(
                    children: [
                      if (chat.lastMessage?.isMe == true)
                        Text(
                          "Вы: ",
                          style: AppTextStyles.date.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          lastMessage?.text ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.date,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (lastMessage != null)
              SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    DateFormatter.formatDate(lastMessage.createdAt),
                    style: AppTextStyles.date,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
