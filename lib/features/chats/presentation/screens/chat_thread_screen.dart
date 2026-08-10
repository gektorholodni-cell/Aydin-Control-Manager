import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_chats_repository.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_thread.dart';
import '../../domain/entities/chat_user.dart';
import '../widgets/chat_message_bubble.dart';

class ChatThreadScreen extends StatefulWidget {
  const ChatThreadScreen({
    required this.chatId,
    super.key,
  });

  final String chatId;

  @override
  State<ChatThreadScreen> createState() => _ChatThreadScreenState();
}

class _ChatThreadScreenState extends State<ChatThreadScreen> {
  static const _currentUserId = 'u1';

  final MockChatsRepository _repository = const MockChatsRepository();
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final Stopwatch _voiceStopwatch = Stopwatch();

  Timer? _voiceTicker;
  bool _isRecordingVoice = false;

  late ChatThread? _thread;
  late List<ChatMessage> _messages;
  late List<ChatUser> _users;

  @override
  void initState() {
    super.initState();
    _users = _repository.getUsers();
    final matches = _repository
        .getThreads()
        .where((ChatThread t) => t.id == widget.chatId)
        .toList(growable: false);
    _thread = matches.isEmpty ? null : matches.first;
    _messages = _repository.getMessagesForChat(widget.chatId);
  }

  @override
  void dispose() {
    _voiceTicker?.cancel();
    _messageController.dispose();
    super.dispose();
  }

  void _refreshMessages() {
    setState(() {
      _messages = _repository.getMessagesForChat(widget.chatId);
    });
  }

  void _sendText() {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      return;
    }
    _repository.addMessage(
      chatId: widget.chatId,
      senderId: _currentUserId,
      text: text,
      isMine: true,
      type: ChatMessageType.text,
    );
    _messageController.clear();
    _refreshMessages();
  }

  Future<void> _sendImageFromGallery() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 88);
    if (image == null) {
      return;
    }
    _repository.addMessage(
      chatId: widget.chatId,
      senderId: _currentUserId,
      text: 'Фото из галереи',
      isMine: true,
      type: ChatMessageType.image,
      imagePath: image.path,
    );
    _refreshMessages();
  }

  String _formatVoiceDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _toggleVoiceRecording() {
    if (_isRecordingVoice) {
      _voiceTicker?.cancel();
      _voiceStopwatch.stop();
      final elapsed = _voiceStopwatch.elapsed;
      _voiceStopwatch.reset();

      setState(() {
        _isRecordingVoice = false;
      });

      if (elapsed.inMilliseconds < 700) {
        return;
      }

      _repository.addMessage(
        chatId: widget.chatId,
        senderId: _currentUserId,
        text: 'Голосовое сообщение',
        isMine: true,
        type: ChatMessageType.voice,
        voiceDurationLabel: _formatVoiceDuration(elapsed),
      );
      _refreshMessages();
      return;
    }

    _voiceStopwatch
      ..reset()
      ..start();
    _voiceTicker?.cancel();
    _voiceTicker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || !_isRecordingVoice) {
        return;
      }
      setState(() {});
    });

    setState(() {
      _isRecordingVoice = true;
    });
  }

  Future<void> _openStickerPicker() async {
    final stickers = <String>[
      '😀',
      '😎',
      '👍',
      '👏',
      '🔥',
      '✅',
      '🛠️',
      '🔧',
      '🔨',
      '🪚',
      '🧱',
      '🚧',
      '🏗️',
      '👷',
      '👷‍♀️',
      '⛑️',
      '🚜',
      '🚛',
      '🏭',
      '📐',
      '📏',
      '🧰',
      '⚙️',
      '🗂️',
      '📌',
      '📍',
      '📝',
      '📸',
      '🎯',
      '💪',
      '🚀',
    ];
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: stickers
                  .map(
                    (sticker) => InkWell(
                      onTap: () => Navigator.pop(context, sticker),
                      borderRadius: BorderRadius.circular(12),
                      child: Ink(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.surfaceContainerHigh,
                        ),
                        child: Text(sticker, style: const TextStyle(fontSize: 28)),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        );
      },
    );

    if (selected == null) {
      return;
    }

    _repository.addMessage(
      chatId: widget.chatId,
      senderId: _currentUserId,
      text: selected,
      isMine: true,
      type: ChatMessageType.sticker,
    );
    _refreshMessages();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();

    final thread = _thread;

    if (thread == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.chatsTitle)),
        body: Center(child: Text(l10n.chatNotFound)),
      );
    }

    final messages = _messages;
    final users = _users;
    final currentUser = users.isNotEmpty
        ? users.first
        : ChatUser(
            id: _currentUserId,
            fullName: 'Вы',
            role: '',
            isOnline: true,
            lastSeen: DateTime.now(),
          );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(thread.title),
            Text(
              thread.hasTyping
                  ? l10n.chatsTypingPlaceholder
                  : _statusLabel(context, thread, users, currentUser, locale),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => context.push('${AppRoutes.chats}/${thread.id}/info'),
            icon: const Icon(Icons.info_outline),
            tooltip: l10n.chatInfoTitle,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[messages.length - 1 - index];
                return ChatMessageBubble(
                  text: message.text,
                  isMine: message.isMine,
                  timeLabel: DateFormat.Hm(locale).format(message.sentAt),
                  type: message.type,
                  imagePath: message.imagePath,
                  voiceDurationLabel: message.voiceDurationLabel,
                );
              },
            ),
          ),
          _Composer(
            messageController: _messageController,
            onSendText: _sendText,
            onOpenStickers: _openStickerPicker,
            onPickImage: _sendImageFromGallery,
            onToggleVoiceRecording: _toggleVoiceRecording,
            isRecordingVoice: _isRecordingVoice,
            recordingDurationLabel: _formatVoiceDuration(_voiceStopwatch.elapsed),
          ),
        ],
      ),
    );
  }

  String _statusLabel(
    BuildContext context,
    ChatThread thread,
    List<ChatUser> users,
    ChatUser currentUser,
    String locale,
  ) {
    if (thread.type == ChatThreadType.group) {
      return context.l10n.chatMembersCount(thread.memberIds.length);
    }

    final peerId = thread.memberIds.firstWhere((id) => id != currentUser.id, orElse: () => currentUser.id);
    final peer = users.firstWhere((u) => u.id == peerId, orElse: () => currentUser);

    if (peer.isOnline) {
      return context.l10n.statusOnline;
    }

    return context.l10n.chatLastSeen(DateFormat.yMd(locale).add_Hm().format(peer.lastSeen));
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.messageController,
    required this.onSendText,
    required this.onOpenStickers,
    required this.onPickImage,
    required this.onToggleVoiceRecording,
    required this.isRecordingVoice,
    required this.recordingDurationLabel,
  });

  final TextEditingController messageController;
  final VoidCallback onSendText;
  final VoidCallback onOpenStickers;
  final VoidCallback onPickImage;
  final VoidCallback onToggleVoiceRecording;
  final bool isRecordingVoice;
  final String recordingDurationLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
          ),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: onOpenStickers,
              icon: const Icon(Icons.emoji_emotions_outlined),
              tooltip: l10n.chatsEmojiPlaceholder,
            ),
            Expanded(
              child: TextField(
                controller: messageController,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSendText(),
                decoration: InputDecoration(
                  hintText: l10n.chatMessageInputPlaceholder,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: onPickImage,
              icon: const Icon(Icons.image_outlined),
              tooltip: l10n.chatsImagePlaceholder,
            ),
            IconButton(
              onPressed: onSendText,
              icon: const Icon(Icons.send_rounded),
              tooltip: l10n.commonAdd,
            ),
            IconButton(
              onPressed: onToggleVoiceRecording,
              icon: Icon(
                isRecordingVoice ? Icons.stop_circle_outlined : Icons.keyboard_voice_outlined,
                color: isRecordingVoice ? Theme.of(context).colorScheme.error : null,
              ),
              tooltip: isRecordingVoice ? l10n.chatsVoiceStopAndSend : l10n.chatsVoiceStart,
            ),
            if (isRecordingVoice)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(recordingDurationLabel, style: Theme.of(context).textTheme.labelSmall),
              ),
          ],
        ),
      ),
    );
  }
}
