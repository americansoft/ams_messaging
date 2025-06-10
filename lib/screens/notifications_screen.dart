import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  bool _messageNotif = true;
  bool _groupNotif = true;
  bool _callNotif = true;
  bool _vibration = true;
  bool _inAppSound = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Message Notifications',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text('Message Notifications'),
            subtitle: const Text('Sound and vibration for 1-on-1 messages'),
            value: _messageNotif,
            onChanged: (val) => setState(() => _messageNotif = val),
          ),
          const Divider(),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Group Notifications',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text('Group Notifications'),
            subtitle: const Text('Sound and vibration for group messages'),
            value: _groupNotif,
            onChanged: (val) => setState(() => _groupNotif = val),
          ),
          const Divider(),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Call Notifications',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text('Call Notifications'),
            subtitle: const Text('Sound and vibration for calls'),
            value: _callNotif,
            onChanged: (val) => setState(() => _callNotif = val),
          ),
          const Divider(),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Additional Settings',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text('Vibrate'),
            value: _vibration,
            onChanged: (val) => setState(() => _vibration = val),
          ),
          SwitchListTile(
            title: const Text('In-App Sound'),
            value: _inAppSound,
            onChanged: (val) => setState(() => _inAppSound = val),
          ),
        ],
      ),
    );
  }
}
