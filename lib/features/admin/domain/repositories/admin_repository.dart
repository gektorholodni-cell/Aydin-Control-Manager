import '../entities/admin_activity.dart';
import '../entities/admin_permission.dart';
import '../entities/admin_role.dart';
import '../entities/enterprise_company_profile.dart';

abstract interface class AdminRepository {
  EnterpriseCompanyProfile getCompanyProfile();

  List<String> getDepartments();
  List<String> getProjects();
  List<String> getTeams();
  List<String> getEmployees();

  List<AdminRole> getRoles();

  List<AdminActivity> getActivities();

  List<String> getManagementModules();

  Set<AdminPermission> getDefaultPermissionsForRole(String roleId);
}
