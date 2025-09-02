import 'package:equatable/equatable.dart';

enum MessageType {
  text,
  image,
  video,
  audio,
  document,
  location,
  contact,
  sticker,
}

enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}

class MessageReaction extends Equatable {
  final String userId;
  final String emoji;
  final DateTime timestamp;

  const MessageReaction({
    required this.userId,
    required this.emoji,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [userId, emoji, timestamp];
}

class Message extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type;
  final MessageStatus status;
  final DateTime timestamp;
  final String? mediaUrl;
  final String? thumbnailUrl;
  final Duration? duration;
  final Map<String, dynamic>? metadata;
  final List<MessageReaction> reactions;
  final List<String> readBy;
  final List<String> deliveredTo;
  final String? replyToMessageId;
  final bool isForwarded;
  final String? forwardedFrom;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.status,
    required this.timestamp,
    this.mediaUrl,
    this.thumbnailUrl,
    this.duration,
    this.metadata,
    this.reactions = const [],
    this.readBy = const [],
    this.deliveredTo = const [],
    this.replyToMessageId,
    this.isForwarded = false,
    this.forwardedFrom,
  });

  Message copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? content,
    MessageType? type,
    MessageStatus? status,
    DateTime? timestamp,
    String? mediaUrl,
    String? thumbnailUrl,
    Duration? duration,
    Map<String, dynamic>? metadata,
    List<MessageReaction>? reactions,
    List<String>? readBy,
    List<String>? deliveredTo,
    String? replyToMessageId,
    bool? isForwarded,
    String? forwardedFrom,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      metadata: metadata ?? this.metadata,
      reactions: reactions ?? this.reactions,
      readBy: readBy ?? this.readBy,
      deliveredTo: deliveredTo ?? this.deliveredTo,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      isForwarded: isForwarded ?? this.isForwarded,
      forwardedFrom: forwardedFrom ?? this.forwardedFrom,
    );
  }

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        content,
        type,
        status,
        timestamp,
        mediaUrl,
        thumbnailUrl,
        duration,
        metadata,
        reactions,
        readBy,
        deliveredTo,
        replyToMessageId,
        isForwarded,
        forwardedFrom,
      ];
} 