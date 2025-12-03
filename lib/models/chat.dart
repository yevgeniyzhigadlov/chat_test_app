import '../models/message.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';

@freezed
abstract class Chat with _$Chat {
  const Chat._();

  const factory Chat({
    required String id,
    required String name,
    @Default([]) List<Message> messages,
  }) = _Chat;

  Message? get lastMessage => messages.isNotEmpty ? messages.last : null;
}
