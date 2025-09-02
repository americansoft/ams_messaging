import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/conversation.dart';

class ChatSearchWidget extends StatefulWidget {
  final Function(String) onSearchMessages;
  final Function(String) onSearchConversations;
  final List<Message>? searchResults;
  final List<Conversation>? conversationResults;
  final bool isLoading;

  const ChatSearchWidget({
    super.key,
    required this.onSearchMessages,
    required this.onSearchConversations,
    this.searchResults,
    this.conversationResults,
    this.isLoading = false,
  });

  @override
  State<ChatSearchWidget> createState() => _ChatSearchWidgetState();
}

class _ChatSearchWidgetState extends State<ChatSearchWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query != _currentQuery && query.isNotEmpty) {
      _currentQuery = query;
      widget.onSearchMessages(query);
      widget.onSearchConversations(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search messages and conversations...',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
          autofocus: true,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Messages'),
            Tab(text: 'Conversations'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMessagesTab(),
          _buildConversationsTab(),
        ],
      ),
    );
  }

  Widget _buildMessagesTab() {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_currentQuery.isEmpty) {
      return const Center(
        child: Text(
          'Search for messages to see results here',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    if (widget.searchResults == null || widget.searchResults!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No messages found for "$_currentQuery"',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.searchResults!.length,
      itemBuilder: (context, index) {
        final message = widget.searchResults![index];
        return _buildMessageTile(message);
      },
    );
  }

  Widget _buildConversationsTab() {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_currentQuery.isEmpty) {
      return const Center(
        child: Text(
          'Search for conversations to see results here',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    if (widget.conversationResults == null || widget.conversationResults!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No conversations found for "$_currentQuery"',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.conversationResults!.length,
      itemBuilder: (context, index) {
        final conversation = widget.conversationResults![index];
        return _buildConversationTile(conversation);
      },
    );
  }

  Widget _buildMessageTile(Message message) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Icon(
          _getMessageTypeIcon(message.type),
          color: Colors.blue[600],
        ),
      ),
      title: Text(
        message.content,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'From: ${message.senderId}',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          Text(
            _formatTime(message.timestamp),
            style: TextStyle(color: Colors.grey[500], fontSize: 11),
          ),
        ],
      ),
      trailing: Icon(
        _getMessageTypeIcon(message.type),
        color: Colors.grey[400],
        size: 20,
      ),
      onTap: () {
        // Navigate to the conversation containing this message
        Navigator.pop(context, {
          'type': 'message',
          'messageId': message.id,
          'conversationId': message.receiverId,
        });
      },
    );
  }

  Widget _buildConversationTile(Conversation conversation) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: conversation.isGroup
            ? (conversation.groupAvatar != null
                ? NetworkImage(conversation.groupAvatar!)
                : null)
            : null,
        backgroundColor: conversation.isGroup ? Colors.grey[300] : Colors.blue[100],
               child: conversation.isGroup
           ? null
           : Text(
               (conversation.groupName ?? 'U').substring(0, 1).toUpperCase(),
               style: TextStyle(color: Colors.blue[600]),
             ),
      ),
      title: Text(
        conversation.isGroup
            ? conversation.groupName ?? 'Group'
            : 'Conversation',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (conversation.lastMessage != null)
            Text(
              conversation.lastMessage!.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          Text(
            _formatTime(conversation.lastMessageTime),
            style: TextStyle(color: Colors.grey[500], fontSize: 11),
          ),
        ],
      ),
      trailing: conversation.unreadCount > 0
          ? Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                conversation.unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      onTap: () {
        Navigator.pop(context, {
          'type': 'conversation',
          'conversationId': conversation.id,
        });
      },
    );
  }

  IconData _getMessageTypeIcon(MessageType type) {
    switch (type) {
      case MessageType.text:
        return Icons.message;
      case MessageType.image:
        return Icons.image;
      case MessageType.video:
        return Icons.video_library;
      case MessageType.audio:
        return Icons.audiotrack;
      case MessageType.document:
        return Icons.insert_drive_file;
      case MessageType.location:
        return Icons.location_on;
      case MessageType.contact:
        return Icons.person;
      case MessageType.sticker:
        return Icons.emoji_emotions;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
} 