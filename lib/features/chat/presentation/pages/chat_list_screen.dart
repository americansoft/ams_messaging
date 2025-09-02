import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/chat_bloc.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import 'chat_conversation_page.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadConversations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ConversationsLoaded) {
            return _buildConversationsList(state.conversations);
          } else if (state is ChatError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading conversations',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No conversations'));
        },
      ),
    );
  }

  Widget _buildConversationsList(List<Conversation> conversations) {
    if (conversations.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return _ConversationTile(
          conversation: conversation,
          onTap: () => _navigateToConversation(conversation),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No conversations yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start a conversation with your friends',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  void _navigateToConversation(Conversation conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatConversationPage(),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const _ConversationTile({
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isGroup = conversation.isGroup;
    final displayName = isGroup 
        ? conversation.groupName ?? 'Group'
        : 'User'; // You would get the actual user name here
    final avatarUrl = isGroup 
        ? conversation.groupAvatar 
        : 'https://via.placeholder.com/50'; // You would get the actual user avatar here

    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(avatarUrl ?? 'https://via.placeholder.com/50'),
            onBackgroundImageError: (exception, stackTrace) {
              // Handle image loading error
            },
          ),
          if (conversation.unreadCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Text(
                  conversation.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        displayName,
        style: TextStyle(
          fontWeight: conversation.unreadCount > 0 
              ? FontWeight.bold 
              : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        _getLastMessageText(conversation.lastMessage),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: conversation.unreadCount > 0 
              ? Colors.black87 
              : Colors.grey[600],
          fontWeight: conversation.unreadCount > 0 
              ? FontWeight.w500 
              : FontWeight.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatTime(conversation.lastMessageTime),
            style: TextStyle(
              fontSize: 12,
              color: conversation.unreadCount > 0 
                  ? Colors.black87 
                  : Colors.grey[500],
              fontWeight: conversation.unreadCount > 0 
                  ? FontWeight.w500 
                  : FontWeight.normal,
            ),
          ),
          if (conversation.unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
      onTap: onTap,
    );
  }

  String _getLastMessageText(Message? lastMessage) {
    if (lastMessage == null) return 'No messages yet';
    
    switch (lastMessage.type) {
      case MessageType.text:
        return lastMessage.content;
      case MessageType.image:
        return '📷 Image';
      case MessageType.video:
        return '🎥 Video';
      case MessageType.audio:
        return '🎵 Audio';
      case MessageType.document:
        return '📄 Document';
      case MessageType.location:
        return '📍 Location';
      case MessageType.contact:
        return '👤 Contact';
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return DateFormat('MMM d').format(time);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
} 