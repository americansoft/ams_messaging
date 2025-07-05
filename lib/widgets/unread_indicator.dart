// import 'package:ams_messaging/config/constants.dart';
// import 'package:flutter/material.dart';
//
//
//
// /// Widget for showing an unread indicator
// class UnreadIndicator extends StatelessWidget {
//   /// Constructor for creating an [UnreadIndicator]
//   const UnreadIndicator({
//     super.key,
//     required this.channel,
//   });
//
//   final Channel channel;
//
//   @override
//   Widget build(BuildContext context) {
//     return IgnorePointer(
//       child: StreamBuilder<int>(
//         stream: channel.state!.unreadCountStream,
//         initialData: channel.state!.unreadCount,
//         builder: (context, data) {
//           if (data == 0) {
//             return const SizedBox.shrink();
//           }
//           return Material(
//             borderRadius: BorderRadius.circular(8),
//             color: AppColors.secondary,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 left: 5,
//                 right: 5,
//                 top: 2,
//                 bottom: 1,
//               ),
//               child: Center(
//                 child: Text(
//                   '${data > 99 ? '99+' : data}',
//                   style: const TextStyle(
//                     fontSize: 11,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
