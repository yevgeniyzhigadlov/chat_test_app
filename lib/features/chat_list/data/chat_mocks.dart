import '../../../models/chat.dart';
import '../../../models/message.dart';

final chatMocks = [
  Chat(
    id: "1",
    name: "Олжас Ахметов",
    messages: [
      Message(
        id: "m1",
        text: "Привет",
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        isMe: false,
        status: MessageStatus.read,
      ),
    ],
  ),
  Chat(
    id: "2",
    name: "Катя Иванова",
    messages: [
      Message(
        id: "m21",
        text: "А когда?",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isMe: true,
        status: MessageStatus.read,
      ),
    ],
  ),
  Chat(
    id: "3",
    name: "Служба Поддержки",
    messages: [
      Message(
        id: "m31",
        text: "Здравствуйте!",
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        isMe: false,
        status: MessageStatus.read,
      ),
    ],
  ),
];
