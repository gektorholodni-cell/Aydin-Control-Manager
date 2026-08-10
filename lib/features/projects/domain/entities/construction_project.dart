import '../enums/project_status.dart';

class ConstructionProject {
  const ConstructionProject({
    required this.id,
    required this.name,
    required this.client,
    required this.address,
    required this.progress,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.numberOfEmployees,
    required this.budget,
    required this.remainingBudget,
    required this.description,
    required this.currentStage,
    required this.weather,
    required this.lastActivity,
    required this.recentUpdates,
  });

  final String id;
  final String name;
  final String client;
  final String address;
  final double progress;
  final ProjectStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfEmployees;
  final double budget;
  final double remainingBudget;
  final String description;
  final String currentStage;
  final String weather;
  final String lastActivity;
  final List<String> recentUpdates;
}
