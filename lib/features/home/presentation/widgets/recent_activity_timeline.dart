import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';

class RecentActivityTimeline extends StatelessWidget {
  const RecentActivityTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = <_ActivityItem>[
      _ActivityItem(
        title: l10n.activityConcreteTitle,
        detail: l10n.activityConcreteDetail,
        time: null,
        icon: Icons.precision_manufacturing_outlined,
      ),
      _ActivityItem(
        title: l10n.activitySafetyTitle,
        detail: l10n.activitySafetyDetail,
        time: null,
        icon: Icons.health_and_safety_outlined,
      ),
      _ActivityItem(
        title: l10n.activityProcurementTitle,
        detail: l10n.activityProcurementDetail,
        time: null,
        icon: Icons.local_shipping_outlined,
      ),
      _ActivityItem(
        title: l10n.activityClientTitle,
        detail: l10n.activityClientDetail,
        time: null,
        icon: Icons.forum_outlined,
      ),
    ];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: List<Widget>.generate(items.length, (int index) {
            final item = items[index];
            final isLast = index == items.length - 1;
            return _TimelineTile(item: item, isLast: isLast);
          }),
        ),
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({required this.item, required this.isLast});

  final _ActivityItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 28,
            child: Column(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    size: 15,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 52,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: colorScheme.outlineVariant,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (item.time != null) Text(item.time!, style: theme.textTheme.labelMedium),
                  ],
                ),
                const SizedBox(height: 4),
                Text(item.detail, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityItem {
  const _ActivityItem({
    required this.title,
    required this.detail,
    required this.time,
    required this.icon,
  });

  final String title;
  final String detail;
  final String? time;
  final IconData icon;
}
