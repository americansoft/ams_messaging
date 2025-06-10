import 'package:flutter/material.dart';

import '../../core/utils/helpers.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder chat data
    final chats = [
      {
        'name': 'Ali',
        'lastMessage': 'Hey! How are you?',
        'timestamp': '9:42 AM',
        'unread': true
      },
      {
        'name': 'American Group',
        'lastMessage': 'You: I’ll push the code tonight',
        'timestamp': '8:15 AM',
        'unread': false
      },
      {
        'name': 'Mostafa Hp',
        'lastMessage': 'Thanks for contacting us.',
        'timestamp': 'Yesterday',
        'unread': false
      },
      {
        'name': 'Ahmed Walid',
        'lastMessage': 'Thanks for contacting us.',
        'timestamp': 'Yesterday',
        'unread': false
      },
      {
        'name': 'Mahmoud Elsayed',
        'lastMessage': 'Thanks for contacting us.',
        'timestamp': 'Yesterday',
        'unread': true
      },
      {
        'name': 'Shaban',
        'lastMessage': 'Thanks for contacting us.',
        'timestamp': 'Yesterday',
        'unread': false
      },

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            onTap: () => Navigator.pushNamed(context, '/chat'),
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.deepPurple.shade100,
              child: Text(getInitials(chat['name']!.toString())),
            ),
            title: Text(
              chat['name']!.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(chat['lastMessage']!.toString()),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  chat['timestamp']!.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (chat['unread'] == true)
                  const CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.green,
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.pushNamed(context, '/contacts-picker');
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
