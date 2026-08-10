import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../../shared/presentation/widgets/premium_section_card.dart';
import '../../../enterprise_core/data/repositories/mock_enterprise_repository.dart';
import '../../../enterprise_core/domain/services/enterprise_service.dart';

class WarehouseScreen extends StatelessWidget {
  const WarehouseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final service = EnterpriseService(const MockEnterpriseRepository());
    final items = service.getWarehouseItems();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.enterpriseWarehouseTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          PremiumSectionCard(
            title: l10n.enterpriseWarehouseCardTitle,
            subtitle: l10n.enterpriseWarehouseCardSubtitle,
            icon: Icons.warehouse_outlined,
            child: Text(l10n.enterpriseWarehouseCardDescription),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Card(
              child: ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text('${item.name} (${item.category})'),
                subtitle: Text(
                  '${l10n.enterpriseWarehouseCurrentLabel}: ${item.currentQuantity} • '
                  '${l10n.enterpriseWarehouseMinimumLabel}: ${item.minimumQuantity}\n'
                  '${l10n.enterpriseWarehouseIncomingLabel}: ${item.incoming} • '
                  '${l10n.enterpriseWarehouseOutgoingLabel}: ${item.outgoing} • '
                  '${l10n.enterpriseWarehouseHistoryLabel}',
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
