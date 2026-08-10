import '../../domain/entities/construction_project.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/mock_projects_data.dart';

class MockProjectRepository implements ProjectRepository {
  const MockProjectRepository();

  @override
  List<ConstructionProject> getProjects() {
    return mockProjects;
  }

  @override
  ConstructionProject? getProjectById(String id) {
    for (final project in mockProjects) {
      if (project.id == id) {
        return project;
      }
    }
    return null;
  }

  void addProject(ConstructionProject project) {
    mockProjects.insert(0, project);
  }
}
