import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';

import 'custom_video_player.dart';

class VideoChatBubble extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const VideoChatBubble({
    super.key,
    required this.videoUrl,
    required this.caption,
  });

  @override
  State<VideoChatBubble> createState() => _VideoChatBubbleState();
}

class _VideoChatBubbleState extends State<VideoChatBubble> {
  Uint8List? _thumbnail;
  Duration? _videoDuration;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
    _loadDuration();
  }

  Future<void> _generateThumbnail() async {
    final bytes = await VideoThumbnail.thumbnailData(
      video: widget.videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 320,
      quality: 75,
    );
    if (mounted) {
      setState(() => _thumbnail = bytes);
    }
  }

  Future<void> _loadDuration() async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    try {
      await controller.initialize();
      final duration = controller.value.duration;
      if (mounted) {
        setState(() => _videoDuration = duration);
      }
    } catch (e) {
      // ignore error
    } finally {
      controller.dispose();
    }
  }

  String _formatDuration(Duration? d) {
    if (d == null) return '';
    return '${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoMessageViewer(
              videoUrl: widget.videoUrl,
              caption: widget.caption,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _thumbnail != null ? Image.memory(
                    _thumbnail!,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ): const CircularProgressIndicator(),
                ),
                const Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _formatDuration(_videoDuration),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              widget.caption,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
