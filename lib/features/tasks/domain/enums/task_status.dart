enum TaskStatus {
  notStarted,
  inProgress,
  waiting,
  inspection,
  completed,
}

extension TaskStatusX on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.notStarted:
        return 'Not Started';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.waiting:
        return 'Waiting';
      case TaskStatus.inspection:
        return 'Inspection';
      case TaskStatus.completed:
        return 'Completed';
    }
  }
}
