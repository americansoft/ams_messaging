import 'package:flutter/material.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({super.key});

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}


class _SendRequestScreenState extends State<SendRequestScreen> {

  final List<Map<String, dynamic>> users = [
    {
      'name': 'Ahmed Hassan',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'requested': false,
      'loading': false,
    },
    {
      'name': 'Sara Ali',
      'avatar': 'https://i.pravatar.cc/150?img=2',
      'requested': false,
      'loading': false,
    },
    {
      'name': 'Kareem Youssef',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'requested': false,
      'loading': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Friend Requests'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final user = users[index];
          final isRequested = user['requested'];
          final isLoading = user['loading'];

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: ListTile(
              contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(user['avatar']),
              ),
              title: Text(
                user['name'],
                style:TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    ),
                    ),
              trailing: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: ElevatedButton(
                  onPressed: (isRequested || isLoading)
                      ? null
                      : () {
                          setState(() {
                            users[index]['loading'] = true;
                          });
                
                          Future.delayed(const Duration(seconds: 1), () {
                            setState(() {
                              users[index]['loading'] = false;
                              users[index]['requested'] = true;
                            });
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRequested || isLoading
                        ? Colors.grey
                        : Colors.blue,
                        minimumSize: const Size(120, 40),
                    
                  ),
                  child: SizedBox(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: isLoading
                          ? const SizedBox(
                              key: ValueKey('loading'),
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ):
                            Text(
                                isRequested
                                    ? 'Pending Request'
                                    : 'Send Request',
                                key: ValueKey(isRequested ? 'pending' : 'send'),
                                style: const TextStyle(fontSize: 14),
                              ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

