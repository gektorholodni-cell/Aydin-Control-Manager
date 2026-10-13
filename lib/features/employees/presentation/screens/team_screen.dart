import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/backend/cloud_backend.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/support/support_contact.dart';
import '../../../chats/data/chats_cloud.dart';
import '../../../chats/data/repositories/mock_chats_repository.dart';

/// Сотрудники компании из облака: позвонить, написать, указать свой телефон.
class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final CloudBackend _backend = CloudBackend.instance;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() => _loading = true);
    try {
      await _backend.syncAll();
    } on Object {
      _show('Не удалось обновить список. Проверьте интернет.');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _show(String text) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  Future<void> _editMyPhone(String current) async {
    final controller = TextEditingController(text: current);
    final phone = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Мой телефон'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: '+7 700 000 00 00'),
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (phone == null) {
      return;
    }
    try {
      await _backend.updateMyPhone(phone);
      if (mounted) {
        setState(() {});
      }
      _show('Телефон сохранён');
    } on Object {
      _show('Не удалось сохранить телефон');
    }
  }

  void _call(CompanyMember member) {
    if (member.phone.trim().isEmpty) {
      _show('${member.fullName} ещё не указал телефон в разделе «Команда».');
      return;
    }
    callPhone(member.phone);
  }

  void _write(CompanyMember member) {
    final cloud = ChatsCloud.instance;
    const repository = MockChatsRepository();
    final before = repository.getThreads().map((thread) => thread.id).toSet();
    final thread = repository.createPrivateChat(
      currentUserId: cloud.currentUserId,
      peerUserId: member.id,
    );
    if (!before.contains(thread.id)) {
      cloud.createThread(thread).catchError((Object _) => _show('Не удалось создать чат'));
    }
    context.go('${AppRoutes.chats}/${thread.id}');
  }

  @override
  Widget build(BuildContext context) {
    final me = _backend.currentUserId;
    final members = _backend.members;
    final myself = me == null ? null : _backend.memberById(me);
    final others = members.where((member) => member.id != me).toList(growable: false);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Команда'),
        bottom: _loading
            ? const PreferredSize(
                preferredSize: Size.fromHeight(2),
                child: LinearProgressIndicator(minHeight: 2),
              )
            : null,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: <Widget>[
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.phone_iphone)),
                title: const Text('Мой телефон'),
                subtitle: Text(
                  (myself?.phone ?? '').isEmpty
                      ? 'Не указан. Укажите, чтобы коллеги могли вам позвонить.'
                      : myself!.phone,
                ),
                trailing: const Icon(Icons.edit_outlined),
                onTap: () => _editMyPhone(myself?.phone ?? ''),
              ),
            ),
            const SizedBox(height: 12),
            Text('Сотрудники (${others.length})', style: textTheme.titleMedium),
            const SizedBox(height: 6),
            if (others.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Пока никого нет. Отправьте сотрудникам код приглашения из раздела «Компания».',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium,
                ),
              ),
            ...others.map(
              (member) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(member.fullName.isEmpty ? '?' : member.fullName.characters.first),
                  ),
                  title: Text(member.fullName.isEmpty ? 'Без имени' : member.fullName),
                  subtitle: Text(
                    <String>[member.role, member.phone].where((part) => part.isNotEmpty).join(' • '),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        tooltip: 'Написать',
                        icon: const Icon(Icons.chat_bubble_outline),
                        onPressed: () => _write(member),
                      ),
                      IconButton.filledTonal(
                        tooltip: 'Позвонить',
                        icon: const Icon(Icons.call),
                        onPressed: () => _call(member),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
