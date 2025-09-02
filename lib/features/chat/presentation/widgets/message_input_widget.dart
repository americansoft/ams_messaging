import 'package:flutter/material.dart';

class MessageInputWidget extends StatefulWidget {
  final Function(String) onSendMessage;

  const MessageInputWidget({
    super.key,
    required this.onSendMessage,
  });

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isComposing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    
    widget.onSendMessage(text.trim());
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  void _handleTextChanged(String text) {
    setState(() {
      _isComposing = text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () {
                // TODO: Implement file attachment
              },
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: _handleTextChanged,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            IconButton(
              icon: Icon(
                _isComposing ? Icons.send : Icons.mic,
                color: _isComposing ? Colors.blue : Colors.grey,
              ),
              onPressed: _isComposing
                  ? () => _handleSubmitted(_controller.text)
                  : () {
                      // TODO: Implement voice recording
                    },
            ),
          ],
        ),
      ),
    );
  }
} 