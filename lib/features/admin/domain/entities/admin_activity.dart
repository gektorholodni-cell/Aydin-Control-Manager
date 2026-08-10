class AdminActivity {
  const AdminActivity({
    required this.id,
    required this.actor,
    required this.action,
    required this.createdAt,
  });

  final String id;
  final String actor;
  final String action;
  final DateTime createdAt;
}
