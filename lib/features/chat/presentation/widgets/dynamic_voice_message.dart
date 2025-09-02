import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DynamicVoiceMessage extends StatefulWidget {
  final String audioUrl;
  const DynamicVoiceMessage({super.key, required this.audioUrl});

  @override
  State<DynamicVoiceMessage> createState() => _DynamicVoiceMessageState();
}

class _DynamicVoiceMessageState extends State<DynamicVoiceMessage> {
  final AudioPlayer _player = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool isPlaying = false;
  Waveform? _waveform;

  @override
  void initState() {
    super.initState();
    _loadAudio();
    _player.onDurationChanged.listen((d) => setState(() => _duration = d));
    _player.onPositionChanged.listen((p) => setState(() => _position = p));
  }

  Future<void> _loadAudio() async {
    final temp = await getTemporaryDirectory();
    final audioFile = File('${temp.path}/temp.mp3');

    if (!await audioFile.exists()) {
      final request = await HttpClient().getUrl(Uri.parse(widget.audioUrl));
      final response = await request.close();
      final bytes = await consolidateHttpClientResponseBytes(response);
      await audioFile.writeAsBytes(bytes);
    }

    final waveformOutFile = File('${temp.path}/waveform.wave');

    JustWaveform.extract(
      audioInFile: audioFile,
      waveOutFile: waveformOutFile,
    ).listen((progress) {
      if (progress.waveform != null) {
        setState(() => _waveform = progress.waveform);
      }
    });
  }

  void _togglePlay() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play(UrlSource(widget.audioUrl));
    }
    setState(() => isPlaying = !isPlaying);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatTime(Duration d) {
    return "${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _togglePlay,
            ),
            Expanded(
              child: Slider(
                min: 0,
                max: _duration.inSeconds.toDouble(),
                value: _position.inSeconds.clamp(0, _duration.inSeconds).toDouble(),
                onChanged: (value) {
                  final pos = Duration(seconds: value.toInt());
                  _player.seek(pos);
                },
              ),
            ),
            Text(_formatTime(_position)),
          ],
        ),
        if (_waveform != null)
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomPaint(painter: WaveformPainter(_waveform!)),
          ),
      ],
    );
  }
}

class WaveformPainter extends CustomPainter {
  final Waveform waveform;
  WaveformPainter(this.waveform);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.green;

    final samples = waveform.data;
    if (samples.isEmpty) return;

    final width = size.width / samples.length;

    for (int i = 0; i < samples.length; i++) {
      final normalized = samples[i] / 255.0;  
      final height = size.height * normalized;
      final x = i * width;

      canvas.drawLine(
        Offset(x, size.height / 2 - height / 2),
        Offset(x, size.height / 2 + height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

