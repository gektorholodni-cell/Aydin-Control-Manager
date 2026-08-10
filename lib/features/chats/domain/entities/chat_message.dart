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
  final String? imagePath;
  final String? voiceDurationLabel;
}
