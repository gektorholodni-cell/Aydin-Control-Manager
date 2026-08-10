import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_chats_repository.dart';
import '../../domain/entities/chat_user.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({super.key});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  static const _currentUserId = 'u1';

  final _nameController = TextEditingController();
  final _searchController = TextEditingController();
  final Set<String> _selectedUsers = <String>{};
  final _repository = const MockChatsRepository();

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final users = _repository.getUsers();
    final query = _searchController.text.trim().toLowerCase();
    final filtered = users.where((ChatUser user) {
      if (query.isEmpty) {
        return true;
      }
      return user.fullName.toLowerCase().contains(query) || user.role.toLowerCase().contains(query);
    }).toList(growable: false);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.chatCreateGroupTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  _nameController.text.trim().isEmpty ? 'G' : _nameController.text.trim().characters.first.toUpperCase(),
                ),
              ),
              title: Text(l10n.chatGroupAvatarTitle),
              subtitle: Text(
                _nameController.text.trim().isEmpty
                    ? l10n.chatGroupAvatarSubtitle
                    : '${l10n.chatGroupAvatarSubtitle}\n${_nameController.text.trim()}',
              ),
              trailing: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${l10n.chatChangeAvatar}: ${_nameController.text.trim().isEmpty ? 'G' : _nameController.text.trim().characters.first.toUpperCase()}')),
                  );
                },
                child: Text(l10n.chatChangeAvatar),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: l10n.chatGroupNameLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: l10n.chatSearchUsersLabel,
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.chatAddMembersTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          ...filtered.map(
            (user) {
              final selected = _selectedUsers.contains(user.id);
              return CheckboxListTile(
                value: selected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value ?? false) {
                      _selectedUsers.add(user.id);
                    } else {
                      _selectedUsers.remove(user.id);
                    }
                  });
                },
                title: Text(user.fullName),
                subtitle: Text(user.role),
                secondary: CircleAvatar(child: Text(user.fullName.substring(0, 1))),
              );
            },
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              final title = _nameController.text.trim();
              if (title.isEmpty || _selectedUsers.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.validationRequired)),
                );
                return;
              }

              _repository.createGroupChat(
                currentUserId: _currentUserId,
                title: title,
                memberIds: _selectedUsers.toList(growable: false),
              );
              context.pop();
            },
            icon: const Icon(Icons.group_add_outlined),
            label: Text(l10n.chatCreateGroupButton),
          ),
        ],
      ),
    );
  }
}
