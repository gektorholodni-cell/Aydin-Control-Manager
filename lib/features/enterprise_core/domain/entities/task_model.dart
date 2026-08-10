class EnterpriseTask {
  const EnterpriseTask({
    required this.id,
    required this.projectId,
    required this.title,
    required this.assignee,
    required this.deadline,
    required this.status,
  });

  final String id;
  final String projectId;
  final String title;
  final String assignee;
  final DateTime deadline;
  final String status;
}
