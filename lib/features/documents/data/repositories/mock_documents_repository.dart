import '../../domain/entities/project_document.dart';
import '../../domain/repositories/documents_repository.dart';
import '../../domain/services/file_upload_service.dart';
import '../datasources/mock_documents_data.dart';

class MockDocumentsRepository implements DocumentsRepository {
  static final MockDocumentsRepository _instance = MockDocumentsRepository._internal();
  
  final List<ProjectDocument> _uploadedDocuments = [];

  factory MockDocumentsRepository() {
    return _instance;
  }

  MockDocumentsRepository._internal();

  @override
  List<String> getFolders() => mockDocumentFolders;

  @override
  List<ProjectDocument> getRecentDocuments() => mockRecentDocuments;

  @override
  List<ProjectDocument> getUploadedDocuments() => _uploadedDocuments;

  @override
  Future<void> addUploadedFile(UploadedFile file) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate upload delay
    
    final newDocument = ProjectDocument(
      id: 'uploaded_${DateTime.now().millisecondsSinceEpoch}',
      name: file.name,
      category: file.category,
      type: file.type,
      date: file.uploadedAt,
      author: 'You',
      sizeLabel: file.sizeLabel,
      version: '1.0',
    );
    
    _uploadedDocuments.insert(0, newDocument);
  }

  @override
  Future<void> deleteDocument(String id) async {
    _uploadedDocuments.removeWhere((doc) => doc.id == id);
  }
}
