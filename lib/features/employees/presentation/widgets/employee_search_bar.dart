import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';

class EmployeeSearchBar extends StatelessWidget {
  const EmployeeSearchBar({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      leading: const Icon(Icons.search),
      hintText: context.l10n.employeesSearchHint,
      onChanged: onChanged,
      elevation: const WidgetStatePropertyAll<double>(0),
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
