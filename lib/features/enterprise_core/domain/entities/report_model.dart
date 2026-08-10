class EnterpriseReport {
  const EnterpriseReport({
    required this.id,
    required this.type,
    required this.title,
    required this.createdAt,
  });

  final String id;
  final String type;
  final String title;
  final DateTime createdAt;
}
