import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hey!',
      'isMe': true,
      'time': '9:40 AM',
    },
    {
      'text': 'Hello! How’s it going?',
      'isMe': false,
      'time': '9:41 AM',
    },
    {
      'text': 'Great, just working on the app.',
      'isMe': true,
      'time': '9:42 AM',
    },
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({'text': text, 'isMe': true, 'time':  DateFormat('hh:mm a').format(DateTime.now())});
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final receiverName = 'Ali'; // Example

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(child: Text('A')),
            const SizedBox(width: 8),
            Text(receiverName),
          ],
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Message list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final alignment = msg['isMe'] ? CrossAxisAlignment.end : CrossAxisAlignment.start;
                final bgColor = msg['isMe'] ? Colors.deepPurple.shade100 : Colors.grey.shade300;
                final radius = msg['isMe']
                    ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )
                    : const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                );

                return Column(
                  crossAxisAlignment: alignment,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: bgColor, borderRadius: radius),
                      child: Text(msg['text']),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4, right: 8, left: 8),
                      child: Text(msg['time'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ),
                  ],
                );
              },
            ),
          ),

          // Message input bar
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
