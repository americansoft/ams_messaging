import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  const UserTile({
    super.key,
    required this.name,
    required this.onTap,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: Colors.deepPurple.shade100,
        child: Text(name[0]),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
    );
  }
}

