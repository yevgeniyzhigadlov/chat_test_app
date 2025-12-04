import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/message_divider.dart';
import '../../../chat/providers/chat_providers.dart';

class MessageInput extends ConsumerStatefulWidget {
  final String chatId;

  const MessageInput({super.key, required this.chatId});

  @override
  ConsumerState<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends ConsumerState<MessageInput> {
  final controller = TextEditingController();

  void send() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    ref.read(sendMessageProvider((widget.chatId, text)));
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MessageDivider(),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 14, 20, 23),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.chatGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    style: AppTextStyles.messageInput,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Сообщение",
                      hintStyle: AppTextStyles.search,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 9,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: send,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.chatGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.send, color: AppColors.chatIcon, size: 24),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
