class EnterpriseUser {
  const EnterpriseUser({
    required this.id,
    required this.fullName,
    required this.position,
    required this.departmentId,
    required this.teamId,
    required this.isOnline,
  });

  final String id;
  final String fullName;
  final String position;
  final String departmentId;
  final String teamId;
  final bool isOnline;
}
