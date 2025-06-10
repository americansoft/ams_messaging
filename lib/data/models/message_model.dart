class MessageModel {
  late final String messageId;
  late final String senderId;
  late final String text;
  late final String? mediaUrl;
  late final String mediaType; // text, image, audio, video
  late final DateTime timestamp;
  late final String status; // sent, delivered, read
  late final String? replyTo;
  late final bool forwarded;
  late final List<String>? seenBy; // for group chats

// Firestore subcollection
}