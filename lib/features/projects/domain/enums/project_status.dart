enum ProjectStatus {
  planning,
  onTrack,
  atRisk,
  delayed,
  completed,
}

extension ProjectStatusX on ProjectStatus {
  String get label {
    switch (this) {
      case ProjectStatus.planning:
        return 'Planning';
      case ProjectStatus.onTrack:
        return 'On Track';
      case ProjectStatus.atRisk:
        return 'At Risk';
      case ProjectStatus.delayed:
        return 'Delayed';
      case ProjectStatus.completed:
        return 'Completed';
    }
  }
}
