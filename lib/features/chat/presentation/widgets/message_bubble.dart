import 'package:chat_test_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message msg;
  const MessageBubble({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    final isMe = msg.isMe;
    return Align(
      alignment:
      isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.chatGreen : AppColors.chatGrey,
          borderRadius: BorderRadius.circular(21),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              msg.text,
              style: AppTextStyles.message,
            ),
            const SizedBox(width: 15),
            Text(
              DateFormatter.formatTime(msg.createdAt),
              style: AppTextStyles.messageDate,
            ),
          ],
        ),
      ),
    );
  }
}
