class EnterpriseDrawing {
  const EnterpriseDrawing({
    required this.id,
    required this.category,
    required this.title,
    required this.project,
    required this.version,
    required this.date,
    required this.author,
    required this.status,
  });

  final String id;
  final String category;
  final String title;
  final String project;
  final String version;
  final DateTime date;
  final String author;
  final String status;
}
