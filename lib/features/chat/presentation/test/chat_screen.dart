import 'package:flutter/material.dart';

class WhatsAppChatPage extends StatelessWidget {
  const WhatsAppChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffece5dd),
      appBar: AppBar(
        backgroundColor: const Color(0xff075e54),
        title: const Text('Mahmoud Elsayed SEO'),
        actions: const [
          Icon(Icons.videocam),
          SizedBox(width: 10),
          Icon(Icons.call),
          SizedBox(width: 10),
          Icon(Icons.more_vert),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              _dateLabel('04/06/2025'),
              _videoMessage(isMe: false),
              _voiceMessage(isMe: true, time: '3:01 pm'),
              _dateLabel('07/06/2025'),
              _voiceMessage(isMe: true, time: '6:27 am'),
              _voiceMessage(isMe: true, time: '8:54 am'),
              _dateLabel('08/06/2025'),
              _textMessage("طب يعني أكمل اللي معايا الباقي هو ووردبريس", isMe: false, time: '8:07 am'),
              _textMessage("أنا عاوزك زي موضحت كده", isMe: false, time: '9:44 am'),
              _textMessage("الكود بتاعي موجود على github", isMe: true, time: '11:22 am'),
              _textMessage("github.com/mbakro", isMe: true, time: '11:24 am'),
              _textMessage("portfolio-site", isMe: true, time: '11:26 am'),
              const SizedBox(height: 80),
            ],
          ),
          _inputField(),
        ],
      ),
    );
  }

  Widget _textMessage(String text, {required bool isMe, required String time}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xffdcf8c6) : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(text, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _voiceMessage({required bool isMe, required String time}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xffdcf8c6) : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.play_arrow, size: 28),
            const SizedBox(width: 8),
            Container(width: 100, height: 20, color: Colors.grey[300]),
            const SizedBox(width: 8),
            Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _videoMessage({required bool isMe}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(5),
        constraints: const BoxConstraints(maxWidth: 250, maxHeight: 180),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Container(color: Colors.black26),
            const Center(child: Icon(Icons.play_circle_outline, size: 40, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _dateLabel(String date) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(date, style: const TextStyle(fontSize: 12)),
      ),
    );
  }

  Widget _inputField() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 60,
        color: Colors.white,
        child: Row(
          children: [
            const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
            const SizedBox(width: 8),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  border: InputBorder.none,
                ),
              ),
            ),
            const Icon(Icons.attach_file, color: Colors.grey),
            const SizedBox(width: 8),
            const Icon(Icons.camera_alt, color: Colors.grey),
            const SizedBox(width: 8),
            const CircleAvatar(
              backgroundColor: Color(0xff075e54),
              child: Icon(Icons.mic, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
