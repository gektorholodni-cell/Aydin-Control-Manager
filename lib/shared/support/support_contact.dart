import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Контакты техподдержки Structra.
abstract final class SupportContact {
  static const phoneDisplay = '+7 747 741 83 79';
  static const phoneE164 = '+77477418379';

  static Future<void> call() => _open(Uri(scheme: 'tel', path: phoneE164));

  static Future<void> whatsApp() =>
      _open(Uri.parse('https://wa.me/${phoneE164.substring(1)}'));

  static Future<void> _open(Uri uri) async {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

/// Звонок на любой номер (например, сотруднику).
Future<void> callPhone(String phone) async {
  final digits = phone.replaceAll(RegExp(r'[^0-9+]'), '');
  if (digits.isEmpty) {
    return;
  }
  await launchUrl(Uri(scheme: 'tel', path: digits), mode: LaunchMode.externalApplication);
}

/// Карточка «Техподдержка» с кнопками звонка и WhatsApp.
class SupportCard extends StatelessWidget {
  const SupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.support_agent, color: colorScheme.primary),
                const SizedBox(width: 10),
                Text(
                  'Техподдержка',
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(SupportContact.phoneDisplay, style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('Поможем с настройкой и ответим на вопросы', style: textTheme.bodySmall),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: FilledButton.icon(
                    onPressed: SupportContact.call,
                    icon: const Icon(Icons.call),
                    label: const Text('Позвонить'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: SupportContact.whatsApp,
                    icon: const Icon(Icons.chat_outlined),
                    label: const Text('WhatsApp'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
