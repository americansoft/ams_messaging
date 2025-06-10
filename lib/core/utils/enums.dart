enum MessageStatus { sent, delivered, read }

enum UserStatus { online, offline, away, busy }

enum MediaType { text, image, video, audio, document }



extension MessageStatusExt on MessageStatus {
  String get label => toString().split('.').last;
}

extension MediaTypeExt on MediaType {
  String get label => toString().split('.').last;
}
