import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

import 'chat_screen/componants/chat_video_bubble.dart';
import 'chat_screen/componants/dynamic_voice_message.dart';

class ChatConversationPage extends StatelessWidget {
  const ChatConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe5ddd5),
      appBar: AppBar(
        backgroundColor: const Color(0xff075e54),
        titleSpacing: 0,
        leading: const BackButton(color: Colors.white),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/user.jpg'),
              radius: 18,
            ),
            const SizedBox(width: 8),
            const Text('Eslam adel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: const [
          Icon(Icons.videocam, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.call, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            children: [
              const _ChatBubble('عينيا', time: '10:03 am', isSender: false),
              VideoChatBubble(videoUrl: 'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.mp4', caption: 'caption',),
              DynamicVoiceMessage(audioUrl: 'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.mp3'),
              const _ChatBubble('انت بتدور ورايا هو انا محور عليك ليه طيب هستفاد ايه', time: '10:18 am', isSender: true),
              DynamicVoiceMessage(audioUrl: 'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.mp3'),
              const _ChatBubble('صاحبي اللي في قطر قالي روح السفاره في هناك مكتب عمل قدم لهم ال CV', time: '10:26 am', isSender: false),
              const _ChatBubble('السفاره قريبه منك مش بعيده مش هتخسر حاجه', time: '10:27 am', isSender: false),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.emoji_emotions_outlined), color: Colors.grey, onPressed: () {}),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
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
          )
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isSender;

  const _ChatBubble(this.text, {required this.time, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSender ? const Color(0xffdcf8c6) : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(text, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}

class VoiceMessageBubble extends StatefulWidget {
  final String audioUrl;
  final String duration;
  final String time;
  final bool isSender;

  const VoiceMessageBubble({super.key, required this.audioUrl, required this.duration, required this.time, this.isSender = false});

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  void _togglePlay() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play(UrlSource(widget.audioUrl));
    }
    setState(() => isPlaying = !isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: widget.isSender ? const Color(0xffdcf8c6) : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.green),
              onPressed: _togglePlay,
            ),
            Container(width: 100, height: 3, color: Colors.green[300]),
            const SizedBox(width: 8),
            Text(widget.duration, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 10),
            Text(widget.time, style: const TextStyle(fontSize: 10, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}

class VideoMessageBubble extends StatefulWidget {
  final String videoUrl;
  final String time;

  const VideoMessageBubble({super.key, required this.videoUrl, required this.time});

  @override
  State<VideoMessageBubble> createState() => _VideoMessageBubbleState();
}

class _VideoMessageBubbleState extends State<VideoMessageBubble> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black,
            ),
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
                  IconButton(
                    icon: Icon(
                      _controller.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying ? _controller.pause() : _controller.play();
                      });
                    },
                  )
                ],
              ),
            )
                : const Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(widget.time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          )
        ],
      ),
    );
  }
}