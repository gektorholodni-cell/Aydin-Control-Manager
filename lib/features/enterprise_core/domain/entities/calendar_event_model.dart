class EnterpriseCalendarEvent {
  const EnterpriseCalendarEvent({
    required this.id,
    required this.scope,
    required this.title,
    required this.date,
  });

  final String id;
  final String scope;
  final String title;
  final DateTime date;
}
