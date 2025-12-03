import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    required String id,
    required String text,
    required DateTime createdAt,
    required bool isMe,
  }) = _Message;
}
