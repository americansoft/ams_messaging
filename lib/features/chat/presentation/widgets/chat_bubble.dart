import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isCurrentUser 
              ? Colors.blue[600] 
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMessageContent(),
            const SizedBox(height: 4),
            _buildMessageTime(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent() {
    switch (message.type) {
      case MessageType.text:
        return Text(
          message.content,
          style: TextStyle(
            color: isCurrentUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        );
      case MessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.mediaUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  message.mediaUrl!,
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 200,
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
            if (message.content.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                message.content,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        );
      case MessageType.video:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (message.thumbnailUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        message.thumbnailUrl!,
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 48,
                  ),
                ],
              ),
            ),
            if (message.content.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                message.content,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        );
      case MessageType.audio:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.play_arrow,
              color: isCurrentUser ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 8),
            Text(
              '${message.duration ?? 0}s',
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
          ],
        );
      case MessageType.document:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.description,
              color: isCurrentUser ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 8),
            Text(
              'Document',
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
          ],
        );
      case MessageType.location:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              color: isCurrentUser ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 8),
            Text(
              'Location',
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
          ],
        );
      case MessageType.contact:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person,
              color: isCurrentUser ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 8),
            Text(
              'Contact',
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
          ],
        );
    }
  }

  Widget _buildMessageTime() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat('HH:mm').format(message.timestamp),
          style: TextStyle(
            color: isCurrentUser ? Colors.white70 : Colors.grey[600],
            fontSize: 12,
          ),
        ),
        if (isCurrentUser) ...[
          const SizedBox(width: 4),
          _buildMessageStatus(),
        ],
      ],
    );
  }

  Widget _buildMessageStatus() {
    IconData icon;
    Color color;

    switch (message.status) {
      case MessageStatus.sending:
        icon = Icons.schedule;
        color = Colors.white70;
        break;
      case MessageStatus.sent:
        icon = Icons.check;
        color = Colors.white70;
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = Colors.white70;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = Colors.blue[200]!;
        break;
      case MessageStatus.failed:
        icon = Icons.error;
        color = Colors.red[300]!;
        break;
    }

    return Icon(
      icon,
      size: 16,
      color: color,
    );
  }
} 