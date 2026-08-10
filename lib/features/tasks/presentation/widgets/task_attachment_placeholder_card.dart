import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/context_l10n.dart';

class TaskAttachmentPlaceholderCard extends StatelessWidget {
  const TaskAttachmentPlaceholderCard({
    required this.title,
    required this.description,
    required this.icon,
    this.route,
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;
  final String? route;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: colorScheme.onPrimaryContainer),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(description, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                if (route != null) {
                  context.go(route!);
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.l10n.taskAttachmentInfoAction(title))),
                );
              },
              child: Text(context.l10n.taskAttachButton),
            ),
          ],
        ),
      ),
    );
  }
}
