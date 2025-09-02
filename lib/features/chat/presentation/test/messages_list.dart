import 'package:flutter/material.dart';

class WhatsAppClonePage extends StatelessWidget {
  const WhatsAppClonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'WhatsApp',
          style: TextStyle(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Icons.camera_alt, color: Colors.black87),
          SizedBox(width: 16),
          Icon(Icons.more_vert, color: Colors.black87),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.search),
                hintText: 'Ask Meta AI or Search',
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Filter Chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: const [
                FilterChip(label: Text('All'), onSelected: null, selected: true),
                SizedBox(width: 8),
                FilterChip(label: Text('Work America Group'), onSelected: null, selected: false),
                SizedBox(width: 8),
                FilterChip(label: Text('Unread'), onSelected: null, selected: false),
                SizedBox(width: 8),
                FilterChip(label: Text('Favourites'), onSelected: null, selected: false),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Chat List
          Expanded(
            child: ListView(
              children: const [
                ChatTile(name: 'الشركة الأمريكية', message: 'دا احمد ابراهيم...', time: '12:35 pm', isGroup: true),
                ChatTile(name: 'مساعده شخصية (حاجه لله)', message: 'Mahmoud: https://...', time: '12:35 pm', isGroup: true),
                ChatTile(name: 'Eslam adel', message: 'السفاره قريبه منك...', time: '10:27 am'),
                ChatTile(name: 'Abdo Abd Elhamed', message: 'تمام', time: '10:23 am'),
                ChatTile(name: 'يلا كوره 5%', message: '~ Ahmed: Sticker', time: '8:57 am'),
                ChatTile(name: 'تعيينات IT مسابقة الكهرباء', message: 'بيأكد تاني الناس...', time: '7:40 am', isGroup: true),
                ChatTile(name: 'Ahmed Walid', message: 'b9221641@gmail.com', time: '6:30 am'),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Updates'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Communities'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final bool isGroup;

  const ChatTile({super.key, required this.name, required this.message, required this.time, this.isGroup = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.brown[200],
        child: Icon(isGroup ? Icons.group : Icons.person, color: Colors.white),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Row(children: [
        ImageIcon(AssetImage("assets/icons/read.png"),size: 14,),
        SizedBox(width: 5,),
        Text(message, maxLines: 1)
      ]),
      trailing: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }
}
