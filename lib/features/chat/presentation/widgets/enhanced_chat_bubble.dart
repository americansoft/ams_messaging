import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';

class EnhancedChatBubble extends StatefulWidget {
  final Message message;
  final bool isCurrentUser;
  final Function(String, String)? onReactionAdded;
  final Function(String, String)? onReactionRemoved;
  final Function(Message)? onReplyTap;
  final Function(Message)? onLongPress;

  const EnhancedChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    this.onReactionAdded,
    this.onReactionRemoved,
    this.onReplyTap,
    this.onLongPress,
  });

  @override
  State<EnhancedChatBubble> createState() => _EnhancedChatBubbleState();
}

class _EnhancedChatBubbleState extends State<EnhancedChatBubble> {
  bool _showReactions = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.onLongPress?.call(widget.message);
        setState(() {
          _showReactions = !_showReactions;
        });
      },
      child: Container(
        margin: EdgeInsets.only(
          left: widget.isCurrentUser ? 50 : 8,
          right: widget.isCurrentUser ? 8 : 50,
          top: 4,
          bottom: 4,
        ),
        child: Column(
          crossAxisAlignment: widget.isCurrentUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (widget.message.replyToMessageId != null)
              _buildReplyPreview(),
            if (widget.message.isForwarded)
              _buildForwardedIndicator(),
            Container(
              constraints: const BoxConstraints(maxWidth: 280),
              decoration: BoxDecoration(
                color: widget.isCurrentUser
                    ? Colors.blue[600]
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMessageContent(),
                  if (widget.message.reactions.isNotEmpty)
                    _buildReactions(),
                  _buildMessageFooter(),
                ],
              ),
            ),
            if (_showReactions) _buildReactionPicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent() {
    switch (widget.message.type) {
      case MessageType.text:
        return _buildTextMessage();
      case MessageType.image:
        return _buildImageMessage();
      case MessageType.video:
        return _buildVideoMessage();
      case MessageType.audio:
        return _buildAudioMessage();
      case MessageType.document:
        return _buildDocumentMessage();
      case MessageType.location:
        return _buildLocationMessage();
      case MessageType.contact:
        return _buildContactMessage();
      case MessageType.sticker:
        return _buildStickerMessage();
    }
  }

  Widget _buildTextMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        widget.message.content,
        style: TextStyle(
          color: widget.isCurrentUser ? Colors.white : Colors.black87,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildImageMessage() {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 250,
        maxHeight: 200,
      ),
                   child: ClipRRect(
               borderRadius: BorderRadius.circular(12),
               child: Image.network(
                 widget.message.mediaUrl!,
                 fit: BoxFit.cover,
                 errorBuilder: (context, error, stackTrace) {
                   return Container(
                     height: 150,
                     color: Colors.grey[300],
                     child: Icon(Icons.broken_image, size: 50),
                   );
                 },
               ),
             ),
    );
  }

  Widget _buildVideoMessage() {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 250,
        maxHeight: 200,
      ),
                   child: ClipRRect(
               borderRadius: BorderRadius.circular(12),
               child: Stack(
                 children: [
                   Image.network(
                     widget.message.thumbnailUrl ?? widget.message.mediaUrl!,
                     fit: BoxFit.cover,
                     errorBuilder: (context, error, stackTrace) {
                       return Container(
                         height: 150,
                         color: Colors.grey[300],
                         child: Icon(Icons.video_library, size: 50),
                       );
                     },
                   ),
                   Center(
                     child: Container(
                       padding: const EdgeInsets.all(8),
                       decoration: BoxDecoration(
                         color: Colors.black.withOpacity(0.5),
                         borderRadius: BorderRadius.circular(20),
                       ),
                       child: const Icon(
                         Icons.play_arrow,
                         color: Colors.white,
                         size: 30,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
    );
  }

  Widget _buildAudioMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.play_arrow,
            color: widget.isCurrentUser ? Colors.white : Colors.blue,
          ),
          const SizedBox(width: 8),
          Container(
            width: 100,
            height: 3,
            color: widget.isCurrentUser ? Colors.white70 : Colors.grey[300],
          ),
          const SizedBox(width: 8),
          Text(
            widget.message.duration?.toString().split('.').first ?? '0:00',
            style: TextStyle(
              color: widget.isCurrentUser ? Colors.white70 : Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.insert_drive_file,
            color: widget.isCurrentUser ? Colors.white : Colors.blue,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              widget.message.content,
              style: TextStyle(
                color: widget.isCurrentUser ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            color: widget.isCurrentUser ? Colors.white : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(
            'Location',
            style: TextStyle(
              color: widget.isCurrentUser ? Colors.white : Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person,
            color: widget.isCurrentUser ? Colors.white : Colors.blue,
          ),
          const SizedBox(width: 8),
          Text(
            'Contact',
            style: TextStyle(
              color: widget.isCurrentUser ? Colors.white : Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickerMessage() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        widget.message.content,
        style: const TextStyle(fontSize: 40),
      ),
    );
  }

  Widget _buildReactions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Wrap(
        spacing: 4,
        children: widget.message.reactions
            .map((reaction) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    reaction.emoji,
                    style: const TextStyle(fontSize: 12),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildMessageFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formatTime(widget.message.timestamp),
            style: TextStyle(
              color: widget.isCurrentUser ? Colors.white70 : Colors.grey[600],
              fontSize: 11,
            ),
          ),
          const SizedBox(width: 4),
          if (widget.isCurrentUser) _buildMessageStatus(),
        ],
      ),
    );
  }

  Widget _buildMessageStatus() {
    IconData icon;
    Color color = Colors.white70;

    switch (widget.message.status) {
      case MessageStatus.sending:
        icon = Icons.schedule;
        break;
      case MessageStatus.sent:
        icon = Icons.done;
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = Colors.blue[200]!;
        break;
      case MessageStatus.failed:
        icon = Icons.error;
        color = Colors.red[200]!;
        break;
    }

    return Icon(icon, size: 16, color: color);
  }

  Widget _buildReplyPreview() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 30,
            color: Colors.blue,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Reply to message',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForwardedIndicator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            Icons.forward,
            size: 14,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            'Forwarded',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionPicker() {
    final reactions = ['👍', '❤️', '😂', '😮', '😢', '😡'];

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: reactions
            .map((emoji) => GestureDetector(
                  onTap: () {
                    widget.onReactionAdded?.call(widget.message.id, emoji);
                    setState(() {
                      _showReactions = false;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
} 