import '../entities/project_document.dart';
import '../services/file_upload_service.dart';

abstract class DocumentsRepository {
  List<String> getFolders();
  List<ProjectDocument> getRecentDocuments();
  List<ProjectDocument> getUploadedDocuments();
  Future<void> addUploadedFile(UploadedFile file);
  Future<void> deleteDocument(String id);
}
