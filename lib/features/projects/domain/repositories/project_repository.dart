import '../entities/construction_project.dart';

abstract interface class ProjectRepository {
  List<ConstructionProject> getProjects();

  ConstructionProject? getProjectById(String id);
}
