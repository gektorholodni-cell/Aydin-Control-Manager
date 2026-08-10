class UploadedFile {
  final String name;
  final String path;
  final int sizeInBytes;
  final String category;
  final String type;
  final DateTime uploadedAt;

  UploadedFile({
    required this.name,
    required this.path,
    required this.sizeInBytes,
    required this.category,
    required this.type,
    required this.uploadedAt,
  });

  String get sizeLabel {
    if (sizeInBytes < 1024) {
      return '${sizeInBytes}B';
    } else if (sizeInBytes < 1024 * 1024) {
      return '${(sizeInBytes / 1024).toStringAsFixed(1)}KB';
    } else {
      return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
  }
}

class FileUploadService {
  static const List<String> pdfExtensions = ['pdf'];
  static const List<String> dwgExtensions = ['dwg'];
  static const List<String> excelExtensions = ['xlsx', 'xls'];
  static const List<String> imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  static const List<String> docExtensions = ['doc', 'docx', 'txt'];

  static const Map<String, String> categoryIcons = {
    'Contracts': 'contracts',
    'Drawings (DWG)': 'drawings',
    'PDF': 'pdf',
    'Excel': 'excel',
    'Reports': 'reports',
    'Photos': 'photos',
    'Other': 'other',
  };

  // Mock file upload simulation
  static Future<UploadedFile?> pickAndUploadFile(String category) async {
    // Simulate file picker delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Mock file based on category
    final mockFileName = _getMockFileNameForCategory(category);
    final mockSize = _getMockFileSizeForCategory(category);
    
    return UploadedFile(
      name: mockFileName,
      path: '/sdcard/Documents/$mockFileName',
      sizeInBytes: mockSize,
      category: category,
      type: _detectFileType(mockFileName),
      uploadedAt: DateTime.now(),
    );
  }

  static String _getMockFileNameForCategory(String category) {
    switch (category) {
      case 'Contracts':
        return 'Contract_${DateTime.now().millisecondsSinceEpoch}.pdf';
      case 'Drawings (DWG)':
        return 'Blueprint_${DateTime.now().millisecondsSinceEpoch}.dwg';
      case 'PDF':
        return 'Document_${DateTime.now().millisecondsSinceEpoch}.pdf';
      case 'Excel':
        return 'Report_${DateTime.now().millisecondsSinceEpoch}.xlsx';
      case 'Reports':
        return 'MonthlyReport_${DateTime.now().millisecondsSinceEpoch}.pdf';
      case 'Photos':
        return 'Photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      default:
        return 'File_${DateTime.now().millisecondsSinceEpoch}.bin';
    }
  }

  static int _getMockFileSizeForCategory(String category) {
    switch (category) {
      case 'Contracts':
        return 2048 * 1024; // 2 MB
      case 'Drawings (DWG)':
        return 5120 * 1024; // 5 MB
      case 'PDF':
        return 1024 * 1024; // 1 MB
      case 'Excel':
        return 512 * 1024; // 512 KB
      case 'Reports':
        return 3072 * 1024; // 3 MB
      case 'Photos':
        return 4096 * 1024; // 4 MB
      default:
        return 1024 * 100; // 100 KB
    }
  }

  static String _detectFileType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    
    if (pdfExtensions.contains(extension)) return 'PDF';
    if (dwgExtensions.contains(extension)) return 'DWG';
    if (excelExtensions.contains(extension)) return 'XLSX';
    if (imageExtensions.contains(extension)) return 'Image';
    if (docExtensions.contains(extension)) return 'Document';
    
    return 'Other';
  }
}
