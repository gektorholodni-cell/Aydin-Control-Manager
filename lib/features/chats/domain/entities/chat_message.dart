enum ChatMessageType {
  text,
  image,
  voice,
  sticker,
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.sentAt,
    required this.isMine,
    this.type = ChatMessageType.text,
    this.imagePath,
    this.voiceDurationLabel,
  });

  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime sentAt;
  final bool isMine;
  final ChatMessageType type;
  /// Путь к фото или голосовому: в облаке — путь в хранилище,
  /// в демо-режиме — локальный файл.
  final String? imagePath;
  final String? voiceDurationLabel;
}

/// Короткий текст сообщения для списка чатов.
String chatMessagePreview(ChatMessage message) {
  switch (message.type) {
    case ChatMessageType.voice:
      return 'Голосовое сообщение';
    case ChatMessageType.image:
      return 'Фото';
    case ChatMessageType.sticker:
    case ChatMessageType.text:
      return message.text;
  }
}
