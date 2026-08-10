import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../chats/data/repositories/mock_chats_repository.dart';
import '../../../documents/data/repositories/mock_documents_repository.dart';
import '../../../employees/data/repositories/mock_employee_repository.dart';
import '../../../enterprise_core/data/repositories/mock_enterprise_repository.dart';
import '../../../enterprise_core/domain/services/enterprise_service.dart';
import '../../../projects/data/repositories/mock_project_repository.dart';
import '../../../tasks/data/repositories/mock_task_repository.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final query = _controller.text.trim().toLowerCase();
    final enterpriseService = EnterpriseService(const MockEnterpriseRepository());

    final projects = const MockProjectRepository()
        .getProjects()
        .where((project) => _matches(project.name, query))
        .map((project) => _ResultItem(title: project.name, subtitle: project.client))
        .toList(growable: false);

    final employees = const MockEmployeeRepository()
        .getEmployees()
        .where((employee) => _matches(employee.fullName, query))
        .map((employee) => _ResultItem(title: employee.fullName, subtitle: employee.position))
        .toList(growable: false);

    final tasks = const MockTaskRepository()
        .getTasks()
        .where((task) => _matches(task.title, query) || _matches(task.project, query))
        .map((task) => _ResultItem(title: task.title, subtitle: task.project))
        .toList(growable: false);

    final chats = const MockChatsRepository()
        .getThreads()
        .where((thread) => _matches(thread.title, query) || _matches(thread.lastMessage, query))
        .map((thread) => _ResultItem(title: thread.title, subtitle: thread.lastMessage))
        .toList(growable: false);

    final documents = MockDocumentsRepository()
        .getRecentDocuments()
        .where((doc) => _matches(doc.name, query) || _matches(doc.category, query))
        .map((doc) => _ResultItem(title: doc.name, subtitle: doc.category))
        .toList(growable: false);

    final reports = enterpriseService
      .getReports()
      .where((report) => _matches(report.title, query) || _matches(report.type, query))
      .map((report) => _ResultItem(title: report.title, subtitle: report.type))
      .toList(growable: false);

    final photos = const MockEnterpriseRepository()
      .getPhotoReports()
      .where((report) => _matches(report.title, query))
      .map(
        (report) => _ResultItem(
          title: report.title,
          subtitle: l10n.globalSearchPhotosCount(report.photosCount),
        ),
      )
      .toList(growable: false);

    final equipment = enterpriseService
      .getEquipment()
      .where((item) => _matches(item.name, query) || _matches(item.serialNumber, query))
      .map((item) => _ResultItem(title: item.name, subtitle: item.status))
      .toList(growable: false);

    final vehicles = enterpriseService
      .getVehicles()
      .where((item) => _matches(item.vehicle, query) || _matches(item.driver, query))
      .map((item) => _ResultItem(title: item.vehicle, subtitle: item.driver))
      .toList(growable: false);

    final warehouse = enterpriseService
      .getWarehouseItems()
      .where((item) => _matches(item.name, query) || _matches(item.category, query))
      .map((item) => _ResultItem(title: item.name, subtitle: item.category))
      .toList(growable: false);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.globalSearchTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          TextField(
            controller: _controller,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: l10n.globalSearchHint,
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          _ResultSection(title: l10n.projectsTitle, items: projects, query: query),
          _ResultSection(title: l10n.employeesTitle, items: employees, query: query),
          _ResultSection(title: l10n.tasksTitle, items: tasks, query: query),
          _ResultSection(title: l10n.chatsTitle, items: chats, query: query),
          _ResultSection(title: l10n.documentsTitle, items: documents, query: query),
          _ResultSection(title: l10n.reportsModuleTitle, items: reports, query: query),
          _ResultSection(title: l10n.photoReportsTitle, items: photos, query: query),
          _ResultSection(title: l10n.enterpriseEquipmentTitle, items: equipment, query: query),
          _ResultSection(title: l10n.enterpriseVehiclesTitle, items: vehicles, query: query),
          _ResultSection(title: l10n.enterpriseWarehouseTitle, items: warehouse, query: query),
        ],
      ),
    );
  }

  bool _matches(String source, String query) {
    if (query.isEmpty) {
      return false;
    }
    return source.toLowerCase().contains(query);
  }
}

class _ResultSection extends StatelessWidget {
  const _ResultSection({
    required this.title,
    required this.items,
    required this.query,
  });

  final String title;
  final List<_ResultItem> items;
  final String query;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 6),
              if (query.isEmpty)
                Text(l10n.globalSearchStartTyping)
              else if (items.isEmpty)
                Text(l10n.globalSearchNoResults)
              else
                ...items.map(
                  (item) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.search_outlined),
                    title: Text(item.title),
                    subtitle: Text(item.subtitle),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultItem {
  const _ResultItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;
}
