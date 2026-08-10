enum ChatThreadType {
  private,
  group,
}

class ChatThread {
  const ChatThread({
    required this.id,
    required this.type,
    required this.title,
    required this.memberIds,
    required this.adminId,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.isPinned,
    required this.isArchived,
    required this.isMuted,
    required this.hasTyping,
  });

  final String id;
  final ChatThreadType type;
  final String title;
  final List<String> memberIds;
  final String adminId;
  final String lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;
  final bool isPinned;
  final bool isArchived;
  final bool isMuted;
  final bool hasTyping;

  ChatThread copyWith({
    bool? isPinned,
    bool? isArchived,
    bool? isMuted,
    int? unreadCount,
    String? title,
    List<String>? memberIds,
    String? adminId,
  }) {
    return ChatThread(
      id: id,
      type: type,
      title: title ?? this.title,
      memberIds: memberIds ?? this.memberIds,
      adminId: adminId ?? this.adminId,
      lastMessage: lastMessage,
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      isMuted: isMuted ?? this.isMuted,
      hasTyping: hasTyping,
    );
  }
}
