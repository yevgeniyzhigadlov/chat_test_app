import 'package:chat_test_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_assets.dart';
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
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: SvgPicture.asset(
                AppAssets.bubbleIn, // message_bubble.svg
                width: 10,
                height: 21,
              ),
            ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
            decoration: BoxDecoration(
              color: isMe ? AppColors.chatGreen : AppColors.chatGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(21),
                topRight: Radius.circular(21),
                bottomLeft: Radius.circular(isMe ? 21 : 0),
                bottomRight: Radius.circular(!isMe ? 21 : 0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(msg.text, style: AppTextStyles.message),
                const SizedBox(width: 15),
                Text(
                  DateFormatter.formatTime(msg.createdAt),
                  style: AppTextStyles.messageDate,
                ),
              ],
            ),
          ),

          if (isMe)
            Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: SvgPicture.asset(
                AppAssets.bubbleOut,
                width: 10,
                height: 21,
              ),
            ),
        ],
      ),
    );
  }
}
