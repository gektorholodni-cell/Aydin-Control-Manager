import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_company_repository.dart';

class CompanyDetailsScreen extends StatelessWidget {
  const CompanyDetailsScreen({
    required this.companyId,
    super.key,
  });

  final String companyId;

  @override
  Widget build(BuildContext context) {
    final company = const MockCompanyRepository().getCompanyById(companyId);

    if (company == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.companyTitle)),
        body: Center(
          child: Text(context.l10n.companyNotFound),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(company.name)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          _InfoCard(
            title: context.l10n.companyContacts,
            children: <Widget>[
              _InfoRow(label: context.l10n.projectFieldAddress, value: company.address),
              _InfoRow(label: context.l10n.commonPhone, value: company.phone),
              _InfoRow(label: context.l10n.commonEmail, value: company.email),
            ],
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: context.l10n.projectsTitle,
            children: company.projects
                .map((String item) => _BulletRow(value: item))
                .toList(growable: false),
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: context.l10n.employeesTitle,
            children: company.employees
                .map((String item) => _BulletRow(value: item))
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.labelMedium),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 8),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
