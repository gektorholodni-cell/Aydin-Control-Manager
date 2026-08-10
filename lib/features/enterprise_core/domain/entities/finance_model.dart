class EnterpriseFinanceRecord {
  const EnterpriseFinanceRecord({
    required this.id,
    required this.projectId,
    required this.type,
    required this.amount,
    required this.createdAt,
  });

  final String id;
  final String projectId;
  final String type;
  final double amount;
  final DateTime createdAt;
}
