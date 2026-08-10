import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_thread.dart';
import '../../domain/entities/chat_user.dart';
import '../../domain/repositories/chats_repository.dart';
import '../datasources/mock_chats_data.dart';

class MockChatsRepository implements ChatsRepository {
  const MockChatsRepository();

  static final List<ChatThread> _threadsStore = List<ChatThread>.from(mockChatThreads);
  static final List<ChatMessage> _messagesStore = List<ChatMessage>.from(mockChatMessages);

  @override
  List<ChatUser> getUsers() => mockChatUsers;

  @override
  List<ChatThread> getThreads() => List<ChatThread>.from(_threadsStore);

  @override
  List<ChatMessage> getMessagesForChat(String chatId) {
    return _messagesStore
        .where((ChatMessage message) => message.chatId == chatId)
        .toList(growable: false);
  }

  @override
  ChatMessage addMessage({
    required String chatId,
    required String senderId,
    required String text,
    required bool isMine,
    ChatMessageType type = ChatMessageType.text,
    String? imagePath,
    String? voiceDurationLabel,
  }) {
    final message = ChatMessage(
      id: 'm_${DateTime.now().microsecondsSinceEpoch}',
      chatId: chatId,
      senderId: senderId,
      text: text,
      sentAt: DateTime.now(),
      isMine: isMine,
      type: type,
      imagePath: imagePath,
      voiceDurationLabel: voiceDurationLabel,
    );
    _messagesStore.add(message);

    final threadIndex = _threadsStore.indexWhere((t) => t.id == chatId);
    if (threadIndex != -1) {
      final thread = _threadsStore[threadIndex];
      _threadsStore[threadIndex] = ChatThread(
        id: thread.id,
        type: thread.type,
        title: thread.title,
        memberIds: thread.memberIds,
        adminId: thread.adminId,
        lastMessage: text,
        lastMessageAt: message.sentAt,
        unreadCount: 0,
        isPinned: thread.isPinned,
        isArchived: thread.isArchived,
        isMuted: thread.isMuted,
        hasTyping: false,
      );
    }

    return message;
  }

  @override
  ChatThread createPrivateChat({
    required String currentUserId,
    required String peerUserId,
  }) {
    for (final thread in _threadsStore) {
      if (thread.type == ChatThreadType.private &&
          thread.memberIds.length == 2 &&
          thread.memberIds.contains(currentUserId) &&
          thread.memberIds.contains(peerUserId)) {
        return thread;
      }
    }

    final peer = mockChatUsers.firstWhere((user) => user.id == peerUserId);
    final newThread = ChatThread(
      id: 'chat_${DateTime.now().microsecondsSinceEpoch}',
      type: ChatThreadType.private,
      title: peer.fullName,
      memberIds: <String>[currentUserId, peerUserId],
      adminId: currentUserId,
      lastMessage: 'Chat created',
      lastMessageAt: DateTime.now(),
      unreadCount: 0,
      isPinned: false,
      isArchived: false,
      isMuted: false,
      hasTyping: false,
    );
    _threadsStore.add(newThread);
    return newThread;
  }

  @override
  ChatThread createGroupChat({
    required String currentUserId,
    required String title,
    required List<String> memberIds,
  }) {
    final uniqueMembers = <String>{currentUserId, ...memberIds}.toList(growable: false);
    final newThread = ChatThread(
      id: 'chat_${DateTime.now().microsecondsSinceEpoch}',
      type: ChatThreadType.group,
      title: title,
      memberIds: uniqueMembers,
      adminId: currentUserId,
      lastMessage: 'Group created',
      lastMessageAt: DateTime.now(),
      unreadCount: 0,
      isPinned: false,
      isArchived: false,
      isMuted: false,
      hasTyping: false,
    );
    _threadsStore.add(newThread);
    return newThread;
  }

  @override
  ChatThread? updateThread(ChatThread thread) {
    final index = _threadsStore.indexWhere((item) => item.id == thread.id);
    if (index == -1) {
      return null;
    }

    _threadsStore[index] = thread;
    return _threadsStore[index];
  }

  @override
  bool deleteChat(String chatId) {
    _messagesStore.removeWhere((message) => message.chatId == chatId);
    final previousLength = _threadsStore.length;
    _threadsStore.removeWhere((thread) => thread.id == chatId);
    return _threadsStore.length != previousLength;
  }
}
