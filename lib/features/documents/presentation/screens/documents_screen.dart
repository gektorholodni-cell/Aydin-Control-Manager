import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_documents_repository.dart';
import '../../domain/services/file_upload_service.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  bool _isUploading = false;
  final MockDocumentsRepository _repository = MockDocumentsRepository();

  IconData _typeIcon(String type) {
    switch (type) {
      case 'PDF':
        return Icons.picture_as_pdf_outlined;
      case 'DWG':
        return Icons.architecture_outlined;
      case 'XLSX':
        return Icons.table_chart_outlined;
      case 'Image':
        return Icons.image_outlined;
      case 'Document':
        return Icons.description_outlined;
      default:
        return Icons.description_outlined;
    }
  }

  String _formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.yMd(locale).format(date);
  }

  void _showDocumentPreview(BuildContext context, String title, String subtitle) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(subtitle),
              const SizedBox(height: 14),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUploadCategoryDialog() {
    final categories = [
      'Contracts',
      'Drawings (DWG)',
      'PDF',
      'Excel',
      'Reports',
      'Photos',
      'Other',
    ];

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите категорию файла'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: categories
                  .map(
                    (category) => ListTile(
                      leading: Icon(_getIconForCategory(category)),
                      title: Text(category),
                      onTap: () {
                        Navigator.pop(context);
                        _handleFileUpload(category);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
          ],
        );
      },
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Contracts':
        return Icons.description_outlined;
      case 'Drawings (DWG)':
        return Icons.architecture_outlined;
      case 'PDF':
        return Icons.picture_as_pdf_outlined;
      case 'Excel':
        return Icons.table_chart_outlined;
      case 'Reports':
        return Icons.bar_chart_outlined;
      case 'Photos':
        return Icons.image_outlined;
      case 'Other':
        return Icons.folder_outlined;
      default:
        return Icons.folder_outlined;
    }
  }

  Future<void> _handleFileUpload(String category) async {
    setState(() => _isUploading = true);

    try {
      final uploadedFile = await FileUploadService.pickAndUploadFile(category);

      if (uploadedFile != null) {
        await _repository.addUploadedFile(uploadedFile);
        setState(() {});

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Файл "${uploadedFile.name}" успешно загружен'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при загрузке файла: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final folders = _repository.getFolders();
    final documents = _repository.getRecentDocuments();
    final uploadedDocuments = _repository.getUploadedDocuments();
    final allDocuments = [...uploadedDocuments, ...documents];
    
    final pdfDocuments = allDocuments.where((doc) => doc.type == 'PDF').toList(growable: false);
    final dwgDocuments = allDocuments.where((doc) => doc.type == 'DWG').toList(growable: false);
    final spreadsheetDocuments = allDocuments.where((doc) => doc.type == 'XLSX').toList(growable: false);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.documentsTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: _isUploading ? null : _showUploadCategoryDialog,
        tooltip: 'Загрузить файл',
        child: _isUploading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          Text(
            l10n.documentsHeadline,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(l10n.documentsSubtitle),
          const SizedBox(height: 16),
          Text(
            l10n.documentsFolders,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: folders
                .map(
                  (String folder) => Chip(
                    avatar: const Icon(Icons.folder_outlined, size: 16),
                    label: Text(folder),
                  ),
                )
                .toList(growable: false),
          ),
          if (uploadedDocuments.isNotEmpty) ...[
            const SizedBox(height: 18),
            Text(
              'Загруженные файлы',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            ...uploadedDocuments.map(
              (doc) => Card(
                child: ListTile(
                  leading: Icon(_typeIcon(doc.type)),
                  title: Text(doc.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${l10n.documentsCategoryLabel}: ${doc.category}'),
                      Text('${l10n.documentsDateLabel}: ${_formatDate(context, doc.date)}'),
                      Text('${l10n.documentsSizeLabel}: ${doc.sizeLabel}'),
                    ],
                  ),
                  trailing: Chip(label: Text(doc.type)),
                  onTap: () => _showDocumentPreview(
                    context,
                    doc.name,
                    '${doc.author} · ${doc.version}',
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 18),
          Text(
            l10n.documentsRecent,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          ...documents.map(
            (doc) => Card(
              child: ListTile(
                leading: Icon(_typeIcon(doc.type)),
                title: Text(doc.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${l10n.documentsCategoryLabel}: ${doc.category}'),
                    Text('${l10n.documentsDateLabel}: ${_formatDate(context, doc.date)}'),
                    Text('${l10n.documentsAuthorLabel}: ${doc.author}'),
                    Text('${l10n.documentsSizeLabel}: ${doc.sizeLabel}'),
                    Text('${l10n.documentsVersionLabel}: ${doc.version}'),
                  ],
                ),
                trailing: Chip(label: Text(doc.type)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Быстрый доступ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: Text('PDF: ${pdfDocuments.length}'),
              subtitle: Text(
                pdfDocuments.isEmpty ? 'Нет PDF-файлов' : pdfDocuments.first.name,
              ),
              onTap: pdfDocuments.isEmpty
                  ? null
                  : () => _showDocumentPreview(
                        context,
                        pdfDocuments.first.name,
                        '${pdfDocuments.first.author} · ${pdfDocuments.first.version}',
                      ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.architecture_outlined),
              title: Text('DWG: ${dwgDocuments.length}'),
              subtitle: Text(
                dwgDocuments.isEmpty ? 'Нет DWG-чертежей' : dwgDocuments.first.name,
              ),
              onTap: dwgDocuments.isEmpty
                  ? null
                  : () => _showDocumentPreview(
                        context,
                        dwgDocuments.first.name,
                        '${dwgDocuments.first.category} · ${dwgDocuments.first.sizeLabel}',
                      ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.table_chart_outlined),
              title: Text('Excel: ${spreadsheetDocuments.length}'),
              subtitle: Text(
                spreadsheetDocuments.isEmpty ? 'Нет таблиц' : spreadsheetDocuments.first.name,
              ),
              onTap: spreadsheetDocuments.isEmpty
                  ? null
                  : () => _showDocumentPreview(
                        context,
                        spreadsheetDocuments.first.name,
                        '${spreadsheetDocuments.first.author} · ${spreadsheetDocuments.first.version}',
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
