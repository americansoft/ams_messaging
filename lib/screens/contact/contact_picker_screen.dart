import 'package:flutter/material.dart';

class ContactPickerScreen extends StatelessWidget {
  const ContactPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder contact list
    final contacts = [
      {'name': 'Ali', 'status': 'Available'},
      {'name': 'Mona', 'status': 'Busy'},
      {'name': 'Youssef', 'status': 'Let’s catch up later'},
      {'name': 'Sara', 'status': 'At work'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contact'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.group),
            onPressed: () {
              Navigator.pushNamed(context, '/create-group');
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: contacts.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/chat');
            },
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple.shade100,
              child: Text(contact['name']![0]),
            ),
            title: Text(contact['name']!),
            subtitle: Text(contact['status']!),
            trailing: const Icon(Icons.chat),
          );
        },
      ),
    );
  }
}
