import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../../shared/presentation/widgets/premium_section_card.dart';
import '../../../enterprise_core/data/repositories/mock_enterprise_repository.dart';
import '../../../enterprise_core/domain/services/enterprise_service.dart';

class DrawingsScreen extends StatelessWidget {
  const DrawingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final service = EnterpriseService(const MockEnterpriseRepository());
    final drawings = service.getDrawings();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.enterpriseDrawingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          PremiumSectionCard(
            title: l10n.enterpriseDrawingsCardTitle,
            subtitle: l10n.enterpriseDrawingsCardSubtitle,
            icon: Icons.draw_outlined,
            child: Text(l10n.enterpriseDrawingsCardDescription),
          ),
          const SizedBox(height: 12),
          ...drawings.map(
            (drawing) => Card(
              child: ListTile(
                leading: const Icon(Icons.layers_outlined),
                title: Text('${drawing.title} (${drawing.category})'),
                subtitle: Text(
                  '${drawing.project} • ${drawing.version} • ${DateFormat.yMd().format(drawing.date)}\n'
                  '${l10n.enterpriseDrawingsAuthorLabel}: ${drawing.author} • ${l10n.commonStatus}: ${drawing.status}\n'
                  '${l10n.enterpriseDrawingsActionsLabel}',
                ),
                isThreeLine: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
