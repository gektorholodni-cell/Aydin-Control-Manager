import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/backend/cloud_backend.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../../projects/data/repositories/mock_project_repository.dart';
import '../../data/datasources/mock_photo_reports_data.dart';
import '../../data/repositories/mock_photo_reports_repository.dart';
import '../../domain/entities/photo_report.dart';

class PhotoReportsScreen extends StatefulWidget {
  const PhotoReportsScreen({super.key});

  @override
  State<PhotoReportsScreen> createState() => _PhotoReportsScreenState();
}

class _PhotoReportsScreenState extends State<PhotoReportsScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  late List<_AlbumModel> _albums;
  bool _isUploading = false;

  bool get _isCloud => CloudBackend.instance.hasSession;

  @override
  void initState() {
    super.initState();
    _albums = const MockPhotoReportsRepository()
        .getPhotoReports()
        .map((PhotoReport report) => _AlbumModel.fromReport(report))
        .toList(growable: true);
  }

  String _formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.yMMMd(locale).format(date);
  }

  String _formatTime(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.Hm(locale).format(date);
  }

  int _countBeforePhotos() {
    return _albums.fold<int>(0, (int total, _AlbumModel album) => total + album.beforePhotos.length);
  }

  int _countAfterPhotos() {
    return _albums.fold<int>(0, (int total, _AlbumModel album) => total + album.afterPhotos.length);
  }

  int _countUniqueProjects() {
    return _albums.map((_AlbumModel album) => album.projectName).toSet().length;
  }

  int _countUniqueEmployees() {
    return _albums.map((_AlbumModel album) => album.employeeName).toSet().length;
  }

  Future<void> _createAlbum() async {
    final l10n = context.l10n;
    final controller = TextEditingController();
    final title = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.photoReportsCreateAlbum),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: l10n.commonTitle),
          ),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.commonBackToChat)),
            FilledButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: Text(l10n.photoReportsCreateAlbum),
            ),
          ],
        );
      },
    );
    if (title == null || title.isEmpty) {
      return;
    }

    final projects = const MockProjectRepository().getProjects();
    final membership = CloudBackend.instance.membership;
    final album = _AlbumModel(
      id: 'alb-${DateTime.now().microsecondsSinceEpoch}',
      albumName: title,
      projectName: projects.isNotEmpty ? projects.first.name : '—',
      taskName: '—',
      employeeName: membership?.fullName ?? 'Project Team',
      description: '',
      dateTime: DateTime.now(),
      locationPlaceholder: projects.isNotEmpty ? projects.first.address : '—',
      beforePhotos: <String>[],
      afterPhotos: <String>[],
    );

    if (!await _persist(album)) {
      return;
    }
    mockPhotoReports.insert(0, album.toReport());
    setState(() {
      _albums.insert(0, album);
    });
  }

  /// Сохраняет альбом на сервере (в облачном режиме) и в локальном списке.
  Future<bool> _persist(_AlbumModel album) async {
    try {
      await CloudBackend.instance.savePhotoReport(album.toReport());
    } catch (error) {
      _showMessage('Не удалось сохранить фотоотчёт: $error');
      return false;
    }
    final index = mockPhotoReports.indexWhere((PhotoReport report) => report.id == album.id);
    if (index != -1) {
      mockPhotoReports[index] = album.toReport();
    }
    return true;
  }

  void _showMessage(String text) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _replaceAlbum(_AlbumModel updated) {
    setState(() {
      _albums = _albums
          .map((_AlbumModel album) => album.id == updated.id ? updated : album)
          .toList(growable: true);
    });
  }

  Future<String?> _pickAndUploadPhoto(String albumId) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Сделать фото'),
                onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Выбрать из галереи'),
                onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
    if (source == null) {
      return null;
    }
    final file = await _imagePicker.pickImage(
      source: source,
      maxWidth: 1920,
      imageQuality: 80,
    );
    if (file == null) {
      return null;
    }
    final dot = file.name.lastIndexOf('.');
    final extension = dot == -1 ? 'jpg' : file.name.substring(dot + 1);
    return CloudBackend.instance.uploadPhoto(
      reportId: albumId,
      bytes: await file.readAsBytes(),
      fileExtension: extension,
    );
  }

  Future<void> _addPhoto(String albumId, bool before) async {
    if (_isCloud) {
      await _addCloudPhoto(albumId, before);
      return;
    }
    setState(() {
      _albums = _albums.map((_AlbumModel album) {
        if (album.id != albumId) {
          return album;
        }
        final updatedBefore = List<String>.from(album.beforePhotos);
        final updatedAfter = List<String>.from(album.afterPhotos);
        if (before) {
          updatedBefore.add('before_${updatedBefore.length + 1}.jpg');
        } else {
          updatedAfter.add('after_${updatedAfter.length + 1}.jpg');
        }
        return album.copyWith(beforePhotos: updatedBefore, afterPhotos: updatedAfter);
      }).toList(growable: true);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Фото добавлено в альбом')),
    );
  }

  Future<void> _addCloudPhoto(String albumId, bool before) async {
    if (_isUploading) {
      return;
    }
    setState(() => _isUploading = true);
    try {
      final path = await _pickAndUploadPhoto(albumId);
      if (path == null || !mounted) {
        return;
      }
      final album = _albums.firstWhere((_AlbumModel item) => item.id == albumId);
      final updated = album.copyWith(
        beforePhotos: before ? <String>[...album.beforePhotos, path] : null,
        afterPhotos: before ? null : <String>[...album.afterPhotos, path],
      );
      if (await _persist(updated)) {
        _replaceAlbum(updated);
        _showMessage('Фото добавлено в альбом');
      }
    } catch (error) {
      _showMessage('Не удалось загрузить фото: $error');
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  Future<void> _deletePhoto(String albumId, bool before) async {
    if (_isCloud) {
      final album = _albums.firstWhere((_AlbumModel item) => item.id == albumId);
      final photos = before ? album.beforePhotos : album.afterPhotos;
      if (photos.isEmpty) {
        return;
      }
      final removed = photos.last;
      final remaining = photos.sublist(0, photos.length - 1);
      final updated = album.copyWith(
        beforePhotos: before ? remaining : null,
        afterPhotos: before ? null : remaining,
      );
      if (await _persist(updated)) {
        _replaceAlbum(updated);
        CloudBackend.instance.deletePhoto(removed).catchError((Object _) {});
      }
      return;
    }
    setState(() {
      _albums = _albums.map((_AlbumModel album) {
        if (album.id != albumId) {
          return album;
        }
        final updatedBefore = List<String>.from(album.beforePhotos);
        final updatedAfter = List<String>.from(album.afterPhotos);
        if (before && updatedBefore.isNotEmpty) {
          updatedBefore.removeLast();
        }
        if (!before && updatedAfter.isNotEmpty) {
          updatedAfter.removeLast();
        }
        return album.copyWith(beforePhotos: updatedBefore, afterPhotos: updatedAfter);
      }).toList(growable: true);
    });
  }

  void _previewPhotos(_AlbumModel album) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.l10n.photoReportsPreviewTitle),
          content: SizedBox(
            width: 420,
            child: _isCloud
                ? SingleChildScrollView(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        ...album.beforePhotos.map((p) => _CloudPhoto(path: p, label: 'ДО')),
                        ...album.afterPhotos.map((p) => _CloudPhoto(path: p, label: 'ПОСЛЕ')),
                      ],
                    ),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      ...album.beforePhotos.map((p) => _photoChip(context, 'BEFORE: $p')),
                      ...album.afterPhotos.map((p) => _photoChip(context, 'AFTER: $p')),
                    ],
                  ),
          ),
          actions: <Widget>[
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.commonBackToChat),
            ),
          ],
        );
      },
    );
  }

  Widget _photoChip(BuildContext context, String text) {
    return Chip(
      avatar: const Icon(Icons.image_outlined, size: 16),
      label: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final beforePhotoCount = _countBeforePhotos();
    final afterPhotoCount = _countAfterPhotos();
    final albumCount = _albums.length;
    final projectCount = _countUniqueProjects();
    final employeeCount = _countUniqueEmployees();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.photoReportsTitle),
        bottom: _isUploading
            ? const PreferredSize(
                preferredSize: Size.fromHeight(4),
                child: LinearProgressIndicator(),
              )
            : null,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createAlbum,
        icon: const Icon(Icons.add_photo_alternate_outlined),
        label: Text(l10n.photoReportsCreateAlbum),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          Text(
            l10n.photoReportsHeadline,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(l10n.photoReportsSubtitle),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _SummaryTile(
                label: 'Альбомы',
                value: albumCount.toString(),
                icon: Icons.photo_library_outlined,
              ),
              _SummaryTile(
                label: 'Проекты',
                value: projectCount.toString(),
                icon: Icons.business_outlined,
              ),
              _SummaryTile(
                label: 'До фото',
                value: beforePhotoCount.toString(),
                icon: Icons.photo_camera_outlined,
              ),
              _SummaryTile(
                label: 'После фото',
                value: afterPhotoCount.toString(),
                icon: Icons.photo_outlined,
              ),
              _SummaryTile(
                label: 'Сотрудники',
                value: employeeCount.toString(),
                icon: Icons.groups_2_outlined,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_albums.isNotEmpty)
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.timeline_outlined),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Последний альбом',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(_albums.first.albumName),
                          Text(
                            '${_albums.first.projectName} · ${_albums.first.employeeName}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 14),
          ..._albums.map(
            (album) => Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      album.albumName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text('${l10n.commonProject}: ${album.projectName}'),
                    Text('${l10n.commonEmployee}: ${album.employeeName}'),
                    Text('${l10n.photoReportsTaskLabel}: ${album.taskName}'),
                    Text('${l10n.photoReportsDate}: ${_formatDate(context, album.dateTime)}'),
                    Text('${l10n.photoReportsTimeLabel}: ${_formatTime(context, album.dateTime)}'),
                    Text('${l10n.photoReportsLocationLabel}: ${album.locationPlaceholder}'),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _CountTile(
                            icon: Icons.photo_camera_outlined,
                            label: l10n.taskBeforePhotos,
                            count: album.beforePhotos.length,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _CountTile(
                            icon: Icons.photo_outlined,
                            label: l10n.taskAfterPhotos,
                            count: album.afterPhotos.length,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('${l10n.commonDescription}: ${album.description}'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        OutlinedButton.icon(
                          onPressed: () => _addPhoto(album.id, true),
                          icon: const Icon(Icons.add_a_photo_outlined),
                          label: Text(l10n.photoReportsAddBefore),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _addPhoto(album.id, false),
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          label: Text(l10n.photoReportsAddAfter),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _deletePhoto(album.id, true),
                          icon: const Icon(Icons.delete_outline),
                          label: Text(l10n.photoReportsDeleteBefore),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _deletePhoto(album.id, false),
                          icon: const Icon(Icons.delete_sweep_outlined),
                          label: Text(l10n.photoReportsDeleteAfter),
                        ),
                        FilledButton.tonalIcon(
                          onPressed: () => _previewPhotos(album),
                          icon: const Icon(Icons.visibility_outlined),
                          label: Text(l10n.photoReportsPreviewTitle),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              Icon(icon),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(label, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlbumModel {
  const _AlbumModel({
    required this.id,
    required this.albumName,
    required this.projectName,
    required this.taskName,
    required this.employeeName,
    required this.description,
    required this.dateTime,
    required this.locationPlaceholder,
    required this.beforePhotos,
    required this.afterPhotos,
  });

  final String id;
  final String albumName;
  final String projectName;
  final String taskName;
  final String employeeName;
  final String description;
  final DateTime dateTime;
  final String locationPlaceholder;
  final List<String> beforePhotos;
  final List<String> afterPhotos;

  factory _AlbumModel.fromReport(PhotoReport report) {
    return _AlbumModel(
      id: report.id,
      albumName: report.albumName,
      projectName: report.projectName,
      taskName: report.taskName,
      employeeName: report.employeeName,
      description: report.description,
      dateTime: report.dateTime,
      locationPlaceholder: report.locationPlaceholder,
      beforePhotos: report.beforePhotos,
      afterPhotos: report.afterPhotos,
    );
  }

  PhotoReport toReport() {
    return PhotoReport(
      id: id,
      albumName: albumName,
      projectName: projectName,
      taskName: taskName,
      employeeName: employeeName,
      description: description,
      dateTime: dateTime,
      locationPlaceholder: locationPlaceholder,
      beforePhotos: beforePhotos,
      afterPhotos: afterPhotos,
    );
  }

  _AlbumModel copyWith({
    List<String>? beforePhotos,
    List<String>? afterPhotos,
  }) {
    return _AlbumModel(
      id: id,
      albumName: albumName,
      projectName: projectName,
      taskName: taskName,
      employeeName: employeeName,
      description: description,
      dateTime: dateTime,
      locationPlaceholder: locationPlaceholder,
      beforePhotos: beforePhotos ?? this.beforePhotos,
      afterPhotos: afterPhotos ?? this.afterPhotos,
    );
  }
}

class _CountTile extends StatelessWidget {
  const _CountTile({
    required this.icon,
    required this.label,
    required this.count,
  });

  final IconData icon;
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text('$label: $count')),
        ],
      ),
    );
  }
}

/// Миниатюра фото из облачного хранилища.
class _CloudPhoto extends StatelessWidget {
  const _CloudPhoto({required this.path, required this.label});

  final String path;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox.square(
        dimension: 120,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FutureBuilder<String>(
              future: CloudBackend.instance.photoUrl(path),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                final url = snapshot.data;
                if (url == null) {
                  return ColoredBox(
                    color: colorScheme.surfaceContainerHigh,
                    child: Center(
                      child: snapshot.hasError
                          ? const Icon(Icons.broken_image_outlined)
                          : const CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }
                return Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(Icons.broken_image_outlined),
                );
              },
            ),
            Positioned(
              left: 6,
              top: 6,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.inverseSurface.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  child: Text(
                    label,
                    style: TextStyle(color: colorScheme.onInverseSurface, fontSize: 11),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
