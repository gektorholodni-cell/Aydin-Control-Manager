class ChatUser {
  const ChatUser({
    required this.id,
    required this.fullName,
    required this.role,
    required this.isOnline,
    required this.lastSeen,
  });

  final String id;
  final String fullName;
  final String role;
  final bool isOnline;
  final DateTime lastSeen;
}
