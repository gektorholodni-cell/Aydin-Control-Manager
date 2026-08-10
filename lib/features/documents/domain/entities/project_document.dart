class ProjectDocument {
  const ProjectDocument({
    required this.id,
    required this.name,
    required this.category,
    required this.type,
    required this.author,
    required this.sizeLabel,
    required this.version,
    required this.date,
  });

  final String id;
  final String name;
  final String category;
  final String type;
  final String author;
  final String sizeLabel;
  final String version;
  final DateTime date;
}
