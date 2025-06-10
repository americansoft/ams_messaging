import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final VoidCallback? onTap;

  const GroupTile({
    super.key,
    required this.name,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const CircleAvatar(child: Icon(Icons.group)),
      title: Text(name),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
