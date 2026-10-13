import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_thread.dart';
import '../../domain/entities/chat_user.dart';
import '../../domain/repositories/chats_repository.dart';
import '../datasources/mock_chats_data.dart';

class MockChatsRepository implements ChatsRepository {
  const MockChatsRepository();

  static final List<ChatThread> _threadsStore = List<ChatThread>.from(mockChatThreads);
  static final List<ChatMessage> _messagesStore = List<ChatMessage>.from(mockChatMessages);

  // ---------------------------------------------------------------------------
  // Синхронизация с облаком (ChatsCloud). Закрепление, архив, «без звука» и
  // счётчик непрочитанных — личные настройки, поэтому они хранятся только
  // на устройстве и сохраняются при обновлении данных с сервера.
  // ---------------------------------------------------------------------------

  static void replaceAll({
    required List<ChatUser> users,
    required List<ChatThread> threads,
    required List<ChatMessage> messages,
  }) {
    mockChatUsers
      ..clear()
      ..addAll(users);
    final merged = threads.map(_keepLocalFlags).toList();
    _threadsStore
      ..clear()
      ..addAll(merged);
    _messagesStore
      ..clear()
      ..addAll(messages);
  }

  static void clearAll() {
    mockChatUsers.clear();
    _threadsStore.clear();
    _messagesStore.clear();
  }

  static bool hasMessage(String id) => _messagesStore.any((m) => m.id == id);

  static ChatThread? findThread(String id) {
    for (final thread in _threadsStore) {
      if (thread.id == id) {
        return thread;
      }
    }
    return null;
  }

  /// Добавляет сообщение, пришедшее с сервера, и обновляет его чат.
  static void putIncomingMessage(ChatMessage message, {required bool countAsUnread}) {
    if (hasMessage(message.id)) {
      return;
    }
    _messagesStore.add(message);
    final index = _threadsStore.indexWhere((t) => t.id == message.chatId);
    if (index == -1) {
      return;
    }
    final thread = _threadsStore[index];
    _threadsStore[index] = thread.withLastMessage(
      chatMessagePreview(message),
      message.sentAt,
      unreadCount: countAsUnread ? thread.unreadCount + 1 : thread.unreadCount,
    );
  }

  static void putThread(ChatThread thread) {
    final index = _threadsStore.indexWhere((t) => t.id == thread.id);
    if (index == -1) {
      _threadsStore.add(thread);
    } else {
      _threadsStore[index] = _keepLocalFlags(thread);
    }
  }

  static void removeThread(String id) {
    _threadsStore.removeWhere((t) => t.id == id);
    _messagesStore.removeWhere((m) => m.chatId == id);
  }

  static ChatThread _keepLocalFlags(ChatThread thread) {
    final local = findThread(thread.id);
    if (local == null) {
      return thread;
    }
    return thread.copyWith(
      isPinned: local.isPinned,
      isArchived: local.isArchived,
      isMuted: local.isMuted,
      unreadCount: local.unreadCount,
    );
  }

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
      _threadsStore[threadIndex] = _threadsStore[threadIndex].withLastMessage(
        chatMessagePreview(message),
        message.sentAt,
        unreadCount: 0,
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

    final peer = mockChatUsers.firstWhere(
      (user) => user.id == peerUserId,
      orElse: () => ChatUser(
        id: peerUserId,
        fullName: 'Сотрудник',
        role: '',
        isOnline: false,
        lastSeen: DateTime.now(),
      ),
    );
    final newThread = ChatThread(
      id: 'chat_${DateTime.now().microsecondsSinceEpoch}',
      type: ChatThreadType.private,
      title: peer.fullName,
      memberIds: <String>[currentUserId, peerUserId],
      adminId: currentUserId,
      lastMessage: 'Чат создан',
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
      lastMessage: 'Группа создана',
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
    final existed = findThread(chatId) != null;
    removeThread(chatId);
    return existed;
  }
}
