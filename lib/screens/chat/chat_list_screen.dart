// import 'package:flutter/material.dart';
//
// import '../../core/utils/helpers.dart';
//
// class ChatListScreen extends StatelessWidget {
//   const ChatListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Placeholder chat data
//     final chats = [
//       {
//         'name': 'Ali',
//         'lastMessage': 'Hey! How are you?',
//         'timestamp': '9:42 AM',
//         'unread': true
//       },
//       {
//         'name': 'American Group',
//         'lastMessage': 'You: I’ll push the code tonight',
//         'timestamp': '8:15 AM',
//         'unread': false
//       },
//       {
//         'name': 'Mostafa Hp',
//         'lastMessage': 'Thanks for contacting us.',
//         'timestamp': 'Yesterday',
//         'unread': false
//       },
//       {
//         'name': 'Ahmed Walid',
//         'lastMessage': 'Thanks for contacting us.',
//         'timestamp': 'Yesterday',
//         'unread': false
//       },
//       {
//         'name': 'Mahmoud Elsayed',
//         'lastMessage': 'Thanks for contacting us.',
//         'timestamp': 'Yesterday',
//         'unread': true
//       },
//       {
//         'name': 'Shaban',
//         'lastMessage': 'Thanks for contacting us.',
//         'timestamp': 'Yesterday',
//         'unread': false
//       },
//
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chats'),
//         backgroundColor: Colors.deepPurple,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               Navigator.pushNamed(context, '/search');
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.more_vert),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: ListView.separated(
//         itemCount: chats.length,
//         separatorBuilder: (_, _) => const Divider(height: 1),
//         itemBuilder: (context, index) {
//           final chat = chats[index];
//           return ListTile(
//             onTap: () => Navigator.pushNamed(context, '/chat'),
//             leading: CircleAvatar(
//               radius: 25,
//               backgroundColor: Colors.deepPurple.shade100,
//               child: Text(getInitials(chat['name']!.toString())),
//             ),
//             title: Text(
//               chat['name']!.toString(),
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(chat['lastMessage']!.toString()),
//             trailing: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   chat['timestamp']!.toString(),
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//                 if (chat['unread'] == true)
//                   const CircleAvatar(
//                     radius: 6,
//                     backgroundColor: Colors.green,
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.deepPurple,
//         onPressed: () {
//           Navigator.pushNamed(context, '/contacts-picker');
//         },
//         child: const Icon(Icons.chat),
//       ),
//     );
//   }
// }


import 'package:ams_messaging/config/app_theme.dart';
import 'package:ams_messaging/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/calls_page.dart';
import '../../pages/contacts_page.dart';
import '../../pages/messages_page.dart';
import '../../pages/notifications_page.dart';

class ChatListScreen extends StatelessWidget {
  static Route get route => MaterialPageRoute(
    builder: (context) => ChatListScreen(),
  );
  ChatListScreen({super.key});

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage(),
  ];

  final pageTitles = const [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts',
  ];

  void _onNavigationItemSelected(int index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) => Text(value),
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {
              // TODO search
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Hero(
              tag: 'hero-profile-picture',
              child: Avatar.small(
                //url: context.currentUserImage,
                onTap: () {
                  //Navigator.of(context).push(ProfileScreen.route);
                },
              ),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    required this.onItemSelected,
  });

  final ValueChanged<int> onItemSelected;

  @override
  __BottomNavigationBarState createState() => __BottomNavigationBarState();
}

class __BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
                lable: 'Messages',
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                isSelected: (selectedIndex == 0),
                onTap: handleItemSelected,
              ),
              _NavigationBarItem(
                index: 1,
                lable: 'Notifications',
                icon: CupertinoIcons.bell_solid,
                isSelected: (selectedIndex == 1),
                onTap: handleItemSelected,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GlowingActionButton(
                  color: AppColors.secondary,
                  icon: CupertinoIcons.add,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const Dialog(
                        child: AspectRatio(
                          aspectRatio: 8 / 7,
                          child: ContactsPage(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _NavigationBarItem(
                index: 2,
                lable: 'Calls',
                icon: CupertinoIcons.phone_fill,
                isSelected: (selectedIndex == 2),
                onTap: handleItemSelected,
              ),
              _NavigationBarItem(
                index: 3,
                lable: 'Contacts',
                icon: CupertinoIcons.person_2_fill,
                isSelected: (selectedIndex == 3),
                onTap: handleItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    required this.index,
    required this.lable,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  });

  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              lable,
              style: isSelected
                  ? const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              )
                  : const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
