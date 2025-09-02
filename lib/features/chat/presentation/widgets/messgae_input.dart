import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        color: Colors.white,
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.emoji_emotions_outlined), color: Colors.grey, onPressed: () {}),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const TextField(
                  decoration:  InputDecoration(
                    hoverColor: Colors.transparent
                    ),
                ),
              ),
            ),
            IconButton(icon: const Icon(Icons.attach_file), color: Colors.grey, onPressed: () {}),
            IconButton(icon: const Icon(Icons.camera_alt), color: Colors.grey, onPressed: () {}),
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xff075e54),
              child: const Icon(Icons.mic, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}