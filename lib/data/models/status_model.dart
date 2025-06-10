class StatusModel {
  late final String statusId;
  late final String userId;
  late final String mediaType; // text, image, video
  late final String mediaUrl;
  late final DateTime timestamp;
  late final DateTime expiresAt;
  late final List<String> seenBy;
}