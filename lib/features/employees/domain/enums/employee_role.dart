enum EmployeeRole {
  director,
  projectManager,
  siteEngineer,
  foreman,
  surveyor,
  safetyEngineer,
  accountant,
  storekeeper,
  worker,
}

extension EmployeeRoleX on EmployeeRole {
  String get label {
    switch (this) {
      case EmployeeRole.director:
        return 'Director';
      case EmployeeRole.projectManager:
        return 'Project Manager';
      case EmployeeRole.siteEngineer:
        return 'Site Engineer';
      case EmployeeRole.foreman:
        return 'Foreman';
      case EmployeeRole.surveyor:
        return 'Surveyor';
      case EmployeeRole.safetyEngineer:
        return 'Safety Engineer';
      case EmployeeRole.accountant:
        return 'Accountant';
      case EmployeeRole.storekeeper:
        return 'Storekeeper';
      case EmployeeRole.worker:
        return 'Worker';
    }
  }
}
