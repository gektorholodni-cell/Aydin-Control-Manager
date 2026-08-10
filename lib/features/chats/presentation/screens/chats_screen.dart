import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_chats_repository.dart';
import '../../domain/entities/chat_thread.dart';
import '../../domain/entities/chat_user.dart';
import '../widgets/chat_thread_tile.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  static const _currentUserId = 'u1';

  final TextEditingController _searchController = TextEditingController();
  bool _showArchived = false;
  late final MockChatsRepository _repository;
  late List<ChatThread> _threads;
  late final List<ChatUser> _users;

  @override
  void initState() {
    super.initState();
    _repository = const MockChatsRepository();
    _threads = List<ChatThread>.from(_repository.getThreads());
    _users = _repository.getUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyThreadUpdate(String id, ChatThread Function(ChatThread thread) update) {
    setState(() {
      _threads = _threads
          .map((ChatThread thread) => thread.id == id ? update(thread) : thread)
          .toList(growable: false);
    });
  }

  void _deleteThread(String id) {
    _repository.deleteChat(id);
    setState(() {
      _threads = _threads.where((thread) => thread.id != id).toList(growable: false);
    });
  }

  Future<void> _openGroupCreator() async {
    await context.push(AppRoutes.newGroup);
    if (!mounted) {
      return;
    }
    setState(() {
      _threads = List<ChatThread>.from(_repository.getThreads());
    });
  }

  Future<void> _createPrivateChat() async {
    final l10n = context.l10n;
    final users = _users.where((u) => u.id != _currentUserId).toList(growable: false);
    String? selectedUserId;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      l10n.chatCreateDirectTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: selectedUserId,
                      decoration: InputDecoration(labelText: l10n.chatSearchUsersLabel),
                      items: users
                          .map(
                            (user) => DropdownMenuItem<String>(
                              value: user.id,
                              child: Text('${user.fullName} • ${user.role}'),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (value) {
                        setLocalState(() {
                          selectedUserId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: selectedUserId == null
                            ? null
                            : () {
                                _repository.createPrivateChat(
                                  currentUserId: _currentUserId,
                                  peerUserId: selectedUserId!,
                                );
                                Navigator.pop(context);
                              },
                        icon: const Icon(Icons.person_add_alt_1_outlined),
                        label: Text(l10n.chatCreateDirectTitle),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (!mounted) {
      return;
    }
    setState(() {
      _threads = List<ChatThread>.from(_repository.getThreads());
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final query = _searchController.text.trim().toLowerCase();

    final privateChats = _filterThreads(
      type: ChatThreadType.private,
      query: query,
    );
    final groupChats = _filterThreads(
      type: ChatThreadType.group,
      query: query,
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.chatsTitle),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  _showArchived = !_showArchived;
                });
              },
              icon: Icon(_showArchived ? Icons.unarchive_outlined : Icons.archive_outlined),
              tooltip: _showArchived ? l10n.chatHideArchived : l10n.chatShowArchived,
            ),
            IconButton(
              onPressed: _openGroupCreator,
              icon: const Icon(Icons.group_add_outlined),
              tooltip: l10n.chatCreateGroupTitle,
            ),
          ],
          bottom: TabBar(
            tabs: <Tab>[
              Tab(text: l10n.chatsPrivateTab),
              Tab(text: l10n.chatsGroupTab),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: l10n.chatsSearchLabel,
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  _ChatList(
                    items: privateChats,
                    locale: locale,
                    users: _users,
                    emptyLabel: l10n.chatsNoResults,
                    onTap: (ChatThread thread) => context.go('${AppRoutes.chats}/${thread.id}'),
                    onActionRequested: (ChatThread thread) => _showActions(context, thread),
                  ),
                  _ChatList(
                    items: groupChats,
                    locale: locale,
                    users: _users,
                    emptyLabel: l10n.chatsNoResults,
                    onTap: (ChatThread thread) => context.go('${AppRoutes.chats}/${thread.id}'),
                    onActionRequested: (ChatThread thread) => _showActions(context, thread),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _createPrivateChat,
                  icon: const Icon(Icons.person_add_alt_1_outlined),
                  label: Text(l10n.chatCreateDirectTitle),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _openGroupCreator,
                  icon: const Icon(Icons.group_add_outlined),
                  label: Text(l10n.chatCreateGroupButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ChatThread> _filterThreads({
    required ChatThreadType type,
    required String query,
  }) {
    return _threads.where((ChatThread thread) {
      if (thread.type != type) {
        return false;
      }
      if (!_showArchived && thread.isArchived) {
        return false;
      }
      if (query.isEmpty) {
        return true;
      }

      return thread.title.toLowerCase().contains(query) ||
          thread.lastMessage.toLowerCase().contains(query);
    }).toList(growable: false)
      ..sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return a.isPinned ? -1 : 1;
        }
        return b.lastMessageAt.compareTo(a.lastMessageAt);
      });
  }

  Future<void> _showActions(BuildContext context, ChatThread thread) async {
    final l10n = context.l10n;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.push_pin_outlined),
                title: Text(thread.isPinned ? l10n.chatUnpin : l10n.chatPin),
                onTap: () {
                  Navigator.pop(context);
                  _applyThreadUpdate(thread.id, (current) => current.copyWith(isPinned: !current.isPinned));
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications_off_outlined),
                title: Text(thread.isMuted ? l10n.chatUnmute : l10n.chatMuteNotifications),
                onTap: () {
                  Navigator.pop(context);
                  _applyThreadUpdate(thread.id, (current) => current.copyWith(isMuted: !current.isMuted));
                },
              ),
              ListTile(
                leading: const Icon(Icons.archive_outlined),
                title: Text(thread.isArchived ? l10n.chatUnarchive : l10n.chatArchive),
                onTap: () {
                  Navigator.pop(context);
                  _applyThreadUpdate(thread.id, (current) => current.copyWith(isArchived: !current.isArchived));
                },
              ),
              ListTile(
                leading: const Icon(Icons.mark_email_read_outlined),
                title: Text(l10n.chatMarkRead),
                onTap: () {
                  Navigator.pop(context);
                  _applyThreadUpdate(thread.id, (current) => current.copyWith(unreadCount: 0));
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: Text(l10n.chatDelete),
                onTap: () {
                  Navigator.pop(context);
                  _deleteThread(thread.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChatList extends StatelessWidget {
  const _ChatList({
    required this.items,
    required this.locale,
    required this.users,
    required this.emptyLabel,
    required this.onTap,
    required this.onActionRequested,
  });

  final List<ChatThread> items;
  final String locale;
  final List<ChatUser> users;
  final String emptyLabel;
  final ValueChanged<ChatThread> onTap;
  final ValueChanged<ChatThread> onActionRequested;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.forum_outlined, size: 34),
            const SizedBox(height: 8),
            Text(emptyLabel),
            const SizedBox(height: 4),
            Text(
              'Create private or group chat to start communication.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 90),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (BuildContext context, int index) {
        final thread = items[index];
        final isOnline = _resolveOnline(thread);
        final subtitle = thread.hasTyping ? context.l10n.chatsTypingPlaceholder : thread.lastMessage;

        return ChatThreadTile(
          thread: thread,
          subtitle: subtitle,
          trailingLabel: DateFormat.Md(locale).add_Hm().format(thread.lastMessageAt),
          isOnline: isOnline,
          onTap: () => onTap(thread),
          onLongPress: () => onActionRequested(thread),
        );
      },
    );
  }

  bool _resolveOnline(ChatThread thread) {
    if (users.isEmpty) return false;
    if (thread.type == ChatThreadType.group) {
      return thread.memberIds.any((id) => users.any((u) => u.id == id && u.isOnline));
    }

    final peer = users.firstWhere(
      (u) => thread.memberIds.contains(u.id) && u.id != users.first.id,
      orElse: () => users.first,
    );
    return peer.isOnline;
  }
}
