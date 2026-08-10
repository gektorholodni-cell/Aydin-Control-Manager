import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../../shared/presentation/widgets/premium_section_card.dart';
import '../../../enterprise_core/data/repositories/mock_enterprise_repository.dart';
import '../../../enterprise_core/domain/services/enterprise_service.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final service = EnterpriseService(const MockEnterpriseRepository());
    final vehicles = service.getVehicles();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.enterpriseVehiclesTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          PremiumSectionCard(
            title: l10n.enterpriseVehiclesCardTitle,
            subtitle: l10n.enterpriseVehiclesCardSubtitle,
            icon: Icons.local_shipping_outlined,
            child: Text(l10n.enterpriseVehiclesCardDescription),
          ),
          const SizedBox(height: 12),
          ...vehicles.map(
            (item) => Card(
              child: ListTile(
                leading: const Icon(Icons.directions_car_outlined),
                title: Text(item.vehicle),
                subtitle: Text(
                  '${l10n.enterpriseVehiclesDriverLabel}: ${item.driver} • '
                  '${l10n.enterpriseVehiclesMileageLabel}: ${item.mileageKm} km • '
                  '${l10n.enterpriseVehiclesFuelLabel}: ${item.fuelLevel}\n'
                  '${l10n.commonStatus}: ${item.status} • '
                  '${l10n.enterpriseVehiclesMaintenanceLabel}: ${DateFormat.yMd().format(item.maintenanceDate)}\n'
                  '${l10n.enterpriseVehiclesDocumentsLabel}',
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
