import 'package:flutter/material.dart';

import '../../domain/entities/chat_thread.dart';

class ChatThreadTile extends StatelessWidget {
  const ChatThreadTile({
    required this.thread,
    required this.subtitle,
    required this.trailingLabel,
    required this.isOnline,
    required this.onTap,
    required this.onLongPress,
    super.key,
  });

  final ChatThread thread;
  final String subtitle;
  final String trailingLabel;
  final bool isOnline;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: Stack(
          children: <Widget>[
            CircleAvatar(
              child: Icon(
                thread.type == ChatThreadType.group
                    ? Icons.groups_2_outlined
                    : Icons.person_outline,
              ),
            ),
            if (isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Theme.of(context).colorScheme.surface),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                thread.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (thread.isPinned)
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(Icons.push_pin_outlined, size: 16),
              ),
            if (thread.isMuted)
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(Icons.notifications_off_outlined, size: 16),
              ),
          ],
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(trailingLabel, style: Theme.of(context).textTheme.labelSmall),
            if (thread.unreadCount > 0) ...<Widget>[
              const SizedBox(height: 6),
              CircleAvatar(
                radius: 11,
                child: Text(
                  '${thread.unreadCount}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
