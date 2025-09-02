import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoMessageViewer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const VideoMessageViewer({
    super.key,
    required this.videoUrl,
    required this.caption,
  });

  @override
  State<VideoMessageViewer> createState() => _VideoMessageViewerState();
}

class _VideoMessageViewerState extends State<VideoMessageViewer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _isPlaying = true;
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayback() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  String _formatDuration(Duration d) {
    return '${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : const CircularProgressIndicator(),
          ),
          if (_controller.value.isInitialized)
            GestureDetector(
              onTap: _togglePlayback,
              child: AnimatedOpacity(
                opacity: _isPlaying ? 0 : 1,
                duration: const Duration(milliseconds: 300),
                child: const Icon(Icons.play_circle, size: 80, color: Colors.white),
              ),
            ),
          if (_controller.value.isInitialized)
            Positioned(
              bottom: 80,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    colors: VideoProgressColors(
                      playedColor: Colors.green,
                      bufferedColor: Colors.white38,
                      backgroundColor: Colors.white24,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_controller.value.position),
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        _formatDuration(_controller.value.duration),
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.caption,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          Positioned(
            top: 40,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
