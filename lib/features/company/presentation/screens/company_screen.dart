import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_company_repository.dart';
import '../widgets/company_card.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
