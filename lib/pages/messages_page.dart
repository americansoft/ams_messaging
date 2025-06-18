import 'package:ams_messaging/app.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../config/app_theme.dart';
import '../helpers.dart';
import '../screens/chat/chat_screen.dart';
import '../widgets/avatar.dart';
import '../widgets/display_error_message.dart';
import '../widgets/unread_indicator.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late final channelListController = StreamChannelListController(
    client: StreamChatCore.of(context).client,
    filter: Filter.and(
      [
        Filter.equal('type', 'messaging'),
        Filter.in_('members', [
          StreamChatCore.of(context).currentUser!.id,
        ])
      ],
    ),
  );

  @override
  void initState() {
    channelListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    channelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MessagesPageWidget(channelListController: channelListController);
  }
}

class MessagesPageWidget extends StatelessWidget {
  const MessagesPageWidget({
    super.key,
    required this.channelListController,
  });

  final StreamChannelListController channelListController;

  @override
  Widget build(BuildContext context) {
    return PagedValueListenableBuilder<int, Channel>(
      valueListenable: channelListController,
      builder: (context, value, child) {
        return value.when(
              (channels, nextPageKey, error) {
            if (channels.isEmpty) {
              return const Center(
                child: Text(
                  'So empty.\nGo and message someone.',
                  textAlign: TextAlign.center,
                ),
              );
            }
            return LazyLoadScrollView(
              onEndOfPage: () async {
                if (nextPageKey != null) {
                  channelListController.loadMore(nextPageKey);
                }
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Text(""),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return _MessageTile(
                          channel: channels[index],
                        );
                      },
                      childCount: channels.length,
                    ),
                  )
                ],
              ),
            );
          },
          loading: () => const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e) => DisplayErrorMessage(
            error: e,
          ),
        );
      },
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    required this.channel,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(
                    url:
                    Helpers.getChannelImage(channel, context.currentUser!)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        Helpers.getChannelName(channel, context.currentUser!),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: _buildLastMessage(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    _buildLastMessageAt(),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: UnreadIndicator(
                        channel: channel,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastMessage() {
    return BetterStreamBuilder<int>(
      stream: channel.state!.unreadCountStream,
      initialData: channel.state?.unreadCount ?? 0,
      builder: (context, count) {
        return BetterStreamBuilder<Message>(
          stream: channel.state!.lastMessageStream,
          initialData: channel.state!.lastMessage,
          builder: (context, lastMessage) {
            return Text(
              lastMessage.text ?? '',
              overflow: TextOverflow.ellipsis,
              style: (count > 0)
                  ? const TextStyle(
                fontSize: 12,
                color: AppColors.secondary,
              )
                  : const TextStyle(
                fontSize: 12,
                color: AppColors.textFaded,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLastMessageAt() {
    return BetterStreamBuilder<DateTime>(
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data) {
        final lastMessageAt = data.toLocal();
        String stringDate;
        final now = DateTime.now();

        final startOfDay = DateTime(now.year, now.month, now.day);

        if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay.millisecondsSinceEpoch) {
          stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).format(pattern: 'h:mm a');
        } else if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay
                .subtract(const Duration(days: 1))
                .millisecondsSinceEpoch) {
          stringDate = 'YESTERDAY';
        } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
          stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).format(pattern: 'EEEE');
        } else {
          stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal())
              .format(pattern: 'yMd');
        }
        return Text(
          stringDate,
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: -0.2,
            fontWeight: FontWeight.w600,
            color: AppColors.textFaded,
          ),
        );
      },
    );
  }
}

