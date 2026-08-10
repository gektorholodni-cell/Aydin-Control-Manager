import '../../domain/entities/admin_activity.dart';
import '../../domain/entities/admin_permission.dart';
import '../../domain/entities/admin_role.dart';
import '../../domain/entities/enterprise_company_profile.dart';

const mockCompanyProfile = EnterpriseCompanyProfile(
  logoText: '',
  companyName: '',
  bin: '',
  phone: '',
  email: '',
  website: '',
  address: '',
  workingHours: '',
  timezone: 'UTC',
  language: 'English',
  currency: 'USD',
  measurementSystem: 'Metric',
  isSuspended: false,
  isArchived: false,
);

const mockDepartments = <String>[];

const mockProjects = <String>[];

const mockTeams = <String>[];

const mockEmployees = <String>[];

final mockAdminRoles = <AdminRole>[
  AdminRole(
    id: 'owner',
    title: 'Owner',
    permissions: AdminPermission.values.toSet(),
  ),
  AdminRole(
    id: 'administrator',
    title: 'Administrator',
    permissions: AdminPermission.values.toSet(),
  ),
  AdminRole(
    id: 'projectManager',
    title: 'Project Manager',
    permissions: <AdminPermission>{
      AdminPermission.viewProjects,
      AdminPermission.editProjects,
      AdminPermission.createTasks,
      AdminPermission.completeTasks,
      AdminPermission.uploadDocuments,
      AdminPermission.manageEmployees,
      AdminPermission.manageChats,
      AdminPermission.manageReports,
    },
  ),
  AdminRole(
    id: 'siteEngineer',
    title: 'Site Engineer',
    permissions: <AdminPermission>{
      AdminPermission.viewProjects,
      AdminPermission.createTasks,
      AdminPermission.completeTasks,
      AdminPermission.uploadDocuments,
      AdminPermission.manageReports,
    },
  ),
  AdminRole(
    id: 'foreman',
    title: 'Foreman',
    permissions: <AdminPermission>{
      AdminPermission.viewProjects,
      AdminPermission.createTasks,
      AdminPermission.completeTasks,
      AdminPermission.manageChats,
    },
  ),
  AdminRole(
    id: 'accountant',
    title: 'Accountant',
    permissions: <AdminPermission>{
      AdminPermission.viewFinance,
      AdminPermission.editFinance,
      AdminPermission.viewProjects,
      AdminPermission.manageReports,
    },
  ),
  AdminRole(
    id: 'storekeeper',
    title: 'Storekeeper',
    permissions: <AdminPermission>{
      AdminPermission.viewProjects,
      AdminPermission.uploadDocuments,
      AdminPermission.manageChats,
    },
  ),
  AdminRole(
    id: 'safetyEngineer',
    title: 'Safety Engineer',
    permissions: <AdminPermission>{
      AdminPermission.viewProjects,
      AdminPermission.completeTasks,
      AdminPermission.uploadDocuments,
      AdminPermission.manageReports,
    },
  ),
  AdminRole(
    id: 'worker',
    title: 'Worker',
    permissions: <AdminPermission>{
      AdminPermission.viewProjects,
      AdminPermission.completeTasks,
      AdminPermission.manageChats,
    },
  ),
  AdminRole(
    id: 'viewer',
    title: 'Viewer',
    permissions: <AdminPermission>{
      AdminPermission.viewProjects,
      AdminPermission.viewFinance,
      AdminPermission.manageReports,
    },
  ),
];

final mockAdminActivities = <AdminActivity>[];

const mockManagementModules = <String>[
  'Manage Employees',
  'Manage Roles',
  'Manage Permissions',
  'Manage Departments',
  'Manage Chats',
  'Manage Documents',
  'Manage Finances',
  'Manage Reports',
  'View Dashboard',
];
