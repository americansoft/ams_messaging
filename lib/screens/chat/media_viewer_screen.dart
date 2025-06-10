import 'package:flutter/material.dart';

class MediaViewerScreen extends StatelessWidget {
  const MediaViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated media URL (image or video path)
    final mediaUrl = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Media Viewer', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: Center(
        child: mediaUrl != null
            ? Image.network(
          mediaUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const CircularProgressIndicator(color: Colors.white);
          },
        )
            : const Text(
          'No media to show',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      ),
    );
  }
}
