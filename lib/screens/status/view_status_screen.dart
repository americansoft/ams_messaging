import 'dart:async';
import 'package:flutter/material.dart';

class ViewStatusScreen extends StatefulWidget {
  const ViewStatusScreen({super.key});

  @override
  State<ViewStatusScreen> createState() => _ViewStatusScreenState();
}

class _ViewStatusScreenState extends State<ViewStatusScreen> {
  double _progress = 0.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _progress += 0.02;
        if (_progress >= 1) {
          _progress = 1;
          _timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> statusData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {
          'name': 'Ali',
          'time': '10 minutes ago',
          'image': 'https://via.placeholder.com/400x700.png',
        };

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              statusData['image'],
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) =>
              progress == null ? child : const Center(child: CircularProgressIndicator()),
            ),
          ),

          // Progress bar
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),

          // User info
          Positioned(
            top: 50,
            left: 16,
            child: Row(
              children: [
                const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statusData['name'],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      statusData['time'],
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tap to skip
          GestureDetector(
            onTap: () {
              setState(() {
                _progress = 1;
              });
            },
          ),
        ],
      ),
    );
  }
}
