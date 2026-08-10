import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_notifications_repository.dart';
import '../../domain/entities/app_notification.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<AppNotification> _items;
  bool _showArchived = false;
  NotificationType? _typeFilter;

  @override
  void initState() {
    super.initState();
    _items = const MockNotificationsRepository().getNotifications();
  }

  void _markAsRead(String id) {
    setState(() {
      _items = _items
          .map((item) => item.id == id ? item.copyWith(isUnread: false) : item)
          .toList(growable: false);
    });
  }

  void _archive(String id) {
    setState(() {
      _items = _items
          .map((item) => item.id == id ? item.copyWith(isArchived: true, isUnread: false) : item)
          .toList(growable: false);
    });
  }

  void _delete(String id) {
    setState(() {
      _items = _items.where((item) => item.id != id).toList(growable: false);
    });
  }

  IconData _iconFor(NotificationType type) {
    switch (type) {
      case NotificationType.task:
        return Icons.task_alt_outlined;
      case NotificationType.project:
        return Icons.business_center_outlined;
      case NotificationType.finance:
        return Icons.account_balance_wallet_outlined;
      case NotificationType.employee:
        return Icons.badge_outlined;
      case NotificationType.system:
        return Icons.settings_suggest_outlined;
    }
  }

  String _labelFor(BuildContext context, NotificationType type) {
    final l10n = context.l10n;
    switch (type) {
      case NotificationType.task:
        return l10n.notificationsTaskReminders;
      case NotificationType.project:
        return l10n.notificationsProjectUpdates;
      case NotificationType.finance:
        return l10n.notificationsFinanceAlerts;
      case NotificationType.employee:
        return l10n.notificationsEmployeeAlerts;
      case NotificationType.system:
        return l10n.notificationsSystemAlerts;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final notifications = _items
        .where((item) => _showArchived ? item.isArchived : !item.isArchived)
        .where((item) => _typeFilter == null ? true : item.type == _typeFilter)
        .toList(growable: false);
    final unreadCount = _items.where((item) => item.isUnread && !item.isArchived).length;
    final archivedCount = _items.where((item) => item.isArchived).length;
    final visibleCount = notifications.length;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notificationsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.notificationsCenter,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(l10n.notificationsSubtitle),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    child: Text('$unreadCount'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  _CounterBadge(label: 'Непрочитано', value: unreadCount.toString()),
                  _CounterBadge(label: 'Видимых', value: visibleCount.toString()),
                  _CounterBadge(label: 'В архиве', value: archivedCount.toString()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilterChip(
                selected: _typeFilter == null,
                label: Text(l10n.filterAllStatuses),
                onSelected: (_) {
                  setState(() {
                    _typeFilter = null;
                  });
                },
              ),
              ...NotificationType.values.map(
                (type) => FilterChip(
                  selected: _typeFilter == type,
                  label: Text(_labelFor(context, type)),
                  onSelected: (_) {
                    setState(() {
                      _typeFilter = type;
                    });
                  },
                ),
              ),
              FilterChip(
                selected: _showArchived,
                label: Text(l10n.chatShowArchived),
                onSelected: (value) {
                  setState(() {
                    _showArchived = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...notifications.map(
            (item) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(_iconFor(item.type), size: 18),
                ),
                title: Row(
                  children: <Widget>[
                    Expanded(child: Text(item.title)),
                    if (item.isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 4),
                    Text(item.message),
                    const SizedBox(height: 4),
                    Text(
                      '${_labelFor(context, item.type)} • ${DateFormat.yMd(locale).add_Hm().format(item.createdAt)}',
                    ),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'read') {
                      _markAsRead(item.id);
                    } else if (value == 'archive') {
                      _archive(item.id);
                    } else if (value == 'delete') {
                      _delete(item.id);
                    }
                  },
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'read',
                      child: Text(l10n.chatMarkRead),
                    ),
                    PopupMenuItem<String>(
                      value: 'archive',
                      child: Text(l10n.chatArchive),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Text(l10n.chatDelete),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterBadge extends StatelessWidget {
  const _CounterBadge({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 2),
          Text(label, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
