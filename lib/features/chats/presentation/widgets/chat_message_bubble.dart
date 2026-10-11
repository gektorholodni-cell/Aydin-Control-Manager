import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/chats_cloud.dart';
import '../../domain/entities/chat_message.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    required this.text,
    required this.isMine,
    required this.timeLabel,
    this.type = ChatMessageType.text,
    this.imagePath,
    this.voiceDurationLabel,
    this.senderName,
    super.key,
  });

  final String text;
  final bool isMine;
  final String timeLabel;
  final ChatMessageType type;
  final String? imagePath;
  final String? voiceDurationLabel;

  /// Имя отправителя (показывается в группах для чужих сообщений).
  final String? senderName;

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
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: Radius.circular(isMine ? 18 : 4),
              bottomRight: Radius.circular(isMine ? 4 : 18),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              if (senderName != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      senderName!,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ),
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
        if (imagePath == null) {
          return Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor));
        }
        return _ChatImage(path: imagePath!);
      case ChatMessageType.voice:
        return _VoicePlayer(
          path: imagePath,
          durationLabel: voiceDurationLabel ?? '',
          color: textColor,
        );
      case ChatMessageType.sticker:
        return Text(text, style: const TextStyle(fontSize: 40));
      case ChatMessageType.text:
        return Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
        );
    }
  }
}

/// Фото из чата: из облака по временной ссылке или локальный файл.
class _ChatImage extends StatefulWidget {
  const _ChatImage({required this.path});

  final String path;

  @override
  State<_ChatImage> createState() => _ChatImageState();
}

class _ChatImageState extends State<_ChatImage> {
  late Future<String> _url = ChatsCloud.instance.mediaUrl(widget.path);

  @override
  void didUpdateWidget(_ChatImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _url = ChatsCloud.instance.mediaUrl(widget.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    const placeholder = SizedBox(
      width: 220,
      height: 160,
      child: Center(child: Icon(Icons.image_outlined, size: 32)),
    );
    return FutureBuilder<String>(
      future: _url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        final url = snapshot.data;
        if (url == null) {
          return snapshot.hasError ? placeholder : const SizedBox(width: 220, height: 160, child: Center(child: CircularProgressIndicator()));
        }
        final isNetwork = url.startsWith('http') || url.startsWith('blob:') || kIsWeb;
        final image = isNetwork
            ? Image.network(url, width: 220, fit: BoxFit.cover, errorBuilder: (_, _, _) => placeholder)
            : Image.file(File(url), width: 220, fit: BoxFit.cover, errorBuilder: (_, _, _) => placeholder);
        return GestureDetector(
          onTap: () => _openFullScreen(context, image),
          child: ClipRRect(borderRadius: BorderRadius.circular(12), child: image),
        );
      },
    );
  }

  void _openFullScreen(BuildContext context, Image image) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(backgroundColor: Colors.black, foregroundColor: Colors.white),
          body: Center(
            child: InteractiveViewer(
              child: Image(image: image.image, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}

/// Проигрыватель голосового сообщения.
class _VoicePlayer extends StatefulWidget {
  const _VoicePlayer({
    required this.path,
    required this.durationLabel,
    required this.color,
  });

  final String? path;
  final String durationLabel;
  final Color color;

  @override
  State<_VoicePlayer> createState() => _VoicePlayerState();
}

class _VoicePlayerState extends State<_VoicePlayer> {
  AudioPlayer? _player;
  final List<StreamSubscription<Object?>> _subscriptions = <StreamSubscription<Object?>>[];
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _position = Duration.zero;
  Duration _total = Duration.zero;

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _player?.dispose();
    super.dispose();
  }

  AudioPlayer _ensurePlayer() {
    final existing = _player;
    if (existing != null) {
      return existing;
    }
    final player = AudioPlayer();
    _subscriptions
      ..add(player.onPlayerStateChanged.listen((PlayerState state) {
        if (mounted) {
          setState(() => _isPlaying = state == PlayerState.playing);
        }
      }))
      ..add(player.onPositionChanged.listen((Duration position) {
        if (mounted) {
          setState(() => _position = position);
        }
      }))
      ..add(player.onDurationChanged.listen((Duration duration) {
        if (mounted) {
          setState(() => _total = duration);
        }
      }))
      ..add(player.onPlayerComplete.listen((_) {
        if (mounted) {
          setState(() {
            _isPlaying = false;
            _position = Duration.zero;
          });
        }
      }));
    _player = player;
    return player;
  }

  Future<void> _toggle() async {
    final path = widget.path;
    if (path == null || _isLoading) {
      return;
    }
    final player = _ensurePlayer();
    if (_isPlaying) {
      await player.pause();
      return;
    }
    if (player.state == PlayerState.paused) {
      await player.resume();
      return;
    }
    setState(() => _isLoading = true);
    try {
      final url = await ChatsCloud.instance.mediaUrl(path);
      final source = url.startsWith('http') || url.startsWith('blob:') || kIsWeb
          ? UrlSource(url)
          : DeviceFileSource(url);
      await player.play(source);
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не удалось воспроизвести голосовое')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _format(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _total.inMilliseconds == 0
        ? 0.0
        : (_position.inMilliseconds / _total.inMilliseconds).clamp(0.0, 1.0);
    final label = _isPlaying || _position > Duration.zero ? _format(_position) : widget.durationLabel;

    return SizedBox(
      width: 200,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: widget.path == null ? null : _toggle,
            icon: _isLoading
                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2))
                : Icon(_isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, size: 36),
            color: widget.color,
            padding: EdgeInsets.zero,
            tooltip: _isPlaying ? 'Пауза' : 'Слушать',
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 3,
                  borderRadius: BorderRadius.circular(2),
                ),
                const SizedBox(height: 4),
                Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: widget.color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
