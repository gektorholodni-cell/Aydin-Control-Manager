import '../../domain/entities/photo_report.dart';
import '../../domain/repositories/photo_reports_repository.dart';
import '../datasources/mock_photo_reports_data.dart';

class MockPhotoReportsRepository implements PhotoReportsRepository {
  const MockPhotoReportsRepository();

  @override
  List<PhotoReport> getPhotoReports() => mockPhotoReports;
}
