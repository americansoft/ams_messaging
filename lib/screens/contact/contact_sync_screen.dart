import 'package:flutter/material.dart';

class ContactSyncScreen extends StatefulWidget {
  const ContactSyncScreen({super.key});

  @override
  State<ContactSyncScreen> createState() => _ContactSyncScreenState();
}

class _ContactSyncScreenState extends State<ContactSyncScreen> {
  bool isSyncing = false;
  bool syncComplete = false;

  void _startSync() {
    setState(() {
      isSyncing = true;
      syncComplete = false;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isSyncing = false;
        syncComplete = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync Contacts'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: isSyncing
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Syncing your contacts...'),
          ],
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Contacts Synced Successfully!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/chat-list');
              },
              icon: const Icon(Icons.done),
              label: const Text('Continue'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
