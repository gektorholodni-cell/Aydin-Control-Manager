import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../../shared/presentation/widgets/premium_section_card.dart';
import '../../../enterprise_core/data/repositories/mock_enterprise_repository.dart';
import '../../../enterprise_core/domain/services/enterprise_service.dart';

class EnterpriseCalendarScreen extends StatefulWidget {
  const EnterpriseCalendarScreen({super.key});

  @override
  State<EnterpriseCalendarScreen> createState() => _EnterpriseCalendarScreenState();
}

class _EnterpriseCalendarScreenState extends State<EnterpriseCalendarScreen> {
  int _viewIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final service = EnterpriseService(const MockEnterpriseRepository());
    final events = service.getCalendarEvents();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.enterpriseCalendarTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          SegmentedButton<int>(
            segments: <ButtonSegment<int>>[
              ButtonSegment<int>(value: 0, label: Text(l10n.enterpriseCalendarViewDaily)),
              ButtonSegment<int>(value: 1, label: Text(l10n.enterpriseCalendarViewWeekly)),
              ButtonSegment<int>(value: 2, label: Text(l10n.enterpriseCalendarViewMonthly)),
            ],
            selected: <int>{_viewIndex},
            onSelectionChanged: (selection) {
              setState(() {
                _viewIndex = selection.first;
              });
            },
          ),
          const SizedBox(height: 12),
          PremiumSectionCard(
            title: l10n.enterpriseCalendarCardTitle,
            subtitle: l10n.enterpriseCalendarCardSubtitle,
            icon: Icons.calendar_month_outlined,
            child: Text(l10n.enterpriseCalendarCardDescription),
          ),
          const SizedBox(height: 12),
          ...events.map(
            (event) => Card(
              child: ListTile(
                leading: const Icon(Icons.event_note_outlined),
                title: Text(event.title),
                subtitle: Text('${event.scope} • ${DateFormat.yMd().add_Hm().format(event.date)}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
