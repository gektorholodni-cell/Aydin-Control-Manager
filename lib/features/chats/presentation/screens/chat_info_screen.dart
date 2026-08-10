import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_chats_repository.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_thread.dart';
import '../../domain/entities/chat_user.dart';

class ChatInfoScreen extends StatefulWidget {
  const ChatInfoScreen({
    required this.chatId,
    super.key,
  });

  final String chatId;

  @override
  State<ChatInfoScreen> createState() => _ChatInfoScreenState();
}

class _ChatInfoScreenState extends State<ChatInfoScreen> {
  static const _currentUserId = 'u1';

  late final MockChatsRepository _repository;
  late ChatThread? _thread;
  late final List<ChatUser> _users;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _repository = const MockChatsRepository();
    _users = _repository.getUsers();
    final matches = _repository
      .getThreads()
      .where((ChatThread t) => t.id == widget.chatId)
      .toList(growable: false);
    _thread = matches.isEmpty ? null : matches.first;
    _nameController = TextEditingController(text: _thread?.title ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _syncThread(ChatThread updated) {
    _repository.updateThread(updated);
    setState(() {
      _thread = updated;
      _nameController.text = updated.title;
    });
  }

  void _toggleMuted() {
    if (_thread == null) {
      return;
    }
    _syncThread(_thread!.copyWith(isMuted: !_thread!.isMuted));
  }

  void _togglePinned() {
    if (_thread == null) {
      return;
    }
    _syncThread(_thread!.copyWith(isPinned: !_thread!.isPinned));
  }

  void _toggleArchived() {
    if (_thread == null) {
      return;
    }
    _syncThread(_thread!.copyWith(isArchived: !_thread!.isArchived));
  }

  void _removeMember(String userId) {
    if (_thread == null || _thread!.type != ChatThreadType.group) {
      return;
    }

    if (_thread!.memberIds.length <= 2) {
      return;
    }

    final updated = List<String>.from(_thread!.memberIds)..remove(userId);
    _syncThread(_thread!.copyWith(memberIds: updated));
  }

  void _addMember(String userId) {
    if (_thread == null || _thread!.type != ChatThreadType.group) {
      return;
    }

    if (_thread!.memberIds.contains(userId)) {
      return;
    }

    final updated = List<String>.from(_thread!.memberIds)..add(userId);
    _syncThread(_thread!.copyWith(memberIds: updated));
  }

  void _renameGroup() {
    if (_thread == null || _thread!.type != ChatThreadType.group) {
      return;
    }
    final title = _nameController.text.trim();
    if (title.isEmpty) {
      return;
    }

    _syncThread(_thread!.copyWith(title: title));
  }

  void _leaveGroup() {
    if (_thread == null || _thread!.type != ChatThreadType.group) {
      return;
    }

    final updated = List<String>.from(_thread!.memberIds)..remove(_currentUserId);
    if (updated.isEmpty) {
      _repository.deleteChat(_thread!.id);
      context.go(AppRoutes.chats);
      return;
    }

    _syncThread(_thread!.copyWith(memberIds: updated));
    context.go('${AppRoutes.chats}/${_thread!.id}');
  }

  void _deleteChat() {
    if (_thread == null) {
      return;
    }

    _repository.deleteChat(_thread!.id);
    context.go(AppRoutes.chats);
  }

  int _countMessages(ChatThread thread, ChatMessageType type) {
    return _repository
        .getMessagesForChat(thread.id)
        .where((message) => message.type == type)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final thread = _thread;

    if (thread == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.chatInfoTitle)),
        body: Center(child: Text(l10n.chatNotFound)),
      );
    }

    final members = _users.where((u) => thread.memberIds.contains(u.id)).toList(growable: false);
    final available = _users.where((u) => !thread.memberIds.contains(u.id)).toList(growable: false);
    final totalMessages = _repository.getMessagesForChat(thread.id).length;
    final mediaMessages = _countMessages(thread, ChatMessageType.image) + _countMessages(thread, ChatMessageType.voice);
    final reactionMessages = _countMessages(thread, ChatMessageType.sticker);
    final avatarSeed = thread.title.trim().isEmpty ? '?' : thread.title.trim().characters.first.toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chatInfoTitle),
        actions: <Widget>[
          IconButton(
            onPressed: _deleteChat,
            icon: const Icon(Icons.delete_outline),
            tooltip: l10n.chatDelete,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          if (thread.type == ChatThreadType.group) ...<Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: l10n.chatGroupNameLabel,
                        suffixIcon: IconButton(
                          onPressed: _renameGroup,
                          icon: const Icon(Icons.check),
                          tooltip: l10n.commonEdit,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(child: Text(avatarSeed)),
                      title: Text(l10n.chatGroupAvatarTitle),
                      subtitle: Text('${l10n.chatGroupAvatarSubtitle}\n$avatarSeed • ${members.length} ${l10n.chatMembersTitle.toLowerCase()}'),
                      isThreeLine: true,
                      trailing: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${l10n.chatChangeAvatar}: $avatarSeed')),
                          );
                        },
                        child: Text(l10n.chatChangeAvatar),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(
                  thread.type == ChatThreadType.group ? Icons.groups_2_outlined : Icons.person_outline,
                ),
              ),
              title: Text(thread.title),
              subtitle: Text('$totalMessages ${l10n.commonRecentUpdates.toLowerCase()} • ${l10n.chatMembersCount(thread.memberIds.length)}'),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: <Widget>[
                SwitchListTile.adaptive(
                  value: thread.isPinned,
                  onChanged: (_) => _togglePinned(),
                  title: Text(l10n.chatPin),
                ),
                const Divider(height: 1),
                SwitchListTile.adaptive(
                  value: thread.isArchived,
                  onChanged: (_) => _toggleArchived(),
                  title: Text(l10n.chatArchive),
                ),
                const Divider(height: 1),
                SwitchListTile.adaptive(
                  value: thread.isMuted,
                  onChanged: (_) => _toggleMuted(),
                  title: Text(l10n.chatMuteNotifications),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(l10n.chatMembersTitle, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          ...members.map(
            (user) => Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(user.fullName.substring(0, 1))),
                title: Text(user.fullName),
                subtitle: Text(user.id == thread.adminId ? l10n.chatGroupAdmin : user.role),
                trailing: thread.type == ChatThreadType.group && user.id != thread.adminId
                    ? IconButton(
                        onPressed: () => _removeMember(user.id),
                        icon: const Icon(Icons.person_remove_outlined),
                        tooltip: l10n.chatRemoveMember,
                      )
                    : null,
              ),
            ),
          ),
          if (thread.type == ChatThreadType.group) ...<Widget>[
            const SizedBox(height: 8),
            Text(l10n.chatAddMembersTitle, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            ...available.map(
              (user) => Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text(user.fullName.substring(0, 1))),
                  title: Text(user.fullName),
                  subtitle: Text(user.role),
                  trailing: IconButton(
                    onPressed: () => _addMember(user.id),
                    icon: const Icon(Icons.person_add_alt_1_outlined),
                    tooltip: l10n.chatAddMember,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _leaveGroup,
              icon: const Icon(Icons.exit_to_app_outlined),
              label: Text(l10n.chatLeaveGroup),
            ),
          ],
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.perm_media_outlined),
              title: Text(l10n.chatSharedMediaPlaceholder),
              subtitle: Text('$mediaMessages ${l10n.commonRecentUpdates.toLowerCase()}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.tag_faces_outlined),
              title: Text(l10n.chatReactionsPlaceholder),
              subtitle: Text('$reactionMessages ${l10n.commonRecentUpdates.toLowerCase()}'),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton.tonal(
            onPressed: () => context.go('${AppRoutes.chats}/${thread.id}'),
            child: Text(l10n.commonBackToChat),
          ),
        ],
      ),
    );
  }
}
