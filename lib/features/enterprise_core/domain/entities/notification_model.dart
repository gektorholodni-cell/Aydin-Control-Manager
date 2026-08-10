class EnterpriseNotification {
  const EnterpriseNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.isUnread,
  });

  final String id;
  final String type;
  final String title;
  final bool isUnread;
}
