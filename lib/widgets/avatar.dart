import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final String? fallbackText;

  const Avatar({
    super.key,
    this.imageUrl,
    this.radius = 24,
    this.fallbackText,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.deepPurple.shade100,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Text(
        fallbackText?.substring(0, 1).toUpperCase() ?? '?',
        style: TextStyle(fontSize: radius * 0.8, color: Colors.deepPurple),
      )
          : null,
    );
  }
}
