import 'package:flutter/material.dart';

class GroupInfoScreen extends StatelessWidget {
  const GroupInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated group data
    final groupName = 'Flutter Devs';
    final groupDescription = 'Sharing code, coffee & bugs ☕🐛';
    final members = [
      {'name': 'Ali', 'isAdmin': true},
      {'name': 'Mona', 'isAdmin': false},
      {'name': 'Youssef', 'isAdmin': false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Info'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Group avatar + name
          Column(
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/images/group_placeholder.png'), // Replace with dynamic source
              ),
              const SizedBox(height: 12),
              Text(
                groupName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                groupDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 30),

          const Text('Participants', style: TextStyle(fontWeight: FontWeight.bold)),
          const Divider(),

          // Members list
          ...members.map((member) {
            return ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(member['name'].toString()),
              subtitle: member['isAdmin'] != null ? const Text('Admin') : null,
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            );
          }),

          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add Members'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
