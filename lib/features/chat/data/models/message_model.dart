import '../../domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.type,
    required super.status,
    required super.timestamp,
    super.mediaUrl,
    super.thumbnailUrl,
    super.duration,
    super.metadata,
  });

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      senderId: message.senderId,
      receiverId: message.receiverId,
      content: message.content,
      type: message.type,
      status: message.status,
      timestamp: message.timestamp,
      mediaUrl: message.mediaUrl,
      thumbnailUrl: message.thumbnailUrl,
      duration: message.duration,
      metadata: message.metadata,
    );
  }

  Message toEntity() {
    return Message(
      id: id,
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      type: type,
      status: status,
      timestamp: timestamp,
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      duration: duration,
      metadata: metadata,
    );
  }
} 