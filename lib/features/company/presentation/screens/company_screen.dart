import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/backend/cloud_backend.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_company_repository.dart';
import '../widgets/company_card.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final membership = CloudBackend.instance.membership;
    if (membership != null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.companyTitle)),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: <Widget>[_MyCompanyCard(membership: membership)],
        ),
      );
    }

    final companies = const MockCompanyRepository().getCompanies();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.companyTitle)),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        itemCount: companies.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (BuildContext context, int index) {
          final company = companies[index];
          return CompanyCard(
            company: company,
            onTap: () => context.go('${AppRoutes.company}/${company.id}'),
          );
        },
      ),
    );
  }
}

class _MyCompanyCard extends StatelessWidget {
  const _MyCompanyCard({required this.membership});

  final CompanyMembership membership;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              membership.companyName,
              style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(membership.fullName, style: textTheme.bodyMedium),
            const SizedBox(height: 20),
            Text('Код приглашения для сотрудников', style: textTheme.titleSmall),
            const SizedBox(height: 6),
            Row(
              children: <Widget>[
                Expanded(
                  child: SelectableText(
                    membership.inviteCode,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Скопировать',
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: membership.inviteCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Код скопирован')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Сотрудник устанавливает приложение, регистрируется по своей почте, '
              'выбирает «Присоединиться» и вводит этот код.',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
