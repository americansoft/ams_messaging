import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          // User profile header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Your Name',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 4),
                    Text('Hey there! I’m using WhatsClone.'),
                  ],
                ),
              ],
            ),
          ),

          const Divider(),

          // Settings options
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account'),
            subtitle: const Text('Privacy, security, number'),
            onTap: () {
              Navigator.pushNamed(context, '/account-settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chats'),
            subtitle: const Text('Themes, wallpapers, chat history'),
            onTap: () {
              Navigator.pushNamed(context, '/chat-settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Message, group & call tones'),
            onTap: () {
              Navigator.pushNamed(context, '/notification-settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.data_usage),
            title: const Text('Storage and data'),
            subtitle: const Text('Network usage, auto-download'),
            onTap: () {
              Navigator.pushNamed(context, '/data-settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            subtitle: const Text('FAQs, contact support'),
            onTap: () {
              Navigator.pushNamed(context, '/help');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Invite a friend'),
            onTap: () {
              // Implement share
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              // Implement logout logic
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
