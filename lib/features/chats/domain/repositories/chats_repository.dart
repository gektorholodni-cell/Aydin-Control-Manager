import '../entities/chat_message.dart';
import '../entities/chat_thread.dart';
import '../entities/chat_user.dart';

abstract class ChatsRepository {
  List<ChatUser> getUsers();
  List<ChatThread> getThreads();
  List<ChatMessage> getMessagesForChat(String chatId);

  ChatMessage addMessage({
    required String chatId,
    required String senderId,
    required String text,
    required bool isMine,
    ChatMessageType type,
    String? imagePath,
    String? voiceDurationLabel,
  });

  ChatThread createPrivateChat({
    required String currentUserId,
    required String peerUserId,
  });

  ChatThread createGroupChat({
    required String currentUserId,
    required String title,
    required List<String> memberIds,
  });

  ChatThread? updateThread(ChatThread thread);

  bool deleteChat(String chatId);
}
