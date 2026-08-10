class EnterpriseMessage {
  const EnterpriseMessage({
    required this.id,
    required this.chatId,
    required this.author,
    required this.text,
    required this.createdAt,
  });

  final String id;
  final String chatId;
  final String author;
  final String text;
  final DateTime createdAt;
}
