import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../data/chats_cloud.dart';
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
  final MockChatsRepository _repository = const MockChatsRepository();
  final ChatsCloud _cloud = ChatsCloud.instance;
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final AudioRecorder _recorder = AudioRecorder();
  final Stopwatch _voiceStopwatch = Stopwatch();

  Timer? _voiceTicker;
  bool _isRecordingVoice = false;
  bool _isSending = false;
  String _voiceExtension = 'm4a';

  ChatThread? _thread;
  List<ChatMessage> _messages = const <ChatMessage>[];
  List<ChatUser> _users = const <ChatUser>[];

  String get _currentUserId => _cloud.currentUserId;

  @override
  void initState() {
    super.initState();
    _cloud.openChatId = widget.chatId;
    _cloud.addListener(_reload);
    _load();
    _cloud.markRead(widget.chatId);
  }

  @override
  void dispose() {
    if (_cloud.openChatId == widget.chatId) {
      _cloud.openChatId = null;
    }
    _cloud.removeListener(_reload);
    _voiceTicker?.cancel();
    _recorder.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _load() {
    _users = _repository.getUsers();
    _thread = MockChatsRepository.findThread(widget.chatId);
    _messages = _repository.getMessagesForChat(widget.chatId);
  }

  void _reload() {
    if (!mounted) {
      return;
    }
    setState(_load);
    _cloud.markRead(widget.chatId);
  }

  void _refreshMessages() {
    setState(_load);
  }

  void _showError(String text) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  /// Сохраняет сообщение на устройстве и отправляет его в облако.
  void _post({
    required String text,
    required ChatMessageType type,
    String? mediaPath,
    String? voiceDurationLabel,
  }) {
    final message = _repository.addMessage(
      chatId: widget.chatId,
      senderId: _currentUserId,
      text: text,
      isMine: true,
      type: type,
      imagePath: mediaPath,
      voiceDurationLabel: voiceDurationLabel,
    );
    _refreshMessages();
    _cloud.sendMessage(message).catchError((Object _) {
      _showError('Сообщение не отправлено. Проверьте интернет.');
    });
  }

  void _sendText() {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      return;
    }
    _messageController.clear();
    _post(text: text, type: ChatMessageType.text);
  }

  Future<void> _sendImageFromGallery() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1600,
    );
    if (image == null) {
      return;
    }
    final ext = image.name.contains('.') ? image.name.split('.').last.toLowerCase() : 'jpg';
    final path = await _uploadOrKeep(
      file: image,
      fileExtension: ext,
      contentType: ext == 'png' ? 'image/png' : 'image/jpeg',
    );
    if (path == null) {
      return;
    }
    _post(text: 'Фото', type: ChatMessageType.image, mediaPath: path);
  }

  /// В облаке загружает файл и возвращает путь в хранилище,
  /// в демо-режиме — путь к локальному файлу.
  Future<String?> _uploadOrKeep({
    required XFile file,
    required String fileExtension,
    required String contentType,
  }) async {
    if (!_cloud.isEnabled) {
      return file.path;
    }
    setState(() => _isSending = true);
    try {
      return await _cloud.uploadMedia(
        chatId: widget.chatId,
        bytes: await file.readAsBytes(),
        fileExtension: fileExtension,
        contentType: contentType,
      );
    } on Object {
      _showError('Не удалось загрузить файл. Проверьте интернет.');
      return null;
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  String _formatVoiceDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _toggleVoiceRecording() async {
    if (_isRecordingVoice) {
      await _finishVoiceRecording();
      return;
    }
    if (!await _startVoiceRecording()) {
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

  Future<bool> _startVoiceRecording() async {
    try {
      if (!await _recorder.hasPermission()) {
        _showError('Разрешите доступ к микрофону, чтобы записывать голосовые.');
        return false;
      }
      // m4a (AAC) играет на iPhone, Android и в браузерах; WAV — запасной вариант.
      final encoder = await _recorder.isEncoderSupported(AudioEncoder.aacLc)
          ? AudioEncoder.aacLc
          : AudioEncoder.wav;
      _voiceExtension = encoder == AudioEncoder.aacLc ? 'm4a' : 'wav';
      final fileName = 'voice_${DateTime.now().millisecondsSinceEpoch}.$_voiceExtension';
      final path = kIsWeb ? fileName : '${(await getTemporaryDirectory()).path}/$fileName';
      await _recorder.start(RecordConfig(encoder: encoder, numChannels: 1), path: path);
      return true;
    } on Object {
      _showError('Не удалось включить микрофон.');
      return false;
    }
  }

  Future<void> _cancelVoiceRecording() async {
    _voiceTicker?.cancel();
    _voiceStopwatch
      ..stop()
      ..reset();
    setState(() => _isRecordingVoice = false);
    await _recorder.cancel();
  }

  Future<void> _finishVoiceRecording() async {
    _voiceTicker?.cancel();
    _voiceStopwatch.stop();
    final elapsed = _voiceStopwatch.elapsed;
    _voiceStopwatch.reset();
    setState(() {
      _isRecordingVoice = false;
    });

    final recorded = await _recorder.stop();
    if (recorded == null || elapsed.inMilliseconds < 700) {
      return;
    }
    final path = await _uploadOrKeep(
      file: XFile(recorded),
      fileExtension: _voiceExtension,
      contentType: _voiceExtension == 'm4a' ? 'audio/mp4' : 'audio/wav',
    );
    if (path == null) {
      return;
    }
    _post(
      text: 'Голосовое сообщение',
      type: ChatMessageType.voice,
      mediaPath: path,
      voiceDurationLabel: _formatVoiceDuration(elapsed),
    );
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

    _post(text: selected, type: ChatMessageType.sticker);
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
    final currentUser = users.firstWhere(
      (ChatUser user) => user.id == _currentUserId,
      orElse: () => ChatUser(
            id: _currentUserId,
            fullName: 'Вы',
            role: '',
            isOnline: true,
            lastSeen: DateTime.now(),
          ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(thread.title, overflow: TextOverflow.ellipsis),
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
          if (_isSending) const LinearProgressIndicator(minHeight: 2),
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Text(
                      'Сообщений пока нет. Напишите первым или запишите голосовое.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : 
ListView.builder(
              reverse: true,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[messages.length - 1 - index];
                return ChatMessageBubble(
                  senderName: thread.type == ChatThreadType.group && !message.isMine
                      ? _senderName(users, message.senderId)
                      : null,
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
            onPickImage: _isSending ? null : _sendImageFromGallery,
            onToggleVoiceRecording: _isSending ? null : _toggleVoiceRecording,
            onCancelVoiceRecording: _cancelVoiceRecording,
            isRecordingVoice: _isRecordingVoice,
            recordingDurationLabel: _formatVoiceDuration(_voiceStopwatch.elapsed),
          ),
        ],
      ),
    );
  }

  String _senderName(List<ChatUser> users, String senderId) {
    for (final user in users) {
      if (user.id == senderId) {
        return user.fullName;
      }
    }
    return 'Сотрудник';
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

    return peer.role;
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.messageController,
    required this.onSendText,
    required this.onOpenStickers,
    required this.onPickImage,
    required this.onToggleVoiceRecording,
    required this.onCancelVoiceRecording,
    required this.isRecordingVoice,
    required this.recordingDurationLabel,
  });

  final TextEditingController messageController;
  final VoidCallback onSendText;
  final VoidCallback onOpenStickers;
  final VoidCallback? onPickImage;
  final VoidCallback? onToggleVoiceRecording;
  final VoidCallback onCancelVoiceRecording;
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
        child: isRecordingVoice
            ? Row(
                children: <Widget>[
                  IconButton(
                    onPressed: onCancelVoiceRecording,
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Отменить запись',
                  ),
                  Icon(Icons.fiber_manual_record, color: Theme.of(context).colorScheme.error, size: 14),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Запись… $recordingDurationLabel',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: onToggleVoiceRecording,
                    icon: const Icon(Icons.send_rounded),
                    label: Text(l10n.chatsVoiceStopAndSend),
                  ),
                ],
              )
            : ValueListenableBuilder<TextEditingValue>(
                valueListenable: messageController,
                builder: (BuildContext context, TextEditingValue value, _) {
                  final hasText = value.text.trim().isNotEmpty;
                  return Row(
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
                          minLines: 1,
                          maxLines: 4,
                          onSubmitted: (_) => onSendText(),
                          decoration: InputDecoration(
                            hintText: l10n.chatMessageInputPlaceholder,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onPickImage,
                        icon: const Icon(Icons.image_outlined),
                        tooltip: l10n.chatsImagePlaceholder,
                      ),
                      // Как в мессенджерах: есть текст — «отправить», нет — микрофон.
                      if (hasText)
                        IconButton.filled(
                          onPressed: onSendText,
                          icon: const Icon(Icons.send_rounded),
                          tooltip: l10n.commonAdd,
                        )
                      else
                        IconButton.filled(
                          onPressed: onToggleVoiceRecording,
                          icon: const Icon(Icons.keyboard_voice_rounded),
                          tooltip: l10n.chatsVoiceStart,
                        ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
