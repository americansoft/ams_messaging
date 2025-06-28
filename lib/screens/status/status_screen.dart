import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated status data
    final myStatus = {'name': 'My Status', 'time': 'Just now'};
    final othersStatus = [
      {'name': 'Ali', 'time': '10 minutes ago'},
      {'name': 'Mona', 'time': '1 hour ago'},
      {'name': 'Youssef', 'time': 'Today, 8:00 AM'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Status'),
      ),
      body: ListView(
        children: [
          // My Status
          ListTile(
            leading: Stack(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.deepPurple,
                    child: const Icon(Icons.add, size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
            title: Text(myStatus['name']!),
            subtitle: Text(myStatus['time']!),
            onTap: () {
              // Navigate to create status
              Navigator.pushNamed(context, '/status-editor');
            },
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Recent updates', style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          // Others' statuses
          ...othersStatus.map((status) {
            return ListTile(
              leading: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(status['name']!),
              subtitle: Text(status['time']!),
              onTap: () {
                Navigator.pushNamed(context, '/status-viewer', arguments: status);
              },
            );
          }),
        ],
      ),
    );
  }
}
