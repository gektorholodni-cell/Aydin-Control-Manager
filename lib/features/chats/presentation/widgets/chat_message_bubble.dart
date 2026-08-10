import 'package:flutter/material.dart';
import 'dart:io';

import '../../domain/entities/chat_message.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    required this.text,
    required this.isMine,
    required this.timeLabel,
    this.type = ChatMessageType.text,
    this.imagePath,
    this.voiceDurationLabel,
    super.key,
  });

  final String text;
  final bool isMine;
  final String timeLabel;
  final ChatMessageType type;
  final String? imagePath;
  final String? voiceDurationLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bubbleColor = isMine ? colorScheme.primaryContainer : colorScheme.surfaceContainerHigh;
    final textColor = isMine ? colorScheme.onPrimaryContainer : colorScheme.onSurface;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: _MessageContent(
                  text: text,
                  type: type,
                  imagePath: imagePath,
                  voiceDurationLabel: voiceDurationLabel,
                  textColor: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timeLabel,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageContent extends StatelessWidget {
  const _MessageContent({
    required this.text,
    required this.type,
    required this.textColor,
    this.imagePath,
    this.voiceDurationLabel,
  });

  final String text;
  final ChatMessageType type;
  final Color textColor;
  final String? imagePath;
  final String? voiceDurationLabel;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ChatMessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(imagePath!),
                  width: 180,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
            if (imagePath != null) const SizedBox(height: 6),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
            ),
          ],
        );
      case ChatMessageType.voice:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.play_circle_outline, size: 20),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                voiceDurationLabel == null ? text : '$text • $voiceDurationLabel',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        );
      case ChatMessageType.sticker:
      case ChatMessageType.text:
        return Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
        );
    }
  }
}
