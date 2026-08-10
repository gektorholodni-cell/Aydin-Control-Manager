import '../../domain/entities/admin_activity.dart';
import '../../domain/entities/admin_permission.dart';
import '../../domain/entities/admin_role.dart';
import '../../domain/entities/enterprise_company_profile.dart';
import '../../domain/repositories/admin_repository.dart';
import '../datasources/mock_admin_data.dart';

class MockAdminRepository implements AdminRepository {
  const MockAdminRepository();

  @override
  EnterpriseCompanyProfile getCompanyProfile() => mockCompanyProfile;

  @override
  List<String> getDepartments() => mockDepartments;

  @override
  List<String> getProjects() => mockProjects;

  @override
  List<String> getTeams() => mockTeams;

  @override
  List<String> getEmployees() => mockEmployees;

  @override
  List<AdminRole> getRoles() => mockAdminRoles;

  @override
  List<AdminActivity> getActivities() => mockAdminActivities;

  @override
  List<String> getManagementModules() => mockManagementModules;

  @override
  Set<AdminPermission> getDefaultPermissionsForRole(String roleId) {
    for (final role in mockAdminRoles) {
      if (role.id == roleId) {
        return role.permissions;
      }
    }

    return <AdminPermission>{};
  }
}
