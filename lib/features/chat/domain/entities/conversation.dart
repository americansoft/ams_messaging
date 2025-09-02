import 'package:equatable/equatable.dart';
import 'message.dart';

class Conversation extends Equatable {
  final String id;
  final String participant1Id;
  final String participant2Id;
  final Message? lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isGroup;
  final String? groupName;
  final String? groupAvatar;
  final List<String>? groupParticipants;

  const Conversation({
    required this.id,
    required this.participant1Id,
    required this.participant2Id,
    this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isGroup = false,
    this.groupName,
    this.groupAvatar,
    this.groupParticipants,
  });

  @override
  List<Object?> get props => [
        id,
        participant1Id,
        participant2Id,
        lastMessage,
        lastMessageTime,
        unreadCount,
        isGroup,
        groupName,
        groupAvatar,
        groupParticipants,
      ];

  Conversation copyWith({
    String? id,
    String? participant1Id,
    String? participant2Id,
    Message? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    bool? isGroup,
    String? groupName,
    String? groupAvatar,
    List<String>? groupParticipants,
  }) {
    return Conversation(
      id: id ?? this.id,
      participant1Id: participant1Id ?? this.participant1Id,
      participant2Id: participant2Id ?? this.participant2Id,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isGroup: isGroup ?? this.isGroup,
      groupName: groupName ?? this.groupName,
      groupAvatar: groupAvatar ?? this.groupAvatar,
      groupParticipants: groupParticipants ?? this.groupParticipants,
    );
  }
} 