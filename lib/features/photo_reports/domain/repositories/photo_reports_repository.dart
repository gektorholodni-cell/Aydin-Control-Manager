import '../entities/photo_report.dart';

abstract class PhotoReportsRepository {
  List<PhotoReport> getPhotoReports();
}
