import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/message_input_widget.dart';
import '../../domain/entities/message.dart';


class ChatConversationPage extends StatefulWidget {
  final String conversationId;
  final String participantName;

  const ChatConversationPage({
    super.key,
    required this.conversationId,
    required this.participantName,
  });

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessages(widget.conversationId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        titleSpacing: 0,
        leading: const BackButton(color: Colors.white),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/50'),
              radius: 18,
            ),
            const SizedBox(width: 8),
            Text(
              widget.participantName,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
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
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MessagesLoaded) {
                  return _buildMessagesList(state.messages);
                } else if (state is ChatError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading messages',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: Text('No messages'));
              },
            ),
          ),
          MessageInputWidget(
            onSendMessage: _handleSendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList(List<Message> messages) {
    if (messages.isEmpty) {
      return const Center(
        child: Text(
          'No messages yet',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isCurrentUser = message.senderId == 'current_user'; // You would get the actual current user ID
        
        return ChatBubble(
          message: message,
          isCurrentUser: isCurrentUser,
        );
      },
    );
  }

  void _handleSendMessage(String text) {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'current_user', // You would get the actual current user ID
      receiverId: widget.conversationId,
      content: text,
      type: MessageType.text,
      status: MessageStatus.sending,
      timestamp: DateTime.now(),
    );

    context.read<ChatBloc>().add(SendMessage(message));
  }
}