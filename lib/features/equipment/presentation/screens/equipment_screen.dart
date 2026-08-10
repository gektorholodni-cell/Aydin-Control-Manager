import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../../shared/presentation/widgets/premium_section_card.dart';
import '../../../enterprise_core/data/repositories/mock_enterprise_repository.dart';
import '../../../enterprise_core/domain/services/enterprise_service.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final service = EnterpriseService(const MockEnterpriseRepository());
    final equipment = service.getEquipment();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.enterpriseEquipmentTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          PremiumSectionCard(
            title: l10n.enterpriseEquipmentCardTitle,
            subtitle: l10n.enterpriseEquipmentCardSubtitle,
            icon: Icons.precision_manufacturing_outlined,
            child: Text(l10n.enterpriseEquipmentCardDescription),
          ),
          const SizedBox(height: 12),
          ...equipment.map(
            (item) => Card(
              child: ListTile(
                leading: const Icon(Icons.construction_outlined),
                title: Text(item.name),
                subtitle: Text(
                  '${l10n.enterpriseEquipmentSerialLabel}: ${item.serialNumber} • ${item.status}\n'
                  '${l10n.commonProject}: ${item.assignedProject} • ${l10n.commonEmployee}: ${item.assignedEmployee}\n'
                  '${l10n.enterpriseEquipmentMaintenanceLabel}: ${DateFormat.yMd().format(item.maintenanceDate)} • '
                  '${l10n.enterpriseEquipmentFuelLabel} • ${l10n.enterpriseEquipmentInspectionLabel}',
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
