import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/entities/message.dart';

class EnhancedMessageInput extends StatefulWidget {
  final Function(String) onSendMessage;
  final Function(String, MessageType) onSendFile;
  final Function(String) onSendVoiceMessage;
  final Function(bool) onTypingChanged;

  const EnhancedMessageInput({
    super.key,
    required this.onSendMessage,
    required this.onSendFile,
    required this.onSendVoiceMessage,
    required this.onTypingChanged,
  });

  @override
  State<EnhancedMessageInput> createState() => _EnhancedMessageInputState();
}

class _EnhancedMessageInputState extends State<EnhancedMessageInput> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isRecording = false;
  bool _isTyping = false;
  bool _showEmojiPicker = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final isTyping = _textController.text.isNotEmpty;
    if (isTyping != _isTyping) {
      _isTyping = isTyping;
      widget.onTypingChanged(isTyping);
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        final file = result.files.first;
        final filePath = file.path!;
        final fileName = file.name;
        final fileExtension = fileName.split('.').last.toLowerCase();

        MessageType messageType;
        if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(fileExtension)) {
          messageType = MessageType.image;
        } else if (['mp4', 'avi', 'mov', 'mkv'].contains(fileExtension)) {
          messageType = MessageType.video;
        } else if (['mp3', 'wav', 'aac', 'm4a'].contains(fileExtension)) {
          messageType = MessageType.audio;
        } else {
          messageType = MessageType.document;
        }

        widget.onSendFile(filePath, messageType);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  Future<void> _startVoiceRecording() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      setState(() {
        _isRecording = true;
      });
      // Here you would start actual voice recording
      // For now, we'll simulate it
      widget.onSendVoiceMessage('voice_message_path');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Microphone permission denied')),
      );
    }
  }

  void _stopVoiceRecording() {
    setState(() {
      _isRecording = false;
    });
    // Here you would stop actual voice recording
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
      _textController.clear();
      _focusNode.unfocus();
    }
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
    if (_showEmojiPicker) {
      _focusNode.unfocus();
    }
  }

  void _addEmoji(String emoji) {
    final currentText = _textController.text;
    final selection = _textController.selection;
    final newText = currentText.replaceRange(
      selection.start,
      selection.end,
      emoji,
    );
    _textController.text = newText;
    _textController.selection = TextSelection.collapsed(
      offset: selection.start + emoji.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showEmojiPicker) _buildEmojiPicker(),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: _pickFile,
                color: Colors.grey[600],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _showEmojiPicker ? Icons.keyboard : Icons.emoji_emotions,
                        ),
                        onPressed: _toggleEmojiPicker,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onLongPressStart: (_) => _startVoiceRecording(),
                onLongPressEnd: (_) => _stopVoiceRecording(),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _isRecording ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    _isRecording ? Icons.mic : Icons.send,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmojiPicker() {
    final emojis = [
      '😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣',
      '😊', '😇', '🙂', '🙃', '😉', '😌', '😍', '🥰',
      '😘', '😗', '😙', '😚', '😋', '😛', '😝', '😜',
      '🤪', '🤨', '🧐', '🤓', '😎', '🤩', '🥳', '😏',
      '😒', '😞', '😔', '😟', '😕', '🙁', '☹️', '😣',
      '😖', '😫', '😩', '🥺', '😢', '😭', '😤', '😠',
      '😡', '🤬', '🤯', '😳', '🥵', '🥶', '😱', '😨',
      '😰', '😥', '😓', '🤗', '🤔', '🤭', '🤫', '🤥',
    ];

    return Container(
      height: 200,
      color: Colors.grey[50],
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                Text(
                  'Emoji',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _toggleEmojiPicker,
                  iconSize: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                childAspectRatio: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: emojis.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _addEmoji(emojis[index]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        emojis[index],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 