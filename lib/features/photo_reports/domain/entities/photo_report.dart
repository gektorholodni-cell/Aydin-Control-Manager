class PhotoReport {
  const PhotoReport({
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

  int get beforeCount => beforePhotos.length;
  int get afterCount => afterPhotos.length;
}
