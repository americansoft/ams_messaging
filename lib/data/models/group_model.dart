class GroupModel {
  late final String groupId;
  late final String name;
  late final String? photoUrl;
  late final bool isPublic;
  late final String createdBy;
  late final List<String> members;
  late final List<String> admins;
  late final String? inviteCode;
  late final String? description;
  late final List<String>? tags;
  late final DateTime createdAt;

// Messages will be a subcollection
}