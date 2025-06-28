import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy'),
            subtitle: const Text('Blocked contacts, last seen, status'),
            onTap: () {
              Navigator.pushNamed(context, '/privacy-settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Security'),
            subtitle: const Text('Enable 2FA and end-to-end encryption info'),
            onTap: () {
              Navigator.pushNamed(context, '/security-settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: const Text('Change Number'),
            subtitle: const Text('Transfer account to new phone number'),
            onTap: () {
              Navigator.pushNamed(context, '/change-number');
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('Delete My Account'),
            subtitle: const Text('Permanently remove account and data'),
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {
              Navigator.pushNamed(context, '/delete-account');
            },
          ),
        ],
      ),
    );
  }
}
